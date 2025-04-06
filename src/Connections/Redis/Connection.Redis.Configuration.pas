unit Connection.Redis.Configuration;

interface

uses
  JSON;

type
  IRedisConfig = interface
    function Host(AValue: String): IRedisConfig; overload;
    function Host: String; overload;
    function Port(AValue: Integer): IRedisConfig; overload;
    function Port: Integer; overload;
    function ToJSON: TJSONObject;
  end;

  TRedisConfig = class(TInterfacedObject, IRedisConfig)
  private
    FHost: String;
    FPort: Integer;
  public
    constructor Create(const AHost: String; APort: Integer); overload;
    class function New(const AHost: String; APort: Integer): IRedisConfig; overload;

    constructor Create; overload;
    class function New: IRedisConfig; overload;

    function Host(AValue: String): IRedisConfig; overload;
    function Host: String; overload;
    function Port(AValue: Integer): IRedisConfig; overload;
    function Port: Integer; overload;

    function ToJSON: TJSONObject;
  end;

implementation

{ TRedisConfig }

constructor TRedisConfig.Create(const AHost: String; APort: Integer);
begin
  FHost := AHost;
  FPort := APort;
end;

constructor TRedisConfig.Create;
begin

end;

function TRedisConfig.Host: String;
begin
  Result := FHost;
end;

function TRedisConfig.Host(AValue: String): IRedisConfig;
begin
  Result := Self;
  FHost := AValue;
end;

class function TRedisConfig.New: IRedisConfig;
begin
  Result := Self.Create;
end;

class function TRedisConfig.New(const AHost: String;
  APort: Integer): IRedisConfig;
begin
  Result := Self.Create(AHost, APort);
end;

function TRedisConfig.Port(AValue: Integer): IRedisConfig;
begin
  Result := Self;
  FPort := AValue;
end;

function TRedisConfig.Port: Integer;
begin
  Result := FPort;
end;

function TRedisConfig.ToJSON: TJSONObject;
begin
  Result      := TJSONObject.Create;
  Result.AddPair('Host', '127.0.0.1');
  Result.AddPair('Port', 6379);
end;

end.
