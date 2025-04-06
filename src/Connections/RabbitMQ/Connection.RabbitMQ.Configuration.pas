unit Connection.RabbitMQ.Configuration;

interface

uses
  JSON;

type
  IRabbitMQConfig = interface
    function Host(AValue: String): IRabbitMQConfig; overload;
    function Host:     String; overload;
    function Port(AValue: Integer): IRabbitMQConfig; overload;
    function Port:     Integer; overload;
    function User(AValue: String): IRabbitMQConfig; overload;
    function User:     String; overload;
    function Password(AValue: String): IRabbitMQConfig; overload;
    function Password: String; overload;
    function ToJSON: TJSONObject;
  end;

  TRabbitMQConfig = class(TInterfacedObject, IRabbitMQConfig)
  private
    FHost,
    FUser,
    FPassword: String;
    FPort: Integer;
  public
    constructor Create;
    class function New: IRabbitMQConfig;
    function Host(AValue: String): IRabbitMQConfig; overload;
    function Host:     String; overload;
    function Port(AValue: Integer): IRabbitMQConfig; overload;
    function Port:     Integer; overload;
    function User(AValue: String): IRabbitMQConfig; overload;
    function User:     String; overload;
    function Password(AValue: String): IRabbitMQConfig; overload;
    function Password: String; overload;
    function ToJSON: TJSONObject;
  end;

implementation

{ TRabbitMQConfig }

constructor TRabbitMQConfig.Create;
begin

end;

function TRabbitMQConfig.Host: String;
begin
  Result := FHost;
end;

function TRabbitMQConfig.Host(AValue: String): IRabbitMQConfig;
begin
  Result := Self;
  FHost := AValue;
end;

class function TRabbitMQConfig.New: IRabbitMQConfig;
begin
  Result := Self.Create;
end;

function TRabbitMQConfig.Password(AValue: String): IRabbitMQConfig;
begin
  Result := Self;
  FPassword := AValue;
end;

function TRabbitMQConfig.Password: String;
begin
  Result := FPassword;
end;

function TRabbitMQConfig.Port: Integer;
begin
  Result := FPort;
end;

function TRabbitMQConfig.ToJSON: TJSONObject;
var
  LJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  LJSON  :=  TJSONObject.Create;
  LJSON.AddPair('Host', 'localhost');
  LJSON.AddPair('Port', TJSONNumber.Create(61613));
  LJSON.AddPair('User', 'guest');
  LJSON.AddPair('Password', 'guest');

  Result.AddPair('STOMP', LJSON);

  LJSON.RemovePair('Port');
  LJSON.AddPair('Port', TJSONNumber.Create(5672));

  Result.AddPair('AMQP', LJSON);
end;

function TRabbitMQConfig.Port(AValue: Integer): IRabbitMQConfig;
begin
  Result := Self;
  FPort := AValue;
end;

function TRabbitMQConfig.User(AValue: String): IRabbitMQConfig;
begin
  Result := Self;
  FUser := AValue;
end;

function TRabbitMQConfig.User: String;
begin
  Result := FUser;
end;

end.
