unit Core.Configuration;

interface

uses
  System.JSON, System.IOUtils, System.SysUtils, REST.Json,
  Connection.PostgreSQL.Configuration,
  Connection.Redis.Configuration,
  Connection.RabbitMQ.Configuration;

type
  TConnectionType = (ctSTOMP, ctAMQP);

  IConfiguration = interface
    function PostgreSQL: IPostgreSQLConfig;
    function Redis: IRedisConfig;
    function RabbitMQ(AConnectionType: TConnectionType): IRabbitMQConfig;
  end;

  TConfiguration = class(TInterfacedObject, IConfiguration)
  private
    FPostgreSQL: IPostgreSQLConfig;
    FRedis: IRedisConfig;
    FRabbitMQStomp,
    FRabbitMQAMQP: IRabbitMQConfig;
    FConfigFilePath: string;
    function ParseJSONConfig(const AJSONContent: string): Boolean;
    procedure CreateFileWithDefaultParams;
    function LoadFromFile(const AFilePath: string): Boolean;
    procedure LoadFromEnvironmentVariables;

  public
    constructor Create;
    class function New: IConfiguration;

    function PostgreSQL: IPostgreSQLConfig;
    function Redis: IRedisConfig;
    function RabbitMQ(AConnectionType: TConnectionType): IRabbitMQConfig;
  end;

implementation

{ TConfiguration }

constructor TConfiguration.Create;
begin
  FPostgreSQL := TPostgreSQLConfig.New;
  FRedis      := TRedisConfig.New;
  FRabbitMQStomp := TRabbitMQConfig.New;
  FRabbitMQAMQP := TRabbitMQConfig.New;

  {$IFDEF MSWINDOWS}
  FConfigFilePath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'connection.json';
  CreateFileWithDefaultParams;
  LoadFromFile(FConfigFilePath);
  {$ELSE}
    LoadFromEnvironmentVariables;
  {$ENDIF}
end;

procedure TConfiguration.LoadFromEnvironmentVariables;
begin
  FPostgreSQL
    .Host(GetEnvironmentVariable('POSTGRES_HOST'))
    .Port(StrToIntDef(GetEnvironmentVariable('POSTGRES_PORT'), 5432))
    .Database(GetEnvironmentVariable('POSTGRES_DB'))
    .User(GetEnvironmentVariable('POSTGRES_USER'))
    .Password(GetEnvironmentVariable('POSTGRES_PASSWORD'));

  FRedis
    .Host(GetEnvironmentVariable('REDIS_HOST'))
    .Port(StrToIntDef(GetEnvironmentVariable('REDIS_PORT'), 6379));


  FRabbitMQStomp
    .Host(GetEnvironmentVariable('RABBITMQ_HOST'))
    .Port(StrToIntDef(GetEnvironmentVariable('RABBITMQ_PORT_STOMP'), 61613))
    .User(GetEnvironmentVariable('RABBITMQ_USER'))
    .Password(GetEnvironmentVariable('RABBITMQ_PASSWORD'));

  FRabbitMQAMQP
    .Host(GetEnvironmentVariable('RABBITMQ_HOST'))
    .Port(StrToIntDef(GetEnvironmentVariable('RABBITMQ_PORT_AMQP'), 5672))
    .User(GetEnvironmentVariable('RABBITMQ_USER'))
    .Password(GetEnvironmentVariable('RABBITMQ_PASSWORD'));
end;

class function TConfiguration.New: IConfiguration;
begin
  Result := Self.Create;
end;

function TConfiguration.PostgreSQL: IPostgreSQLConfig;
begin
  Result := FPostgreSQL;
end;

function TConfiguration.RabbitMQ(AConnectionType: TConnectionType): IRabbitMQConfig;
begin
  case AConnectionType of
    ctSTOMP: Result := FRabbitMQStomp;
    ctAMQP:  Result := FRabbitMQAMQP;
  end;
end;

function TConfiguration.Redis: IRedisConfig;
begin
  Result := FRedis;
