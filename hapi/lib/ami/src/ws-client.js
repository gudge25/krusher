/*jshint node:true*/
'use strict';
const request       = require('./middleware/request');
const amiAction     = require('./ami-action');
//const constants     = require('../src/config/constants').application;
const CallListRuns  = require('./CallList');
//const RingListRuns  = require('./RingList');
//const uuidV1        = require('uuid/v1');

const AllAmiRun     = require('./AllAmi');

class WsClient {
  constructor(data) {
    const self        = this;
    this.isDiale      = false;
    this.SecretID     = data.SecretID;
    this.ws           = data.ws;
    this.action       = amiAction;
    this.ami          = this.action.ami;
    this.id_autodial  = data.id_autodial;
    this.send = msg => {
      // console.log(`=====================self.ws.clients.size===================`);
      // console.log(self.ws.readyState);
      if (!self.isJoin || self.ws.readyState !=  1 ) return;
      if(self)if(self.ws)if(self.ws.send)self.ws.send(JSON.stringify(msg));
    };

    this.sendError = data => {
      if (!self.isJoin || self.ws.readyState !=  1 ) return;
      self.send({ event : 'hangup', CallType : `101318`});
      const msg = {
        event : 'err',
        data  : data,
        id_autodial : this.id_autodial
      };
      self.send(msg);
    };
    
    const BridgeHeadler13 = evt => {
      if (!self.isJoin ) return;
        //if ( `${evt.sip}_${this.Aid}` == self.Sip ){
          if ( evt.sip == self.Sip ){
            const msg = {
              event   : 'bridge',
              sip     : evt.sip,
              phone   : evt.ccName,
              //clID    : evt.accountcode,
              source  : evt.source,
              coID    : this.coID ? this.coID : null,
              Type    : evt.Type ? evt.Type : null,

              dcID      : evt.dcID       ? evt.dcID       : null,
              ffID      : evt.ffID       ? evt.ffID       : null,
              clID      : evt.clID       ? evt.clID       : null,
              ccID      : evt.ccID       ? evt.ccID       : null,
              IsOut     : evt.IsOut,
              emID      : evt.emID       ? evt.emID       : null,
              isAutocall: evt.isAutocall
            };
            self.send(msg);
        }
    };
    this.CallListRun = new CallListRuns(this.ami);
    this.BridgeHeadler = evt => {
      if(this.CallListRun)
        if(this.CallListRun.start)
          this.CallListRun.start(evt, cb => { BridgeHeadler13(cb); } );
    };

    //For ringing
    // this.RingListRun = new RingListRuns(self);
    // this.newstateHeadler13 = evt => {
    //   if(this.RingListRun)
    //     if(this.RingListRun.start)
    //       this.RingListRun.start(evt, cb => { console.log(cb); } );
    // };

    this.DialHeadler13 = evt => {
      if(evt.destcalleridnum == self.Sip){
        //Clear chanel and convert to source
        let sourceClean   =  evt.channel      ?  evt.channel.split("/")[1]      : null;
        sourceClean       = sourceClean ? sourceClean.split("-")[0] : null;
        sourceClean       = sourceClean ? sourceClean.split("_")[0] : null;
        evt.source        = sourceClean ? sourceClean : null;
       return self.send(evt);
     }
    };

    //Lisen devicestatechange evens
    const source = chan => {
      //Clear chanel and convert to source
      let a   = chan  ? chan.split("/")[1] : null;
      a       = a     ? a.split("-")[0] : null;
      return a ? a.split("_")[0] : null;
    };

    const sip = chan => {
        //Clear chanel and convert to source
        let a   = chan  ? chan.split("/")[1] : null;
        a       = a     ? a.split("-")[0] : null;
        return a ? a : null;
    };
 
    this.peerstatusHeadler = evt => {
        if(!evt) return -1;
        let body = {};
        switch (evt.event) {
          case `DeviceStateChange`:
                                    if(evt)if(evt.state){
                                      let sip   = evt.device ? evt.device.split("/", 2)[1] : null;
                                      let tech  = evt.device ? evt.device.split("/")[0] : null;
                                      if(tech !== `SIP`) return -1;
                                      //console.dir(evt);
                                      body = {
                                          "event"     : 'devicestatechange',
                                          "eventName" : evt.event,
                                          "SIP"       : sip,
                                          "dev_status": null,
                                          "dev_state" : evt.state,
                                          "pause"     : false
                                      };
                                      if (sip == self.Sip) return self.send(body);
                                    } break;
          case `PeerStatus`:        if(evt)if(evt.peer){
                                      body = {
                                          "event": evt.event,
                                          "peer": evt.peer.split("/", 2)[1],
                                          "peerstatus": evt.peerstatus,
                                          "address": evt.address
                                      };
                                      let aid   = body.peer ? body.peer.split("_")[1] : null;
                                      if(self)if(self.send)
                                      if(aid == this.Aid) return self.send(body);
                                    }        break;
          case `Registry`:          if(evt)if(evt.username){
                                      body = {
                                          "event":  evt.event,
                                          "username": evt.username,
                                          "domain": evt.domain,
                                          "status": evt.status
                                      };
                                      return self.send(body);
                                    }
                                    break;

          case `QueueMemberPause`:
          case `QueueMemberStatus`: if(evt)if(evt.queue && evt.membername){
                                      let sip   = evt.membername ? evt.membername.split("/", 2)[1] : null;
                                      let sip2   = sip ? sip.split("_")[0] : null;
                                      let aid   = sip ? sip.split("_")[1] : null;

                                      body = {
                                          "event": evt.event,
                                          "queue": evt.queue,
                                          "SIP": sip2,
                                          "interface": evt.interface,
                                          "stateinterface": evt.stateinterface,
                                          "membership": evt.membership,
                                          "penalty": evt.penalty,
                                          "callstaken": evt.callstaken,
                                          "lastcall": evt.lastcall,
                                          "incall": evt.incall,
                                          "status": evt.status.toString(),
                                          "pausedreason": evt.pausedreason,
                                          "ringinuse": evt.ringinuse,
                                          "pause": Boolean(parseInt(evt.paused)),
                                          "reason": evt.reason,
                                      };

                                      const msg = {
                                          "event"   : evt.event,
                                          "data"     : []
                                      };

                                      msg.data.push(body);
                                      if(aid == this.Aid) return self.send(msg);
                                    } break;

            case `Newstate`:        if(evt.channelstate == 5){
                                      let sipName = sip(evt.channel);
                                      let aID = sipName ? sipName.split("_")[1] : null;
                                      body = {
                                          "event":  evt.event,
                                          "sip": sipName,
                                          "phone": evt.connectedlinenum,
                                          "source": null,
                                          "coID":null,
                                          "channelstatedesc": evt.channelstatedesc,
                                          "channelstate": evt.channelstate,
                                      };
                                      //{"event":"bridge","sip":"500","phone":"380978442044","source":"fordev","coID":null}
                                      console.log(sipName);
                                      console.log(self.Sip);
                                      console.log(aID);
                                      console.log(this.Aid);
                                      if(aID == this.Aid && sipName == self.Sip) return self.send(body);
                                         
                                    }
                                    break;
          default: break;
        }
    };

 
  } // END CONSTRUCTOR

