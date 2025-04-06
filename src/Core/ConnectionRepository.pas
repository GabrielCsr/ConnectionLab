unit ConnectionRepository;

interface

uses
  Core.Configuration,
  Contract.Connection.PostgreSQL,
  Contract.Connection.Redis, Contract.Connection.RabbitMQ;

type
  IConnectionRepository = interface
    function Configuration: IConfiguration;
    function PostgreSQL: IPostgreSQLConnection;
    function Redis: IRedisConnection;
    function RabbitMQ: IRabbitMQConnection;
  end;

  TConnectionRepository = class(TInterfacedObject, IConnectionRepository)
  private
    class var FConfiguration: IConfiguration;
    class var FPostgreSQL:    IPostgreSQLConnection;
    class var FRedis:         IRedisConnection;
    class var FRabbitMQ:      IRabbitMQConnection;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IConnectionRepository;

    function Configuration: IConfiguration;
    function PostgreSQL: IPostgreSQLConnection;
    function Redis: IRedisConnection;
    function RabbitMQ: IRabbitMQConnection;
  end;

implementation

uses
  Connection.PostgreSQL, Connection.Redis, Connection.RabbitMQ;

{ TConnectionRepository }

function TConnectionRepository.Configuration: IConfiguration;
begin
  Result := FConfiguration;
end;

constructor TConnectionRepository.Create;
begin
  FConfiguration := TConfiguration.New;
end;

destructor TConnectionRepository.Destroy;
begin

  inherited;
end;

class function TConnectionRepository.New: IConnectionRepository;
begin
  Result := Self.Create;
end;

function TConnectionRepository.PostgreSQL: IPostgreSQLConnection;
begin
  if not Assigned(FPostgreSQL) then
    FPostgreSQL := TPostgreSQLConnection.New(FConfiguration.PostgreSQL);

  Result := FPostgreSQL;
end;


function TConnectionRepository.RabbitMQ: IRabbitMQConnection;
begin
  if not Assigned(FRabbitMQ) then
    FRabbitMQ := TRabbitMQConnection.New(FConfiguration.RabbitMQ(ctSTOMP),
                                         FConfiguration.RabbitMQ(ctAMQP));

  Result := FRabbitMQ;
end;

function TConnectionRepository.Redis: IRedisConnection;
begin
  if not Assigned(FRedis) then
    FRedis := TRedisConnection.New(FConfiguration.Redis);

  Result := FRedis;
end;

end.
