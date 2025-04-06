# ConnectionLab
**ConnectionLab** é uma solução centralizada para gerenciamento de conexões com diversos sistemas.
1. Bancos de dados relacionais
2. noSQL
3. Message Broker

Devido a implementação totalmente desacoplada, a biblioteca permite a inclusão de novas conexões de forma facilitada.

## 💾 Instalação
Instalação utilizando o gerenciador de dependências boss:
```bash
boss install https://github.com/GabrielCsr/ConnectionLab
```
 ## 🔧 Configurações iniciais
 Crie o arquivo `connection.json` no diretório do executável com a seguinte estrutura:
 ```bash json
{
  "PostgreSQL": {
        "Host": "localhost",
        "Port": 5432,
        "Database": "postgres",
        "User": "postgres",
        "Password": "123456"
  },

  "Redis": {
        "Host": "127.0.0.1",
        "Port": 6379
  },

  "RabbitMQ": {
    "STOMP": {
      "Host": "localhost",
      "User": "guest",
      "Password": "guest",
      "Port": 61613
    },

    "AMQP": {
      "Host": "localhost",
      "User": "guest",
      "Password": "guest",
      "Port": 5672
    }
  }
}
``` 
## ⚡ Exemplos de utilização 
```bash pascal
uses
  ConnectionRepository, FastRedis, BrokerX.RabbitMQ.Classes, DataSet;
```
```bash pascal
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
```
## ♦️ Bibliografia
Foram utilizadas as seguintes bibliotecas na criação do projeto:
1. https://github.com/GabrielCsr/BrokerX `RabbitMQ`
2. https://github.com/GabrielCsr/FastRedis `Redis`
