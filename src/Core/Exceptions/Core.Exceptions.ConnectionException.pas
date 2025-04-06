unit Core.Exceptions.ConnectionException;

interface

uses
  System.SysUtils;

type
  EConnectionException = class(Exception)
  public
    constructor Create(const Msg: string); overload;
    constructor Create(const Msg: string; const InnerException: Exception); overload;
  end;

implementation

{ EConnectionException }

constructor EConnectionException.Create(const Msg: string);
begin
  inherited Create(Msg);
end;

constructor EConnectionException.Create(const Msg: string; const InnerException: Exception);
begin
  inherited CreateFmt('%s: %s', [Msg, InnerException.Message]);
end;

end.
