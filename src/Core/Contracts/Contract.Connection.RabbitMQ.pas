unit Contract.Connection.RabbitMQ;

interface

uses
  Contract.Connection;

type
  IRabbitMQConnection = interface(IConnection)
    procedure Connect;
    procedure Disconnect;
    function  Connected: Boolean;
    function  ConnectionObject: TObject;
  end;

implementation

end.
