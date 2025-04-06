unit Connection.RabbitMQ;

interface

uses
  Contract.Connection.RabbitMQ, Connection.RabbitMQ.Configuration,
  BrokerX.RabbitMQ.Interfaces,
  BrokerX.RabbitMQ.Configuration.Interfaces;

type
  TRabbitMQConnection = class(TInterfacedObject, IRabbitMQConnection)
  private
    FRabbitMQ: IRabbitMQ;
  public
    constructor Create(AConfigSTOMP, AConfigAMQP: IRabbitMQConfig);
    class function New(AConfigSTOMP, AConfigAMQP: IRabbitMQConfig): IRabbitMQConnection;
    procedure Connect;
    procedure Disconnect;
    function  Connected: Boolean;
    function  ConnectionObject: TObject;
  end;
implementation

uses
  BrokerX.RabbitMQ.Classes, BrokerX.RabbitMQ.Configuration.Classes;

{ TRabbitMQConnection }

procedure TRabbitMQConnection.Connect;
begin
  FRabbitMQ.Connect;
end;

function TRabbitMQConnection.Connected: Boolean;
begin
  Result := FRabbitMQ.Connected;
end;

function TRabbitMQConnection.ConnectionObject: TObject;
begin
  Result := FRabbitMQ as TRabbitMQ;
end;

constructor TRabbitMQConnection.Create(AConfigSTOMP,
  AConfigAMQP: IRabbitMQConfig);
begin
  FRabbitMQ := TRabbitMQ.New( TConfiguration.New
                                .Host(AConfigSTOMP.Host)
                                .Port(AConfigSTOMP.Port)
                                .User(AConfigSTOMP.User)
                                .Password(AConfigSTOMP.Password),
                              TConfiguration.New
                                .Host(AConfigAMQP.Host)
                                .Port(AConfigAMQP.Port)
                                .User(AConfigAMQP.User)
                                .Password(AConfigAMQP.Password) );
end;

procedure TRabbitMQConnection.Disconnect;
begin
  FRabbitMQ.Disconnect;
end;

class function TRabbitMQConnection.New(AConfigSTOMP,
  AConfigAMQP: IRabbitMQConfig): IRabbitMQConnection;
begin
  Result := Self.Create(AConfigSTOMP, AConfigAMQP);
end;

end.
