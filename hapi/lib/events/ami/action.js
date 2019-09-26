/*jshint node:true*/
'use strict';

const conf = require('src/config/constants.js').ami;
const ami = require('asterisk-manager')(conf.port, conf.host, conf.user, conf.password, true);
const UuidV1 = require('uuid/v1');

ami.keepConnected();
// ami.on('managerevent', function(evt) {
//   console.log(evt);
// });
// ami.on('response', function(evt) {
//   console.log(res);
// });

const internals = {};

internals.sendAction = (entry, callback) => {
  console.log('action: ', entry);
  return ami.action(entry, callback);
};

exports.originate = (params, callback) => {
  const source = params.source;
  const exten = params.exten;
  const duration = params.duration;
  const texttospeach = params.texttospeach;
  const arr = [];
  let GUID;
  if (Array.isArray(source)) {
    source.forEach((entry) => {

      const jsn = internals.originate(entry, exten, duration, 1, texttospeach);
      arr.push(jsn);
    });
  }
  else {
    const jsn = internals.originate(source, exten, duration, 0, texttospeach);
    arr.push(jsn);
    GUID = jsn.variable.GUID;
  }
  arr.forEach((entry, index) => {

    internals.sendAction(entry, callback);
  });

  return GUID;
};

exports.hangup = source => {
  const arr = [];
  if (Array.isArray(source)) {
    source.forEach((entry, index) => {

      if (!entry.isBridge) {
        const jsn = internals.hangup(entry.phone);
        arr.push(jsn);
      }
    });
  }
  else {
    const jsn = internals.hangup(source);
    arr.push(jsn);
  }

  arr.forEach(entry => {
    internals.sendAction(entry);
  });
};

exports.queuesummary = (params, callback) => {
  const queue = params.queue;
  const action = internals.queuesummary(queue);
  internals.sendAction(action, (err, res) => {

    if (err) return callback(err);

    const actionid = res.actionid;
    let data;
    const queuesummaryHandler = evt => {
      if (actionid === evt.actionid) {
        data = {
          'AgentsCountAll': evt.loggedin,
          'AgentsCount': evt.available,
          'Queue': evt.callers,
          'EWT': evt.holdtime, //test
          'IWT': evt.talktime //test
        };
      }
    };

    const queuesummarycompleteHandler = evt => {
      if (actionid === evt.actionid) {
        ami.removeListener('queuesummary', queuesummaryHandler);
        ami.removeListener('queuestatuscomplete', queuesummarycompleteHandler);
        if (!data) {
          return callback(null, {
            err: `Queue ${exten} is not found`
          });
        }
        return callback(null, data);
      }
    };
    ami.on('queuesummary', queuesummaryHandler);
    ami.on('queuesummarycomplete', queuesummarycompleteHandler);
  });
};

exports.queuestatus = (params, callback) => {
  const a = ami;
  const exten = params.exten;
  const action = internals.queuestatus(exten);
  internals.sendAction(action, (err, res) => {

    if (err) {
      return callback(err);
    }
    const actionid = res.actionid;
    let qty = 0;

    const queuememberHeadler = evt => {
      if (actionid === evt.actionid && evt.status === '1' && evt.paused === '0') {
        qty++;
      }
    };

    const queuestatuscompleteHeadler = evt => {
      if (actionid === evt.actionid) {
        params.qty = qty;
        a.removeListener('queuemember', queuememberHeadler);
        a.removeListener('queuestatuscomplete', queuestatuscompleteHeadler);
        return callback(null, params);
      }
    };
    a.on('queuemember', queuememberHeadler);
    a.on('queuestatuscomplete', queuestatuscompleteHeadler);
  });
};

exports.extensionState = (params, callback) => {
  const exten = params.exten;
  if (!exten) return callback('Exten is undefined');

  const actionid = 1;
  const action = internals.ExtensionState(exten, actionid);
  internals.sendAction(action, (err, res) => {

    if (err) return callback(err);

    if (res.status !== 0) {
      let statusName;
      switch (res.status) {
      case 1:
        statusName = 'In Use';
        break;
      case 2:
        statusName = 'Busy';
        break;
      case 4:
        statusName = 'Unavailable';
        break;
      case 8:
        statusName = 'Ringing';
        break;
      case 16:
        statusName = 'On Hold';
        break;
      default:
        statusName = 'Extension not found';
        break;
      }
      return callback(`SIP-phone is in status "${statusName}"`);
    }

    params.qty = 1;
    return callback(null, params);
  });
};

internals.ExtensionState = (exten, actionid) => {
  const action = {
    Action: 'ExtensionState',
    Context: 'hints',
    Exten: exten,
    ActionID: actionid
  };
  return action;
};

internals.queuestatus = exten => {
  const action = {
    action: 'queuestatus',
    queue: exten
  };
  return action;
};

internals.queuesummary = exten => {
  const action = {
    action: 'queuesummary',
    queue: exten
  };
  return action;
};

internals.originate = (contact, exten, duration, isAutoCall, text) => {

  const channel_local = `Local/${contact.phone}@office/n`;
  duration = duration ? duration : 10000;
  const dur = `L(${duration})`;
  const time = Math.floor(duration / 1000);
  const guid = UuidV1();
  const action = {
    action: 'originate',
    channel: channel_local,
    context: 'office',
    exten: `${exten}`,
    priority: 1,
    CallerID: `${contact.phone}`,
    Account: `${contact.clID}`,
    Async: 'true',
    variable: {
      duration: dur,
      timeout: time,
      isAutoCall: isAutoCall ? isAutoCall : 0,
      texttospeach: text,
      GUID: guid,
      sip: `${exten}`
    }
  };
  return action;
};

internals.hangup = phone => {
  const channel_local = `/^(Local|SIP|SCCP)/${phone}.*$/`;
  const action = {
    action: 'Hangup',
    channel: channel_local
  };
  return action;
};

internals.autocall = isEnable => {
  const action = {
    action: 'userevent',
    userevent: 'autocall',
    enable: `${isEnable}`
  };
  return action;
};