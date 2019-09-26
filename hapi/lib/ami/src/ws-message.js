/*jshint node:true, esnext:true*/
'use strict';
const WsClient = require('./ws-client');
const isJson    = require('../../../src/util/isJson');
//Demos for Autocall & Recall
const Deamon    = require('./deamon');
const Demon    = require('./demonRecall');

module.exports = (ws, req) => {
  //BUG where update npm WS module from 2 to vresion 3, need use 'req'
  const SecretID = req !== undefined ? req.headers['sec-websocket-key'] : ws.upgradeReq.headers['sec-websocket-key'];
  const wsClient = new WsClient({"SecretID": SecretID, "ws": ws});

  //console.log(ws);
  //console.dir(ws.eventNames());
  ws.on('open', () => {
      ws.send(Date.now().toString(), { mask: true });
    })
    .on('close', () => {
      //console.log('close');
      wsClient.msgDisconnect();
      ws.close();
    })
    .on('error', error => {
      //console.log('error');
      //console.log(error);
      wsClient.msgDisconnect();
      ws.close();
    })
    .on("message", message => {
      if(isJson(message) && message !== null ){
          const data = JSON.parse(message);
          switch (data.action) {
            case 'call':          wsClient.toCall(data);        break;    //Hand Type
            case 'join':          wsClient.join(data.user);     break;    //auth & Login from web
            case 'hangup':        wsClient.hangup(data.phone);  break;    //Hangup call by phone number
            case 'Support':       wsClient.Support(data);       break;    //for send http to rocket chat
            default : wsClient.Action(data);
          }
      }
      else {
          wsClient.msgDisconnect();
          ws.close();
      }
  });
};