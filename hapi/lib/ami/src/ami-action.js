/*jshint node:true*/
'use strict';
const conf    = require('src/config/constants.js').ami;
const ami     = require('asterisk-manager')(conf.port, conf.host, conf.user, conf.password, true);
const uuidV1  = require('uuid/v1');
const CallListRuns = require('./CallList');
const amiEvents = require('./ami-event');
const request   = require('./middleware/request');



//Keep connection for AMI
ami.keepConnected();

function isBoolean(n){
    return !!n===n;
}

const CallListRun = new CallListRuns(ami);
// ADD cuctom lisner to ami events
const amiEvent = new amiEvents(ami,CallListRun);

//Logic for lib
const internals = {};

class AmiAction {
  constructor(ami) {
    this.ami = ami;
    
  }

  sendAction(entry, callback){
    //console.log('action: ', entry);
    console.log('action: ', entry.action);
    return this.ami.action(entry, callback);
  }

  get CallListRun(){
    return CallListRun;
  }
  coreshowchannels(params, callback){
      const action = internals.CoreShowChannels(null,uuidV1());
      this.sendAction(action, (err, res) => {
        if (err) return callback(err);
        const actionid = res.actionid;
        var data =[];
        const coreshowchannelsHandler = evt => {
          if (actionid == evt.actionid)data.push(evt);
        };
        const coreshowchannelscompleteHandler = evt => {
          if (actionid == evt.actionid) {
            ami.removeListener('coreshowchannel', coreshowchannelsHandler)
               .removeListener('coreshowchannelscomplete', coreshowchannelscompleteHandler);
            if (!data) return callback(null, {err: `No active calls`});
            return callback(null, data);
          }
        };
        ami.on('coreshowchannel', coreshowchannelsHandler)
           .on('coreshowchannelscomplete', coreshowchannelscompleteHandler);
      });
       //CoreShowChannelsComplete
  }

  QueuePause(params, callback){
    const action = internals.QueuePause(params,uuidV1());
    this.sendAction(action, (err, res) => {});
  }

  DeviceStateList(params, callback){
    const action = internals.DeviceStateList(params,uuidV1());
    this.sendAction(action, (err, res) => {
          if(res)console.log(res);
          if(err)console.log(err);

    });
  }

  originate(params, callback) {
    const source      = params.source;
    const exten       = params.exten;
    const duration    = params.duration;
    const arr         = [];
    let GUID;
    if (Array.isArray(source)) {
      source.forEach(entry => {
        const jsn = internals.originate(entry, exten, duration, true, params.params);
        arr.push(jsn);
      });
    } else {
      const jsn = internals.originate(source, exten, duration, false, params.params);
      arr.push(jsn);
      GUID = jsn.variable.GUID;
    }
    arr.forEach(entry => {
      this.sendAction(entry, callback);
    });

    return GUID;
  }

  hangup(source) {
    const arr = [];
    if (Array.isArray(source)) {
      source.forEach(entry => {
        if (!entry.isBridge) {
          const jsn = internals.hangup(entry.phone);
          arr.push(jsn);
        }
      });
    } else {
      const jsn = internals.hangup(source);
      arr.push(jsn);
    }
    arr.forEach(entry => {
      this.sendAction(entry);
    });
  }

  QueueSummary(params, callback){
    if(!params)if(!params.param) if (!params.param.queID) return callback({ err: `Queue is empty` });
    const action  = internals.queuestatus(params.param.queID);
    console.log(`Queuestatus from QueueSummary from WS`);
    this.sendAction(action, (err, res) => {
          if (err) return callback(err);
          const actionid = res.actionid;
          let data = [];
          const qsHandler = evt => {
            if (actionid == evt.actionid) { evt.paused = Boolean(parseInt(evt.paused)); data.push(evt); }
          };
          const qscHandler = evt => {
            if (actionid == evt.actionid) {
              ami.removeListener('queuemember', qsHandler)
                 .removeListener('queuestatuscomplete', qscHandler);
              if (!data) return callback(null, { err: `Queue is not found` });
              return callback(null, data);
            }
          };
          ami.on('queuemember', qsHandler)
             .on('queuestatuscomplete', qscHandler);
    });
  }

