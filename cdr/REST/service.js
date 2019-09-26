/** * Module dependencies.*/
var express = require('express'),
		app     = express(),
		api 	= express(),
	
    mysql   = require('mysql'),
	connectionpool = mysql.createPool({
        host     : 'localhost',
        user     : 'root',
        password : 'xsw2#EDC',
        database : 'project'
 
    });
	
api.use(express.logger('dev'));
api.use(express.bodyParser());


/** * CORS support. */
api.all('*', function(req, res, next){
  if (!req.get('Origin')) return next();
  // use "*" here to accept any origin
  res.set('Access-Control-Allow-Origin', '*');
  res.set('Access-Control-Allow-Methods', 'GET, POST');
  res.set('Access-Control-Allow-Headers', 'X-Requested-With, Content-Type');
  // res.set('Access-Control-Allow-Max-Age', 3600);
  if ('OPTIONS' == req.method) return res.send(200);
  next();
});

app.all('*', function(req, res, next){
  if (!req.get('Origin')) return next();
  // use "*" here to accept any origin
  res.set('Access-Control-Allow-Origin', '*');
  res.set('Access-Control-Allow-Methods', 'GET, POST');
  res.set('Access-Control-Allow-Headers', 'X-Requested-With, Content-Type');
  // res.set('Access-Control-Allow-Max-Age', 3600);
  if ('OPTIONS' == req.method) return res.send(200);
  next();
});
/*****        CLIENTS        *****/
//GET CLIENTS
  app.get('/user', function(req,res){    DB('call cl_pGetClients;',res,req)   });
  
//POST CLIENTS
 api.post('/user', function(req, res){
 	var query =  'CALL cl_pUpdClient(' + req.body.ClientID + ',\"' + req.body.ClientName + '\", 1,\"' + req.body.Secret + '\",\"' + req.body.NickName + '\");';
	DB(query,res,req)  
	res.send(201);
	});
 api.post('/user_insert', function(req, res){
 	var query =  'CALL cl_pInsClient(\"'+ req.body.ClientName + '\", 1,\"' + req.body.Secret + '\",\"' + req.body.NickName + '\");';
	console.log(req.body.ClientID);
	DB(query,res,req)  
	res.send(201);
	});
 api.post('/user_d', function(req, res){
 	var query =  'CALL cl_pDelClient(\"' + req.body.ClientID + '\");';
	console.log(req.body.ClientID);
	DB(query,res,req)  
	res.send(201);
	});	
	
 
/*****        SIP USERS        *****/
//GET SIP
 app.get('/sipusers', function(req,res){    DB('call pGetSippers;',res,req)   });
 app.get('/sipusers/:id/:id2', function(req,res){   console.log(req.params.id); DB('select * from sippeers where name =\''+req.params.id+'\' AND secret =\''+req.params.id2+'\';',res,req)   });
 app.get('/sipusers_g', function(req,res){   console.log(req.params.id); DB('select name,callerid from sippeers group by name;',res,req)   });
//POST SIP
 api.post('/sipusers', function(req, res){
 	var query =  'CALL pInsSippers(\"'+ 
										req.body.name 			+ '\",\"' +
										req.body.allow 			+ '\",\"' +
										req.body.insecure 		+ '\",\"' +
										req.body.qualify 		+ '\",\"' +
										req.body.type 			+ '\",\"' +
										req.body.callLimit 		+ '\",\"' +
										req.body.disallow 		+ '\",\"' +
										req.body.language 		+ '\",\"' +
										req.body.secret 		+ '\",\"' +
										req.body.callerid		+ '\",\"' +
										req.body.dtmfmode 		+ '\",\"' +
										req.body.textsupport 	+ '\",\"' +
										req.body.context 		+ '\",\"' +
										req.body.host 			+ '\",\"' +
										req.body.nat 			+ '\",\"' +
										req.body.transport 		+ '\");';										 
	DB(query,res,req)  
	res.send(201);
});
api.post('/sipusers_u', function(req, res){
 	var query =  'CALL pUpdSippers(\"'+ 
										req.body.id 			+ '\",\"' +
										req.body.name 			+ '\",\"' +
										req.body.allow 			+ '\",\"' +
										req.body.insecure 		+ '\",\"' +
										req.body.qualify 		+ '\",\"' +
										req.body.type 			+ '\",\"' +
										req.body.callLimit 		+ '\",\"' +
										req.body.disallow 		+ '\",\"' +
										req.body.language 		+ '\",\"' +
										req.body.secret 		+ '\",\"' +
										req.body.callerid  		+ '\",\"' +
										req.body.dtmfmode 		+ '\",\"' +
										req.body.textsupport 	+ '\",\"' +
										req.body.context 		+ '\",\"' +
										req.body.host 			+ '\",\"' +
										req.body.nat 			+ '\",\"' +
										req.body.transport 		+ '\");';										 
	console.log(req.body);
	DB(query,res,req)  
	res.send(201);
});
 
api.post('/sipusers_d', function(req, res){
 	var query =  'call pDelSippers(\"'+ req.body.id + '\");';										 
	DB(query,res,req)  
	res.send(201);
});

 
 /*****        FUNCTIONS        *****/
 function DB(ID,res,req){
	connectionpool.getConnection(function(err, connection) {
        if (err) {
            console.error('CONNECTION error: ',err);
            res.statusCode = 503;
            res.send({
                result: 'error',
                err:    err.code
            });
        } else {
            connection.query(ID, req.params.id, function(err, rows, fields) {
                if (err) {
                    console.error(err);
                    res.statusCode = 500;
                    res.send({
                        result: 'error',
                        err:    err.code
                    });
                }
                res.send({
                    result: 'success',
                    err:    '',
                    json:   rows,
                    //length: rows.length
                });
                connection.release();
            });
        }
    });
 
 }
 
app.listen(3000);
api.listen(3001);

console.log('app listening on 3000');
console.log('api listening on 3001');
