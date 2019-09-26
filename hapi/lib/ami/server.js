// /*jshint node:true, esnext:true*/
// 'use strict';
// const request = require(`request`);
// const server = require('http').createServer();
// const url = require('url');
// const WebSocketServer = require('ws').Server;
// const wss = new WebSocketServer({
//   server: server
// });
// const express = require('express');
// const app = express();
// const constants = require('src/config/constants');

// const path = require('path');
// const con = require(`./src/ws-message`);

// const events = require("events").EventEmitter.prototype._maxListeners = 0

// app.use(express.static(path.join(__dirname, '/public')));

// wss.on("connection", con);
// // wss.on('connection', function connection(ws) {
// //   var location = url.parse(ws.upgradeReq.url, true);
// //   // you might use location.query.access_token to authenticate or share sessions
// //   // or ws.upgradeReq.headers.cookie (see http://stackoverflow.com/a/16395220/151312)
// //   console.log(location);
// //   ws.on('message', function incoming(message) {
// //     console.log('received: %s', message);
// //   });

// //   ws.send('something');
// // });

// server.on('request', app);
// server.listen(constants.application.port, function() {
//   console.log('Listening on ' + server.address().port);
// });
