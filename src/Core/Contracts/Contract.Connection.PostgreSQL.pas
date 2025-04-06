unit Contract.Connection.PostgreSQL;

interface

uses Contract.Connection;

type
  IPostgreSQLConnection = interface(IConnection)
    procedure Connect;
    procedure Disconnect;
    function  Connected: Boolean;
    function  ConnectionObject: TObject;
  end;

implementation

end.
