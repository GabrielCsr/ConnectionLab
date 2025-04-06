unit Contract.DataSet;

interface

uses
  Classes, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param;

type
  IDataSet = interface
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

end.
