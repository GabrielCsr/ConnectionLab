unit Connection.Redis;

interface

uses
  Contract.Connection.Redis, Connection.Redis.Configuration, FastRedis;

type
  TRedisConnection = class(TInterfacedObject, IRedisConnection)
  private
    class var FRedis: TFastRedis;
    class procedure FreeInstances;
  public
    constructor Create(AConfigurator: IRedisConfig);
    destructor Destroy; override;
    class function New(AConfigurator: IRedisConfig): IRedisConnection;

    procedure Connect;
    procedure Disconnect;
    function  Connected: Boolean;
    function  ConnectionObject: TObject;
  end;

implementation


uses
  SysUtils;

{ TRedisConnection }

procedure TRedisConnection.Connect;
begin
  //
end;

function TRedisConnection.Connected: Boolean;
begin
  Result := True;
end;

function TRedisConnection.ConnectionObject: TObject;
begin
  Result := FRedis;
end;

constructor TRedisConnection.Create(AConfigurator: IRedisConfig);
begin
  if not Assigned(FRedis) then
    FRedis := TFastRedis.Create;

  FRedis.Configuration(AConfigurator.Host, AConfigurator.Port);
end;

destructor TRedisConnection.Destroy;
begin

  inherited;
end;

procedure TRedisConnection.Disconnect;
begin
  //
end;

class procedure TRedisConnection.FreeInstances;
begin
  if Assigned(FRedis) then
    FreeAndNil(FRedis);
end;

class function TRedisConnection.New(
  AConfigurator: IRedisConfig): IRedisConnection;
begin
  Result := Self.Create(AConfigurator);
end;


initialization

finalization
  TRedisConnection.FreeInstances;

end.
