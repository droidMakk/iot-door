var net = require('net')

var srv = net.createServer(function(socket){
	socket.on('data',function(data){
		console.log(data.toString())
	})
	socket.end('Love. From server')
}).on('error',function(err){
	throw err;

})

srv.listen({
	host: 'localhost',
	port: 80
},function(){
	console.log('Listening at 80')
})

//srv.on('data',function(data){
//	console.log(data);
//})
