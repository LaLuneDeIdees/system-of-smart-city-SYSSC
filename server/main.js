const http = require('http');
const parkov = require('./parkov');

const hostname = '127.0.0.1';
const port = 48999;
const server = http.createServer((req, res) => {
  let url = req.url;
  if(url.indexOf('?')>=0)url+='&';
  else url+='?';
  
  req.on('data', (data) => {
      url+=data;
  });

  req.on('end', () => {
  	endresever(req,res,url);
  });  
})

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`)
})

function endresever(req,res,url){
	  url = req.url.split('?');
	  
	  if(url[0].substring(url[0].indexOf('/'),url[0].length) === '/parkov'){
	  	parkov.calling(req,res,url);
	  }else{
	  	res.statusCode = 404;
		  res.setHeader('Content-Type', 'text/plain');
		  res.end('404 Not Found!');
	  }
	  /*
	  res.statusCode = 200;
	  res.setHeader('Content-Type', 'text/plain');
		
	  if(getvalue(url[1],'pas')!==undefined){
		  res.end('Hello World\n');
	  }else{
	  	  res.end('Good night\n');
	  }*/
}
