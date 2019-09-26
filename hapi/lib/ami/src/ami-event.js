/*jshint node:true*/
'use strict';

const request = require('./middleware/request');
const constants = require('../src/config/constants').application;
const utils = require('./middleware/utils');

// Asterisk 11 список всех кто ответил
const peerstatusHeadler = evt => {
  if(evt)
    if(evt.device){
      	let body = {};
       	let sip = evt.device ? evt.device.split("/", 2)[1] : null;
         	switch (evt.event) {
            //     case `PeerStatus`:
            //        body = {
            //        		"eventName": evt.event,
      		    //       	"SIP": evt.peer.split("/", 2)[1],
      		    //       	"dev_status": evt.peerstatus,
      		    //         "dev_state": null,
      		    //     	"pause": false
      		    // };
            //       break;
              case `DeviceStateChange`:
                                        body = {
                                        		"eventName": evt.event,
                            		          	"SIP": sip,
                            		          	"dev_status": null,
                            		            "dev_state":evt.state,
                            		        	"pause": false
                            		        }; break;

              case `QueueMemberStatus`:
                                        body = {
                                        		"eventName": evt.event,
                            		          	"SIP": evt.membername.split("/", 2)[1],
                            		          	"dev_status": evt.status.toString(),
                            		            "dev_state": null,
                            		        	  "pause": Boolean(parseInt(evt.paused))
                            		        };break;

                default:  break;
              }
              body.Aid = 1;
              body.address = null;
       // 	const options = {
       //          uri   : `http://zhdanov:2wsxCDE322wsxCDE32@localhost:${constants.port}/api/ast/monitoring`,
       //          method: 'POST',
       //          json  : true,
       //          body  : body
      	// };

      	// if(body.SIP !== undefined)
      	// request(options, (error, payload, body) => {});
   }
};


class AmiEvents {
      constructor(ami,CallListRun) {
          this.httpsport = parseInt(constants.port) == 80 ? 443 :  parseInt(constants.port) + 10;
          this.http = `https://system:GajQFtnlejJwdEGby73Z7MBlnktMwc@localhost:${this.httpsport}`;
          const self = this;
          this.ami = ami;
          this.ami.on('bridgeenter', evt => {
                  CallListRun.start(evt, cb => { this.updCallincard(cb); } );
          });

          const hold = evt => {
              if(evt){
                console.log( );
                console.dir(evt);  
                let [SIP,ccName] = [null,null];

                //OUT
                if(evt.uniqueid == evt.linkedid){
                  if(evt.channel) SIP = utils.sip(evt.channel);
                  if(evt.exten) ccName =  parseInt(utils.clearnum(evt.exten)); 
                } 
                else { 
                  if(evt.accountcode == ''){  //IN //Dialpad 
                    if(evt.channel) SIP = utils.sip(evt.channel);
                    if(evt.connectedlinenum) ccName = parseInt(utils.clearnum(evt.connectedlinenum)); 
                  }
                  else { //Originate
                    if(evt.exten != ''){
                      if(evt.channel) SIP = utils.sip(evt.channel);
                      if(evt.connectedlinenum) ccName = parseInt(utils.clearnum(evt.connectedlinenum));
                    }
                    else{
                      if(evt.channel && evt.connectedlinenum) {
                        SIP = utils.sip(evt.connectedlinenum);
                        let Aid        = utils.sip(evt.channel);
                        Aid = Aid.split("_", 2)[1] ;
                        SIP = `${SIP}_${Aid}`;
                      }
                      if(evt.calleridnum) ccName = parseInt(utils.clearnum(evt.calleridnum));
                      
                    }
                  }
                }

                let options = {uri:`${self.http}/api/ast/events`,method:'POST',json:true,strictSSL: false,body:{ SIP, ccName, "eventName": evt.event.toString() }};
                console.log(options);
                if(SIP)
                  request(options, (error, payload, body) => {
                    if(error) return console.log(`ERROR!!!!!! CREATE HOLD ${error}`);
                  });
              }
          };

          this.ami.on('hold',hold)
                  .on('unhold', hold);
                  // .on('varset', function(evt) {
                  //   if(evt.variable.dcid !== undefined && evt.value != ''){
                  //     console.log();
                  //     console.dir(evt);}
                  // });
          
          // this.ami.on('queuememberpause', function(evt) {
          //   console.log();
          //   console.dir(evt);
          // });

          // this.ami.on('peerstatus', peerstatusHeadler);
          //this.ami.on('devicestatechange', peerstatusHeadler);
          //this.ami.on('registry', peerstatusHeadler);
          //this.ami.on('queuememberstatus', peerstatusHeadler);
          //this.ami.on('managerevent', function(evt) {});          
      }
    
