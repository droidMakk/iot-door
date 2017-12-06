const net = require('net');

const client = net.createConnection({ port: 80, host: "127.0.0.1" },function(){
  console.log('connected to server!');
  client.write('off');
});		

client.on('data', (data) => {
  console.log(data.toString());
});

client.on('end', () => {
  console.log('Ended connection');
});