  //FOR TAKO Holding
  queuesummary(params, callback) {
    const queue   = params.queue;
    const action  = internals.queuesummary(queue);
    this.sendAction(action, (err, res) => {
      if (err) return callback(err);
      const actionid = res.actionid;
      let data;
      const queuesummaryHandler = evt => {
        if (actionid == evt.actionid) {
          data = {
            "AgentsCountAll": evt.loggedin,
            "AgentsCount": evt.available,
            "Queue": evt.callers,
            "EWT": evt.holdtime, //test
            "IWT": evt.talktime //test
          };
        }
      };
      const queuesummarycompleteHandler = evt => {
        if (actionid == evt.actionid) {
          ami.removeListener('queuesummary', queuesummaryHandler)
             .removeListener('queuestatuscomplete', queuesummarycompleteHandler);
          if (!data) return callback(null, {
            err: `Queue ${exten} is not found`
          });
          return callback(null, data);
        }
      };
      ami.on('queuesummary', queuesummaryHandler)
         .on('queuesummarycomplete', queuesummarycompleteHandler);
    });
  }

  //FOR Autocall to Queues
  queuestatus(params, callback) {
    const ami     = this.ami;
    const exten   = params.exten;
    const action  = internals.queuestatus(exten);
    this.sendAction(action, (err, res) => {
      if(err) return callback(err);
      if(res)
        if(res.response == 'Success'){
              var qty = 0;
              const queuememberHeadler = evt => {
                //console.log(evt);
                if(action.id === evt.actionid && evt.status === '1' && evt.paused === '0') {
                  //console.log(evt);
                  qty++;
                }
              };
              const queuestatuscompleteHeadler = evt => {
                console.log(`queuestatuscompleteHeadler`);
                console.log(evt.actionid);
                console.log(action.id);
                 if (action.id == evt.actionid) {
                  console.log(evt);
                  params.qty = qty;
                  ami.removeListener('queuemember', queuememberHeadler)
                     .removeListener('queuestatuscomplete', queuestatuscompleteHeadler);
                  return callback(null, params);
                }
              };
              ami.on('queuemember', queuememberHeadler)
                 .on('queuestatuscomplete', queuestatuscompleteHeadler);
        } else return callback(err);
    });
  }

  //FOR Autocall to exten
  extensionState(params, callback) {
    const exten     = params.exten;
    const context   = params.context;
    if (!exten)   return callback(`Exten ${exten} is undefined`);
    if (!context) return callback(`Context ${context} is undefined`);
    const msg = `, (${context},${exten})`;
    const actionid  = 1;
    const action    = internals.ExtensionState(params, actionid);
    this.sendAction(action, (err, res) => {
      if (err) return callback(err);
      if (parseInt(res.status) !== 0) {
        let statusName;
        console.dir(res);
        switch (res.status.toString()) {
          case '-1':  statusName  = `The extension's hint was removed from the dialplan`; break;
          case '-2':  statusName  = `The extension was removed from the dialplan`;        break;
          case '1':   statusName  = `In Use`;               break;
          case '2':   statusName  = `Busy`;                 break;
          case '4':   statusName  = `Unavailable`;          break;
          case '8':   statusName  = `Ringing`;              break;
          case '9':   statusName  = `In Use & Ringing`;     break;
          case '16':  statusName  = `On Hold`;              break;
          case '17':  statusName  = `In Use & On Hold`;     break;
          default:    statusName  = `Extension not found`;  break;
        }
        return callback(`SIP-phone ${msg} is in status "${statusName}"`);
      }
      params.qty = 1;
      return callback(null, params);
    });
  }

  //FOR Autocall to dialplan check
  ShowDialPlan(params, callback)
  {
    const exten     = params.exten;
    const context   = params.context;
    if (!exten)   return callback('Exten is undefined');
    if (!context) return callback('Context is undefined');

    const actionid  = 1;
    const action    = internals.ShowDialPlan(params, actionid);
    this.sendAction(action, (err, res) => {
      console.log(`=====ShowDialPlan======`);
      if(err) console.log(err);
      if(res) console.log(res);
      if (err) return callback(err.message);
      params.qty = 1;
      return callback(null, params);
    });
  }
}

internals.QueuePause = (params, actionid) => {
  let Paused = isBoolean(params.param.isPause) ? Boolean(params.param.isPause)     : false;
  const action = {
    action      : 'QueuePause',
    actionid    : actionid,
    Paused,
    Queue       : params.param.queID ,
    Interface   : params.param.interface ,
    Reason      : 'null'
  };
  return action;
};

internals.CoreShowChannels = (params, actionid) => {
  const action = {
    action  : 'CoreShowChannels',
    actionid: actionid
  };
  return action;
};

internals.ShowDialPlan = (params, actionid) => {
  const action = {
    Action  : 'ShowDialPlan',
    Context : params.context ? params.context :'hints',
    Extension : params.exten,
    actionid: actionid
  };
  return action;
};


