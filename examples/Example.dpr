program Example;

uses
  System.StartUpCopy,
  FMX.Forms,
  View in 'View.pas' {Form1},
  Contract.Connection in '..\src\Core\Contracts\Contract.Connection.pas',
  Contract.Connection.PostgreSQL in '..\src\Core\Contracts\Contract.Connection.PostgreSQL.pas',
  Connection.PostgreSQL.Configuration in '..\src\Connections\PostgreSQL\Connection.PostgreSQL.Configuration.pas',
  Connection.PostgreSQL in '..\src\Connections\PostgreSQL\Connection.PostgreSQL.pas',
  Core.Exceptions.ConnectionException in '..\src\Core\Exceptions\Core.Exceptions.ConnectionException.pas',
  Core.Exceptions.DatabaseException in '..\src\Core\Exceptions\Core.Exceptions.DatabaseException.pas',
  Core.Configuration in '..\src\Core\Core.Configuration.pas',
  ConnectionRepository in '..\src\Core\ConnectionRepository.pas',
  Connection.Redis.Configuration in '..\src\Connections\Redis\Connection.Redis.Configuration.pas',
  Contract.Connection.Redis in '..\src\Core\Contracts\Contract.Connection.Redis.pas',
  Connection.Redis in '..\src\Connections\Redis\Connection.Redis.pas',
  Connection.RabbitMQ.Configuration in '..\src\Connections\RabbitMQ\Connection.RabbitMQ.Configuration.pas',
  Contract.Connection.RabbitMQ in '..\src\Core\Contracts\Contract.Connection.RabbitMQ.pas',
  Connection.RabbitMQ in '..\src\Connections\RabbitMQ\Connection.RabbitMQ.pas',
  Contract.DataSet in '..\src\Core\Contracts\Contract.DataSet.pas',
  DataSet in '..\src\Core\DataSet.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
