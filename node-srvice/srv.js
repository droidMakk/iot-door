const net = require('net');
const fs = require('fs');
const path = require('path');
const express = require('express')
const app = express();

app.set('the title','update site')

const srv = net.createServer(function(socket) {
	socket.on('data',function(data) {
		var msg=data.toString()
		if(msg=="update-json"){
			fs.readFile('up_stat.json', function(err,data) {
				if (err) { console.log("Error"); }else{ 
					socket.end(data.toString())
				}
			});
		}
	})
	socket.on('error',function(err) {
		console.log(err)
	})
	// socket.end('finish recieving')
}).on('error',function(err) {
	console.log(err);
})


app.get('/stat',function(req,res){
	res.status(200).sendFile(__dirname+"/up_stat.json")
})

app.get('/file/:filename',function(req,res) {
	
	return new Promise(
		function(ful,rej) {
			res.send("got "+req.params.filename)
			console.log("got "+req.params.filename);
			console.log("got "+typeof(req.params.filename));
		})

})

app.listen(80);

srv.listen({
	hosts: 'localhost',
	port: '92'
},function() {
	console.log('Listening at 92')
})