      updCallincard(el){
          //console.log(el);
          const self = this;
          // var [dcID,ffID,clID,ccID,IsOut,emID,isAutocall] = [null,null,null,null,null,null,null];
          // var Channel;
          // if(el.Type == 'ORIGINATION') Channel = el.channelB; else Channel = el.channel;
          // //GET DCID
          // self.sendAction({Action:'Getvar',Channel,Variable: `dcID`}, (err, res) => { 
          //   if(err) return console.log(`ERROR!!!!!! GETVAR ${err}`); 
          //   if(res) {
          //     console.log(res);
          //     if(res.value && res.value != 'null') dcID = parseInt(res.value);
          //     //GET CLID
          //     self.sendAction({Action:'Getvar',Channel,Variable: `clID`}, (err, res) => { 
          //       if(err) return console.log(`ERROR!!!!!! GETVAR ${err}`); 
          //       if(res) {
          //         console.log(res);
          //         if(res.value && res.value != 'null') clID = parseInt(res.value);
          //         self.sendAction({Action:'Getvar',Channel,Variable: `ccID`}, (err, res) => { 
          //           if(err) return console.log(`ERROR!!!!!! GETVAR ${err}`); 
          //           if(res) {
          //             console.log(res);
          //             if(res.value && res.value != 'null') ccID = parseInt(res.value);
          //             self.sendAction({Action:'Getvar',Channel,Variable: `ffID`}, (err, res) => { 
          //               if(err) return console.log(`ERROR!!!!!! GETVAR ${err}`); 
          //               if(res) console.log(res);
          //               if(res.value && res.value != 'null') ffID = parseInt(res.value);
          //               self.sendAction({Action:'Getvar',Channel,Variable: `IsOut`}, (err, res) => { 
          //                 if(err) return console.log(`ERROR!!!!!! GETVAR ${err}`); 
          //                 if(res) console.log(res);
          //                 if(res.value && res.value != 'null') IsOut = Boolean(res.value);
          //                 self.sendAction({Action:'Getvar',Channel,Variable: `emID`}, (err, res) => { 
          //                   if(err) return console.log(`ERROR!!!!!! GETVAR ${err}`); 
          //                   if(res) console.log(res);
          //                   if(res.value && res.value != 'null') emID = parseInt(res.value);
          //                   self.sendAction({Action:'Getvar',Channel,Variable: `isAutoCall`}, (err, res) => { 
          //                     if(err) return console.log(`ERROR!!!!!! GETVAR ${err}`); 
          //                     if(res) console.log(res);
          //                     if(res.value && res.value != 'null') isAutocall = Boolean(res.value);
          //                     //
          //                     //UPDATE CALLINGCARD
          //                     let options = {uri:`${self.http}/api/cc/contacts`,method:'PUT',json:true,strictSSL: false,body:{dcID,ccID,ffID,clID,IsOut,isAutocall,emID,"SIP":el.sip,"disposition":`UP`,"channel":el.source,ccName:el.ccName,"isAsterisk": true}};
          //                     if(el.ccName != `~~s~~`)
          //                         request(options, (error, payload, body) => {
          //                           if(error) return console.log(`ERROR!!!!!! UPDATE CALLINGCARD ${error}`);
          //                             else {
          //                                 const action = {
          //                                     Action  : 'Setvar',
          //                                     Channel   : el.channel,
          //                                     Variable: `sip`,
          //                                     Value: el.sip
          //                                 };
          //                                 self.sendAction(action, (err, res) => { if(err) return console.log(`ERROR!!!!!! UPDATE SETVAR ${err}`); });
          //                                 if(el.Type == 'ORIGINATION'){
          //                                     let chan = el.channel.split(";")[0];
          //                                     const action = {
          //                                         Action  : 'Setvar',
          //                                         Channel   : `${chan};2`,
          //                                         Variable: `sip`,
          //                                         Value: el.sip
          //                                     };
          //                                     self.sendAction(action, (err, res) => { if(err) return console.log(`ERROR!!!!!! UPDATE SETVAR ${err}`); });
          //                                 }
          //                           }
          //                         });
          //                     //

          //                   });
          //                 });
          //               });

          //             });       
          //           }
          //         });       
          //       }
          //     });
          //   }
          // });

                        // UPDATE CALLINGCARD
                              var [dcID,ffID,clID,ccID,IsOut,emID,isAutocall] = [null,null,null,null,null,null,null];
                              dcID      = el.dcID       ? el.dcID       : null;
                              ffID      = el.ffID       ? el.ffID       : null;
                              clID      = el.clID       ? el.clID       : null;
                              ccID      = el.ccID       ? el.ccID       : null;
                              IsOut     = el.IsOut;
                              emID      = el.emID       ? el.emID       : null;
                              isAutocall= el.isAutocall;

                              let options = {uri:`${self.http}/api/cc/contacts`,method:'PUT',json:true,strictSSL: false,body:{dcID,ccID,ffID,clID,IsOut,isAutocall,emID,"SIP":el.sip,"disposition":`UP`,"channel":el.source,ccName:el.ccName,"isAsterisk": true}};
                              if(el.ccName != `~~s~~`)
                                  request(options, (error, payload, body) => {
                                    if(error) return console.log(`ERROR!!!!!! UPDATE CALLINGCARD ${error}`);
                                      else {
                                          const action = {
                                              Action  : 'Setvar',
                                              Channel   : el.channel,
                                              Variable: `sip`,
                                              Value: el.sip
                                          };
                                          self.sendAction(action, (err, res) => { if(err) return console.log(`ERROR!!!!!! UPDATE SETVAR ${err}`); });
                                          if(el.Type == 'ORIGINATION'){
                                              let chan = el.channel.split(";")[0];
                                              const action = {
                                                  Action  : 'Setvar',
                                                  Channel   : `${chan};2`,
                                                  Variable: `sip`,
                                                  Value: el.sip
                                              };
                                              self.sendAction(action, (err, res) => { if(err) return console.log(`ERROR!!!!!! UPDATE SETVAR ${err}`); });
                                          }
                                    }
                                  });
      }

      sendAction(entry, callback){
          return this.ami.action(entry, callback);
      }
}
module.exports = AmiEvents;