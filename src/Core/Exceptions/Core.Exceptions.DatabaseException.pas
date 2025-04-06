unit Core.Exceptions.DatabaseException;

interface

uses
  Core.Exceptions.ConnectionException;

type
  EDatabaseException = class(EConnectionException)
  end;

implementation

end.