internals.ExtensionState = (params, actionid) => {
  const action = {
    Action  : 'ExtensionState',
    Context : params.context ? params.context :'hints',
    Exten   : params.exten,
    actionid: actionid
  };
  return action;
};

internals.DeviceStateList = (params, actionid) => {
  const action = {
    Action  : 'DeviceStateList',
    actionid: actionid
  };
  return action;
};

internals.queuestatus = exten => {
  const id =  uuidV1();
  const action = {
    action  : 'queuestatus',
    queue   : exten,
    actionid: id,
    id
  };
  return action;
};

internals.queuesummary = exten => {
  const action = {
    action: 'queuesummary',
    queue: exten,
    actionid: uuidV1()
  };
  return action;
};

internals.originate = (contact, exten, duration, isAutoCall, p) => {
  //let id_autodial = `null`,id_scenario = `null`,context = `office`, Aid = null, isFirstClient = null, coID = `null`;
  // console.log(`------------------------------------------------------------`);
  // console.log( p);
  let [id_autodial,id_scenario,context,Aid,isFirstClient,coID,destination,destdata,destdata2,roIDs] = [`null`,`null`,`office`,null,null,`null`,`null`,`null`,`null`,`null`];

  if(p){
        context       = p.context         ? p.context           : `office`;
        id_autodial   = p.id_autodial     ? p.id_autodial       : `null`;
        id_scenario   = p.id_scenario     ? p.id_scenario       : `null`;
        Aid           = p.Aid             ? p.Aid               : `null`;
        isFirstClient = isBoolean(p.isFirstClient) ? Boolean(p.isFirstClient)     : true;
        coID          = p.coID            ? p.coID              : `null`;
        destination   = p.destination     ? p.destination       : `null`;
        destdata      = p.destdata        ? p.destdata          : `null`;
        destdata2     = p.destdata2       ? p.destdata2         : `null`;
        roIDs         = p.roIDs           ? p.roIDs             : `null`;
  }

  if (!contact.phone || !context || !exten)
  console.log({err: `Phone(${contact.phone}) or Context(${context}) or Exten(${exten}) is not found` });

 
  //Auto answer if call from dialpad
  let CallInfo = contact.CallType == 101318 ? `Call-Info: answer-after=0`: `null`;
  //curl --user system:GajQFtnlejJwdEGby73Z7MBlnktMwc -k -X GET  --header "Content-Type: application/json" --header "Accept: application/json" https://localhost:3010/api/us/sequence/next/dcID
  
    // this.options = {
    //     uri   : `${http}recall/auto`,
    //     method: 'POST',
    //     json  : true,
    //     strictSSL: false,
    //     body  : { "qtyContact": 1 }
    // };
    // request(this.options, (error, payload, body) => {
    //   if(error){ console.log(`ERROR!!!!`); console.log(error);}
    //   if(Array.isArray(payload))
    //       if(payload.length > 0){ }
    // };
  
  
  const  variable  = {
                  "duration"      : duration ? `L(${duration})` : `L(10000)`,
                  "timeout"       : Math.floor(6000000),
                  isAutoCall,
                  //FOR unique call
                  "GUID"          : contact.uuid                ? contact.uuid          : `null`,
                  "sip"           : context == `db_hint_${Aid}` || context == `db_sip_${Aid}` ? exten                 : `null`,
                  "clID"          : contact.clID                ? contact.clID          : `null`,
                  "ccName"        : contact.phone               ? contact.phone         : `null`,
                  "Queue"         : context == `db_queue_${Aid}`? exten                 : `null`,            //Need to refactor and + field Queues as argument
                  "id_autodial"   : id_autodial,
                  "id_scenario"   : id_scenario,
                  "CallType"      : contact.CallType            ? contact.CallType      : `101316`,
                  "ffID"          : contact.ffID                ? contact.ffID          : `null`,
                  "ccID"          : contact.ccID                ? contact.ccID          : `null`,
                  "roIDs"         : roIDs                       ? roIDs                 : `null`,
                  //How first call
                  "isFirstClient" : isBoolean(isFirstClient)    ? Boolean(isFirstClient): `null`,
                  //Companies
                  "coID"          : coID                        ? coID                  : `null`,
                  //Destination
                  "destination"   : destination                 ? destination           : `null`,
                  "destdata"      : destdata                    ? destdata              : `null`,
                  "destdata2"     : destdata2                   ? destdata2             : `null`,
                  //TTS filds settings
                  "curID"         : contact.curID               ? contact.curID         : `null`,
                  "langID"        : contact.langID              ? contact.langID        : `null`,
                  "sum"           : contact.sum                 ? contact.sum           : `null`,
                  "ttsText"       : contact.ttsText             ? contact.ttsText       : `null`,
                  "curName"       : contact.curName             ? contact.curName       : `null`,
                  "langName"      : contact.langName            ? contact.langName      : `null`,
                  clName          : contact.clName              ? contact.clName        : `null`,
                  ShortName       : contact.ShortName           ? contact.ShortName     : `null`,
                  CompanyID       : contact.CompanyID           ? contact.CompanyID     : `null`,
                  CallDate        : contact.CallDate            ? contact.CallDate      : `null`,
                  KVEDName        : contact.KVEDName            ? contact.KVEDName      : `null`,
                  KVED            : contact.KVED                ? contact.KVED          : `null`,
                  Sex             : contact.Sex                 ? contact.Sex           : `null`,
                  IsPerson        : isBoolean(contact.IsPerson) ? Boolean(contact.IsPerson)  : `null`,
                  Comment         : contact.Comment             ? contact.Comment       : `null`,
                  ParentName      : contact.ParentName          ? contact.ParentName    : `null`,
                  ffName          : contact.ffName              ? contact.ffName        : `null`,
                  ActualStatus    : contact.ActualStatus        ? contact.ActualStatus  : `null`,
                  PositionName    : contact.PositionName        ? contact.PositionName  : `null`,
                  emName          : contact.emName              ? contact.emName        : `null`,
                  ActDate         : contact.ActDate             ? contact.ActDate       : `null`,
                  cusID           : contact.cusID               ? contact.cusID         : `null`,
                  Account         : contact.Account             ? contact.Account       : `null`,
                  Bank            : contact.Bank                ? contact.Bank          : `null`,
                  TaxCode         : contact.TaxCode             ? contact.TaxCode       : `null`,
                  RegCode         : contact.RegCode             ? contact.RegCode       : `null`,
                  CertNumber      : contact.CertNumber          ? contact.CertNumber    : `null`,
                  SortCode        : contact.SortCode            ? contact.SortCode      : `null`,
                  OrgType         : contact.OrgType             ? contact.OrgType       : `null`,
                  "dcID"          : contact.dcID                ? contact.dcID          : `null`

                  //__SIPADDHEADER51  : CallInfo
  };

  var ActChannel,ActContect,ActExten;
  //console.log(`${isFirstClient}======================================`);
  if(isFirstClient){
    ActChannel  = `Local/${contact.phone}@office_${Aid}/n`;
    ActContect  = context ? context                 : `null`;
    ActExten    = exten   ? exten                   : `null`;
  }
  else {
    ActChannel  = `Local/${exten}@${context}/n`;
    ActContect  = `office_${Aid}`;
    ActExten    = contact.phone;
  }

  var ClidCallType;
  switch(variable.CallType){
    case `101316` : ClidCallType = `AC`; break;
    case `101317` : ClidCallType = `WC`; break;
    case `101318` : ClidCallType = `CC`; break;
    case `101319` : ClidCallType = `CB`; break;
    case `101320` : ClidCallType = `LC`; break;
    case `101321` : ClidCallType = `RC`; break;
    default       : ClidCallType = `AC`; break;
  }

  var CallerIDName = contact.clName !== undefined ? `:${contact.clName}` : ``;
  //var AclID = contact.clID ? `${contact.clID}`: "" ;
  var Auuid =  contact.uuid ? `${contact.uuid}`: "" ;
  const action    = {
      "action"    : `originate`,
      "channel"   : ActChannel,
      "context"   : ActContect,
      "exten"     : ActExten,
      "priority"  : 1,
      "CallerID"  : `${ClidCallType}${CallerIDName} <${contact.phone}>` ,
      //"Account"   : AclID || Auuid ? `${AclID}${Auuid}` : null,
      //"Account"   :  Auuid ? Auuid : null,
      "Account"   :  JSON.stringify({"uuid":Auuid,"clID":variable.clID,"dcID":variable.dcID}),
      "Async"     : `true`,
      "Timeout"   : 30000,
      //"actionid"  : uuidV1(),
      variable
    };
    return action;
};

internals.hangup = phone => {
  const channel = `/^(Local|SIP|SCCP|IAX)/${phone}.*$/`;
  const action = {
    action  : 'Hangup',
    channel : channel
  };
  return action;
};

internals.autocall = isEnable => {
  const action = {
    action    : 'userevent',
    userevent : 'autocall',
    enable    : `${isEnable}`
  };
  return action;
};

const amiAction = new AmiAction(ami);
module.exports = amiAction;