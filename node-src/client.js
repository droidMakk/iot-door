const net = require('net');

const client = net.createConnection({ port: 4000, host: "192.168.0.103" },function(){
  console.log('connected to server!');
  client.write('off');
});		

client.on('data', (data) => {
  console.log(data.toString());
});

client.on('end', () => {
  console.log('Ended connection');
});
