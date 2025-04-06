unit DataSet;

interface

uses
  Contract.DataSet, Data.DB, Classes, FireDAC.Comp.Client, FireDAC.Stan.Param,
  FireDAC.DApt;

type
  TDatabase = (PostgreSQL);

  TDataSet = class(TInterfacedObject, IDataSet)
  private
    FFDQuery: TFDQuery;
  public
    constructor Create(ADataBase: TDatabase; AConnection: TFDConnection = nil); overload;
    class function New(ADataBase: TDatabase; AConnection: TFDConnection = nil): IDataSet;
    destructor Destroy; override;

    function Active: Boolean; overload;
    function Active(const Value: Boolean): IDataSet; overload;

    function SQL: String; overload;
    function SQL(const Value: String): IDataSet; overload;
    function Add(ASQL: String): IDataSet;

    function DataSource: TDataSource; overload;
    function DataSource(const Value: TDataSource): IDataSet; overload;

    function Connection: TFDConnection; overload;
    function Connection(const Value: TFDConnection): IDataSet; overload;

    function Params: TFDParams;
    function FieldCount: Integer;
    function Fields: TFields;
    function RecordCount: Integer;
    function Eof: Boolean;
    function Bof: Boolean;

    function Open: IDataSet;
    function Close: IDataSet;
    function ExecSQL: IDataSet;
    function ExecSQLWithResult: Integer;
    function Next: IDataSet;
    function Prior: IDataSet;
    function First: IDataSet;
    function Last: IDataSet;
    function Append: IDataSet;
    function Edit: IDataSet;
    function Post: IDataSet;
    function Cancel: IDataSet;
    function Delete: IDataSet;
    function FieldByName(const FieldName: string): TField;
    function ParamByName(const ParamName: string): TFDParam;
    function DisableControls: IDataSet;
    function EnableControls: IDataSet;
    function IsEmpty: Boolean;
    function SetRange(const StartValues, EndValues: array of const): IDataSet;
    function ApplyUpdates: IDataSet;
    function CommitUpdates: IDataSet;
    function CancelUpdates: IDataSet;
  end;

implementation

uses
  SysUtils, ConnectionRepository;

{ TDataSet }

constructor TDataSet.Create(ADataBase: TDatabase; AConnection: TFDConnection = nil);
begin
  inherited Create;
  FFDQuery := TFDQuery.Create(nil);
  if Assigned(AConnection) then
    FFDQuery.Connection := AConnection
  else
  begin
    case ADatabase of
      PostgreSQL:
      begin
        TConnectionRepository.New.PostgreSQL.Connect;
        FFDQuery.Connection := TConnectionRepository.New.PostgreSQL.ConnectionObject as TFDConnection;
      end;
    end;
  end;
end;

destructor TDataSet.Destroy;
begin
  FreeAndNil(FFDQuery);
  inherited;
end;

function TDataSet.Active: Boolean;
begin
  Result := FFDQuery.Active;
end;

function TDataSet.Active(const Value: Boolean): IDataSet;
begin
  FFDQuery.Active := Value;
  Result := Self;
end;

function TDataSet.Add(ASQL: String): IDataSet;
begin
  FFDQuery.SQL.Add(ASQL);
  Result := Self;
end;

function TDataSet.SQL: String;
begin
  Result := FFDQuery.SQL.Text;
end;

function TDataSet.SQL(const Value: String): IDataSet;
begin
  FFDQuery.SQL.Text := Value;
  Result := Self;
end;

function TDataSet.DataSource: TDataSource;
begin
  Result := FFDQuery.DataSource;
end;

function TDataSet.DataSource(const Value: TDataSource): IDataSet;
begin
  FFDQuery.DataSource := Value;
  Result := Self;
end;

function TDataSet.Connection: TFDConnection;
begin
  Result := FFDQuery.Connection as TFDConnection;
end;

function TDataSet.Connection(const Value: TFDConnection): IDataSet;
begin
  FFDQuery.Connection := Value;
  Result := Self;
end;

function TDataSet.Params: TFDParams;
begin
  Result := FFDQuery.Params;
end;

function TDataSet.FieldCount: Integer;
begin
  Result := FFDQuery.FieldCount;
end;

function TDataSet.Fields: TFields;
begin
  Result := FFDQuery.Fields;
end;

function TDataSet.RecordCount: Integer;
begin
  Result := FFDQuery.RecordCount;
end;

function TDataSet.Eof: Boolean;
begin
  Result := FFDQuery.Eof;
end;

function TDataSet.Bof: Boolean;
begin
  Result := FFDQuery.Bof;
end;

function TDataSet.Open: IDataSet;
begin
  Result := Self;
  FFDQuery.Open;
end;

function TDataSet.Close: IDataSet;
begin
  FFDQuery.Close;
  Result := Self;
end;

function TDataSet.ExecSQL: IDataSet;
begin
  FFDQuery.ExecSQL;
  Result := Self;
end;

function TDataSet.ExecSQLWithResult: Integer;
begin
  Result := FFDQuery.ExecSQL(False);
end;

class function TDataSet.New(ADataBase: TDatabase; AConnection: TFDConnection = nil): IDataSet;
begin
  Result := Self.Create(ADataBase, AConnection);
end;

function TDataSet.Next: IDataSet;
begin
  FFDQuery.Next;
  Result := Self;
end;

function TDataSet.Prior: IDataSet;
begin
  FFDQuery.Prior;
  Result := Self;
end;

function TDataSet.First: IDataSet;
begin
  FFDQuery.First;
  Result := Self;
end;

function TDataSet.Last: IDataSet;
begin
  FFDQuery.Last;
  Result := Self;
end;

function TDataSet.Append: IDataSet;
begin
  FFDQuery.Append;
  Result := Self;
end;

function TDataSet.Edit: IDataSet;
begin
  FFDQuery.Edit;
  Result := Self;
end;

function TDataSet.Post: IDataSet;
begin
  FFDQuery.Post;
  Result := Self;
end;

function TDataSet.Cancel: IDataSet;
begin
  FFDQuery.Cancel;
  Result := Self;
end;

function TDataSet.Delete: IDataSet;
begin
  FFDQuery.Delete;
  Result := Self;
end;

function TDataSet.FieldByName(const FieldName: string): TField;
begin
  Result := FFDQuery.FieldByName(FieldName);
end;

function TDataSet.ParamByName(const ParamName: string): TFDParam;
begin
  Result := FFDQuery.ParamByName(ParamName);
end;

function TDataSet.DisableControls: IDataSet;
begin
  FFDQuery.DisableControls;
  Result := Self;
end;

function TDataSet.EnableControls: IDataSet;
begin
  FFDQuery.EnableControls;
  Result := Self;
end;

function TDataSet.IsEmpty: Boolean;
begin
  Result := FFDQuery.IsEmpty;
end;

function TDataSet.SetRange(const StartValues, EndValues: array of const): IDataSet;
begin
  FFDQuery.SetRange(StartValues, EndValues);
  Result := Self;
end;

function TDataSet.ApplyUpdates: IDataSet;
begin
  FFDQuery.ApplyUpdates;
  Result := Self;
end;

function TDataSet.CommitUpdates: IDataSet;
begin
  FFDQuery.CommitUpdates;
  Result := Self;
end;

function TDataSet.CancelUpdates: IDataSet;
begin
  FFDQuery.CancelUpdates;
  Result := Self;
end;

end.
