unit Connection.PostgreSQL;

interface

uses
  Contract.Connection.PostgreSQL, Connection.PostgreSQL.Configuration,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.PGDef,
  FireDAC.Phys.PG;

type
  TPostgreSQLConnection = class(TInterfacedObject, IPostgreSQLConnection)
  private
    class var FConnection: TFDConnection;
    class var FDriver: TFDPhysPGDriverLink;
    FConfig: IPostgreSQLConfig;
    procedure ConfigureConnection;
  protected
    class procedure FreeInstances;
  public
    constructor Create(AConfigurator: IPostgreSQLConfig);
    destructor Destroy; override;
    class function New(AConfigurator: IPostgreSQLConfig): IPostgreSQLConnection;

    procedure Connect;
    procedure Disconnect;
    function  Connected: Boolean;
    function  ConnectionObject: TObject;
  end;

implementation

uses
  SysUtils, Core.Exceptions.DatabaseException;

{ TPostgreSQLConnection }

procedure TPostgreSQLConnection.ConfigureConnection;
begin
  FDriver.VendorHome := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
  FConnection.Connected := False;
  FConnection.DriverName                 := 'PG';
  FConnection.Params.Values['Server']    := FConfig.Host;
  FConnection.Params.Values['Port']      := FConfig.Port.ToString;
  FConnection.Params.Values['Database']  := FConfig.Database;
  FConnection.Params.Values['User_Name'] := FConfig.User;
  FConnection.Params.Values['Password']  := FConfig.Password;
  FConnection.LoginPrompt := False;
end;

procedure TPostgreSQLConnection.Connect;
begin
  try
    if not Connected then
      FConnection.Connected := True;
  except
    on E: Exception do
      raise Exception.Create('Failed to connect to PostgreSQL. ' + E.Message);
  end;
end;


function TPostgreSQLConnection.Connected: Boolean;
begin
  Result := FConnection.Connected;
end;

function TPostgreSQLConnection.ConnectionObject: TObject;
begin
  Result := FConnection;
end;

constructor TPostgreSQLConnection.Create(AConfigurator: IPostgreSQLConfig);
begin
  inherited Create;
  FConfig := AConfigurator;

  if not Assigned(FConnection) then
  begin
    FConnection := TFDConnection.Create(nil);
    FDriver     := TFDPhysPGDriverLink.Create(nil);
    ConfigureConnection;
  end;
end;

destructor TPostgreSQLConnection.Destroy;
begin
  inherited;
end;

procedure TPostgreSQLConnection.Disconnect;
begin
  try
    if Connected then
      FConnection.Connected := False;
  except
    on E: Exception do
      raise Exception.Create('Failed to disconnect from PostgreSQL. ' + E.Message);
  end;
end;

class procedure TPostgreSQLConnection.FreeInstances;
begin
  if Assigned(FDriver) then
    FreeAndNil(FDriver);

  if Assigned(FConnection) then
    FreeAndNil(FConnection);
end;

class function TPostgreSQLConnection.New(
  AConfigurator: IPostgreSQLConfig): IPostgreSQLConnection;
begin
  Result := Self.Create(AConfigurator);
end;

initialization

finalization
  TPostgreSQLConnection.FreeInstances;

end.