end;

procedure TConfiguration.CreateFileWithDefaultParams;
var
  LJSONObject: TJSONObject;
  LJSONContent: string;
begin
  if FileExists(FConfigFilePath) then
    Exit;

  LJSONObject := TJSONObject.Create;
  try
    LJSONObject.AddPair('PostgreSQL', FPostgreSQL.ToJSON);
    LJSONObject.AddPair('Redis', FRedis.ToJSON);
    LJSONObject.AddPair('RabbitMQ',  FRabbitMQStomp.ToJSON);
    LJSONContent := TJSONAncestor(LJSONObject).Format(2);

    TFile.WriteAllText(FConfigFilePath, LJSONContent, TEncoding.UTF8);
  finally
    FreeAndNil(LJSONObject);
  end;
end;

function TConfiguration.LoadFromFile(const AFilePath: string): Boolean;
begin
  Result := False;
  FConfigFilePath := AFilePath;

  if not TFile.Exists(AFilePath) then
    Exit;

  try
    Result := ParseJSONConfig(TFile.ReadAllText(AFilePath));
  except
    on E: Exception do
      raise Exception.Create('Error loading configuration: ' + E.Message);
  end;
end;

function TConfiguration.ParseJSONConfig(const AJSONContent: string): Boolean;
var
  LJSONObject: TJSONObject;
  LPostgreSQLConfig,
  LRedisConfig,
  LRabbitMQConfig,
  LRabbitMQConfigSTOMP,
  LRabbitMQConfigAMQP: TJSONObject;
begin
  Result := False;
  LJSONObject := TJSONObject.ParseJSONValue(AJSONContent) as TJSONObject;

  if not Assigned(LJSONObject) then
    Exit;

  try
    if LJSONObject.TryGetValue<TJSONObject>('PostgreSQL', LPostgreSQLConfig) then
    begin
      FPostgreSQL
        .Host(LPostgreSQLConfig.GetValue<string>('Host', 'localhost'))
        .Port(LPostgreSQLConfig.GetValue<Integer>('Port', 5432))
        .Database(LPostgreSQLConfig.GetValue<string>('Database', 'meu_banco'))
        .User(LPostgreSQLConfig.GetValue<string>('User', 'postgres'))
        .Password(LPostgreSQLConfig.GetValue<string>('Password', '123456'));
    end;

    if LJSONObject.TryGetValue<TJSONObject>('Redis', LRedisConfig) then
    begin
      FRedis
        .Host(LRedisConfig.GetValue<string>('Host', 'localhost'))
        .Port(LRedisConfig.GetValue<Integer>('Port', 6379));
    end;

    if LJSONObject.TryGetValue<TJSONObject>('RabbitMQ', LRabbitMQConfig) then
    begin
      if LRabbitMQConfig.TryGetValue<TJSONObject>('STOMP', LRabbitMQConfigSTOMP) then
      begin
        FRabbitMQStomp
          .Host(LRabbitMQConfigSTOMP.GetValue<string>('Host', 'localhost'))
          .Port(LRabbitMQConfigSTOMP.GetValue<Integer>('Port', 61613))
          .User(LRabbitMQConfigSTOMP.GetValue<string>('User', 'guest'))
          .Password(LRabbitMQConfigSTOMP.GetValue<string>('Password', 'guest'));
      end;

      if LRabbitMQConfig.TryGetValue<TJSONObject>('AMQP', LRabbitMQConfigAMQP) then
      begin
        FRabbitMQAMQP
          .Host(LRabbitMQConfigAMQP.GetValue<string>('Host', 'localhost'))
          .Port(LRabbitMQConfigAMQP.GetValue<Integer>('Port', 5672))
          .User(LRabbitMQConfigAMQP.GetValue<string>('User', 'guest'))
          .Password(LRabbitMQConfigAMQP.GetValue<string>('Password', 'guest'));
      end;
    end;

    Result := True;
  finally
    LJSONObject.Free;
  end;
end;

end.
