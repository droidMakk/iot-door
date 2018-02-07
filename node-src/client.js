const net = require('net');


const client = net.createConnection({ port: 92, host: "localhost" },function(){
  console.log('connected to server!');
  client.write('update-json');
});		

client.on('data', (data) => {
	msg=data.toString();
	msg_json=JSON.parse(msg);
	if(msg_json.status=="true"){
		console.log(msg_json.url)
	}
});

client.on('end', () => {
  console.log('Ended connection');
});
