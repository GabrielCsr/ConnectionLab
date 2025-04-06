unit Contract.Connection.Redis;

interface

uses
  Contract.Connection;

type
  IRedisConnection = interface(IConnection)
    procedure Connect;
    procedure Disconnect;
    function  Connected: Boolean;
    function  ConnectionObject: TObject;
  end;

implementation

end.
