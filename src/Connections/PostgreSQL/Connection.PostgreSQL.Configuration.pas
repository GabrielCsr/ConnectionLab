unit Connection.PostgreSQL.Configuration;

interface

uses
  System.JSON;

type
  IPostgreSQLConfig = interface
    function Host(AValue: String): IPostgreSQLConfig; overload;
    function Host:     String; overload;
    function Port(AValue: Integer): IPostgreSQLConfig; overload;
    function Port:     Integer; overload;
    function Database(AValue: String): IPostgreSQLConfig; overload;
    function Database: String; overload;
    function User(AValue: String): IPostgreSQLConfig; overload;
    function User:     String; overload;
    function Password(AValue: String): IPostgreSQLConfig; overload;
    function Password: String; overload;
    function ToJSON: TJSONObject;
  end;

  TPostgreSQLConfig = class(TInterfacedObject, IPostgreSQLConfig)
  private
    FHost: string;
    FPort: Integer;
    FDatabase: string;
    FUser: string;
    FPassword: string;
  public
    constructor Create(const AHost: string; APort: Integer; const ADatabase, AUser, APassword: string); overload;
    class function New(const AHost: string; APort: Integer; const ADatabase, AUser, APassword: string): IPostgreSQLConfig; overload;
    constructor Create; overload;
    class function New: IPostgreSQLConfig; overload;

    function Host(AValue: String): IPostgreSQLConfig; overload;
    function Host:     String; overload;
    function Port(AValue: Integer): IPostgreSQLConfig; overload;
    function Port:     Integer; overload;
    function Database(AValue: String): IPostgreSQLConfig; overload;
    function Database: String; overload;
    function User(AValue: String): IPostgreSQLConfig; overload;
    function User:     String; overload;
    function Password(AValue: String): IPostgreSQLConfig; overload;
    function Password: String; overload;

    function ToJSON: TJSONObject;
  end;

implementation

{ TPostgreSQLConfig }

constructor TPostgreSQLConfig.Create(const AHost: string; APort: Integer;
  const ADatabase, AUser, APassword: string);
begin
  inherited Create;
  FHost := AHost;
  FPort := APort;
  FDatabase := ADatabase;
  FUser := AUser;
  FPassword := APassword;
end;

constructor TPostgreSQLConfig.Create;
begin

end;

function TPostgreSQLConfig.Database: String;
begin
  Result := FDatabase;
end;

function TPostgreSQLConfig.Database(AValue: String): IPostgreSQLConfig;
begin
  Result := Self;
  FDatabase := AValue;
end;

function TPostgreSQLConfig.Host(AValue: String): IPostgreSQLConfig;
begin
  Result := Self;
  FHost := AValue;
end;

function TPostgreSQLConfig.Host: String;
begin
  Result := FHost;
end;

class function TPostgreSQLConfig.New: IPostgreSQLConfig;
begin
  Result := Self.Create;
end;

class function TPostgreSQLConfig.New(const AHost: string; APort: Integer;
  const ADatabase, AUser, APassword: string): IPostgreSQLConfig;
begin
  Result := Self.Create(AHost, APort, ADatabase, AUser, APassword);
end;

function TPostgreSQLConfig.Password: String;
begin
  Result := FPassword;
end;

function TPostgreSQLConfig.Password(AValue: String): IPostgreSQLConfig;
begin
  Result := Self;
  FPassword := AValue;
end;

function TPostgreSQLConfig.Port(AValue: Integer): IPostgreSQLConfig;
begin
  Result := Self;
  FPort := AValue;
end;

function TPostgreSQLConfig.Port: Integer;
begin
  Result := FPort;
end;

function TPostgreSQLConfig.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('Host', 'localhost');
  Result.AddPair('Port', TJSONNumber.Create(5432));
  Result.AddPair('Database', 'meu_banco');
  Result.AddPair('User', 'postgres');
  Result.AddPair('Password', '123456');
end;

function TPostgreSQLConfig.User(AValue: String): IPostgreSQLConfig;
begin
  Result := Self;
  FUser := AValue;
end;

function TPostgreSQLConfig.User: String;
begin
  Result := FUser;
end;

end.
