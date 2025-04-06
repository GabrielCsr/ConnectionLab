unit View;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    procedure Examples;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  ConnectionRepository, DataSet, FastRedis, BrokerX.RabbitMQ.Classes;

{$R *.fmx}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Examples;
end;

procedure TForm1.Examples;
begin
  {PostgreSQL}
  TConnectionRepository.New.PostgreSQL.Connect;
  ShowMessage(
  TDataSet.New(PostgreSQL)
    .SQL('SELECT table_name ' +
         'FROM information_schema.tables ' +
         'WHERE table_schema = ''public'' ' +
         'ORDER BY table_name')
    .Open
    .FieldByName('table_name').AsString);
  TConnectionRepository.New.PostgreSQL.Disconnect;

  {Redis}
  TConnectionRepository.New.Redis.Connect;
  TFastRedis(TConnectionRepository.New.Redis.ConnectionObject).Save('Example', '123', 100);
  ShowMessage(TFastRedis(TConnectionRepository.New.Redis.ConnectionObject).TimeRemaining('Example').ToString);
  TFastRedis(TConnectionRepository.New.Redis.ConnectionObject).Delete('Example');
  TConnectionRepository.New.Redis.Disconnect;

  {RabbitMQ}
  TConnectionRepository.New.RabbitMQ.Connect;
  TRabbitMQ(TConnectionRepository.New.RabbitMQ).Queue('queue_example').Producer.Start;
  TRabbitMQ(TConnectionRepository.New.RabbitMQ).Queue('queue_example').Producer.SendMesssage('Enviando mensagem para fila');
  TRabbitMQ(TConnectionRepository.New.RabbitMQ).Queue('queue_example').Producer.Stop;
  TConnectionRepository.New.RabbitMQ.Disconnect;
end;

end.