  //Join from web
  join(data) {
    const self      = this;
    this.LoginName  = data.loginName;
    this.Sip        = data.sip;
    this.isJoin     = true;
    this.isDiale    = false;
    this.Aid        = data.sip.split("_", 2)[1] ;
    //console.log(this.AID);
    this.send({
      event       : 'joined',
      sip         : this.Sip,
      loginName   : this.LoginName
    });

    setInterval(() => {
            const msg = AllAmiRun.get(this.Aid);
            if(msg)this.send(msg);
    }, 100000);

    
    //START AMI EVENTS
    self.ami.on('devicestatechange',  this.peerstatusHeadler)
      .on('queuememberstatus',  this.peerstatusHeadler)
      .on('queuememberpause',   this.peerstatusHeadler)
      //.on('newstate', this.newstateHeadler13)
      .on('dialbegin', this.DialHeadler13)
      .on('bridgeenter', this.BridgeHeadler);
  }


  msgDisconnect() {
    this.isJoin = false;
    console.log(`msgDisconnect++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++`);
    //STOP AMI EVENTS
    this.ami.removeListener('dialbegin',    this.DialHeadler13)
      .removeListener('devicestatechange',  this.peerstatusHeadler)
      .removeListener('queuememberstatus',  this.peerstatusHeadler)
      .removeListener('queuememberpause',   this.peerstatusHeadler)
      //.removeListener('newstate',           this.newstateHeadler13)
      .removeListener('bridgeenter',        this.BridgeHeadler);
      this.CallListRun = null;
      delete this.CallListRun;
      // this.RingListRun = null;
      // delete this.RingListRun;
      //console.log(this.CallListRun);
  }

