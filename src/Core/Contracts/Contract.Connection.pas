unit Contract.Connection;

interface

type
  IConnection = interface
    procedure Connect;
    procedure Disconnect;
    function  Connected: Boolean;
    function  ConnectionObject: TObject;
  end;


implementation


end.