  hangup(phone) {
    this.action.hangup(phone);
  }

  //Call from click to number
  toCall(data) {
    console.log(data);
    if (!data)             return this.sendError(`SIP-phone is empty`);
    //console.log(data);
    //console.log(data.source);
    const self  = this;
    if (!data.source)                   return this.sendError(`Phone number is empty`);
    if (!data.source.phone)             return this.sendError(`Phone number is empty`);
    const phone = data.source.phone;
    const exten = data.exten;
    data.context = `db_hint_${this.Aid}`;
    if (this.isDiale)       return this.sendError(`Already is a call by number: ${this.dialPhone}`);
    if (phone.length < 7 && phone.length > 17)  return this.sendError(`Phone number is not validate: ${phone}`);
    if (!exten)             return this.sendError(`SIP-phone is not validate: ${exten}`);
    if(data.source)
        if(data.source.coID)
          this.coID = data.source.coID;
   
    this.action.extensionState(data, (err,params) => {
      if (err) return self.sendError(err);
      params.source.CallType = `101318`;
      this.action.originate({
        source      : params.source,
        exten       : params.exten,
        context     :`office_${this.Aid}`,
        duration    : 10000,
        params : {
          Aid         : this.Aid,
          context     :`db_sip_${this.Aid}`,
          coID        : params.source.coID ? params.source.coID : null,
          isFirstClient: false
        }
      }, (err,res) => {
              if (err){
                console.log(`=========================================AMI ACTION ERROR=======================================`);
                console.log(err);
                return this.sendError(err);
              }
              else {
                this.isDiale = true;
                this.dialPhone = params.source.phone;
                //Lisner Hangup and finish call
                const hangupHeadlerCall = evt => {
                  if( evt.connectedlinenum == phone) {
                    this.isDiale = false;
                    self.ami.removeListener('hangup', hangupHeadlerCall);
                    const msg = {
                      event   : 'hangup',
                      CallType : `101318`,
                      data     : evt
                    };
                    self.send(msg);
                  }
                };
                self.ami.on('hangup', hangupHeadlerCall);
              }
              //if(res)console.log(res);
      });
    });
  }

  Action(a){
      if(a)
      switch(a.action){
        case `coreshowchannels`:
                                  // setInterval(() => {
                                    // var msg = AllAmiRun().get(this.Aid);
                                    //         if(msg)this.send(AllAmiRun.get(msg));
                                  // }, 1000);
                                  break;
                                  // this.action.coreshowchannels(null, (err,data) => {
                                  //   var parse =[];
                                  //   if(Array.isArray(data))
                                  //     if(data.length > 0)
                                  //       data.forEach( item => {
                                  //         if(item.context.split("_").pop() == `${this.Aid}` && item.uniqueid == item.linkedid ) parse.push(item);
                                  //       });
                                  //   const msg = { event : a.action, data  : parse };
                                  //   this.send(msg);
                                  // });  break;

        case `QueuePause`:
                                  a.param.interface = `${a.param.interface}_${this.Aid}`;
                                  this.action.QueuePause(a, (err,data) => {});
                                  break;

        case `QueueSummary`:
                                  //a.param.interface = `${a.param.interface}_${this.Aid}`;
                                  this.action.QueueSummary(a, (err,data) => { const msg = { event : a.action, data }; this.send(msg); });
                                  break;

        case `ExtensionState` :   this.action.extensionState( {"exten" : this.Sip, "context": a.context}, (err,data) => { const msg = { event : a.action, data }; this.send(msg); });
                                  break;

        case `DeviceStateList` :  console.log(`DeviceStateList from WS`); this.action.DeviceStateList( {"exten" : this.Sip, "context": a.context}, (err,data) => { const msg = { event : a.action, data }; this.send(msg); });
                                  break;


        default : break;
    }
  }

  Support(a){
        //POST MESS TO ROCKET
        const options = {
            uri   : `https://chat.asterisk.biz.ua/hooks/e9gcvtMYnKXWXnWDk/cm6RGsttrGj4iahh2KAsKpuMXm87c7dGhEh273rts7dLWd7E`,
            method: 'POST',
            json  : true,
            body  : a.param
        };
        //console.dir(options);
                console.dir(options.body);
                //console.dir(options.body.attachments);
        request(options,(error, payload, body) => { console.log(payload); });
  }

}

module.exports = WsClient;