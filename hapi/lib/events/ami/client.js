/*jshint node:true*/
'use strict';

const Handlers = require('./handlers');
const AmiAction = require('./action');

class WsClient {
  constructor(data) {

    const self        = this;
    this.isDiale      = false;
    this.isClose      = false;
    this.isProgress   = false;
    this.SecretID     = data.SecretID;
    this.ws           = data.ws;
    this.extenDefault = data.extenDefault ? data.extenDefault : '5000';
    this.action       = AmiAction;
    this.ami          = this.action.ami;

    this.send = msg => {
      if (!self.isJoin) return;

      if (msg.event === 'err') {
        self.isProgress = false;
      }
      self.ws.send(JSON.stringify(msg));
    };

    this.sendError = rows => {
      const msg = {
        event: 'err',
        data: rows
      };
      self.send(msg);
    };

    this.robocall = (err, params) => {
      if (err) return self.sendError(err);

      const qty = params.qty;
      const ffID = params.ffID;
      const uri = params.uri;
      const exten = params.exten;
      const maxduration = params.maxduration;
      const factor = params.factor;

      if (!qty) {
        const err = `Not available SIP numbers for group "${exten}"`;
        return resultHandler(err);
      }
      const qtyContact = qty * factor;
      console.log('Qty coontacts: ', qtyContact);

      sourceHandler(qtyContact, ffID, uri, (err, data) => {
        if (!data.length) self.sendError('Customer not found');

        const sourceList = [];
        const bridgeList = [];
        const hangupList = [];
        data.forEach(entry => {
          const ent = {
            clID: entry.clID,
            phone: entry.phone,
            clName: entry.clName,
            isBridge: 0
          };
          sourceList.push(ent);
        });
        if (sourceList.length >= 0) {
          self.action.originate({
            source: sourceList,
            exten: exten,
            duration: maxduration
          });
        }
        // Asterisk 11
        self.ami.on('bridge', bridgeHeadler);
        self.ami.on('hangup', hangupHeadler);
      });
    };
  }

  join(data) {
    const self = this;
    this.LoginName = data.loginName;
    this.Sip = data.sip;
    this.isJoin = true;
    this.isDiale = false;

    this.send({
      event: 'joined',
      sip: this.Sip,
      loginName: this.LoginName
    });

    this.ami.on('bridge', evt => {
      if (!self.isJoin) return;

      var [sip, phone] = '';
      if (evt.callerid2.length < 9) {
        [sip, phone] = [evt.callerid2, evt.callerid1]; // Outgoing
      }
      else {
        [sip, phone] = [evt.callerid1, evt.callerid2]; // Incoming
      }

      if (sip === self.Sip && evt.bridgestate === 'Link') {
        const msg = {
          event: 'bridge',
          sip: sip,
          phone: phone
        };
        self.send(msg);
      }
    });

    const DialHeadler = evt => {
      if (self.dialPhone === evt.channel.substring(6, 18)) {
        const phone = evt.channel.substring(6, 18);
        if (evt.subevent === 'End') {
          self.dialPhone = null;
          self.isDiale = false;
        }
        return self.send({
          event: 'dial',
          phone: phone,
          subevent: evt.subevent,
          dialstatus: evt.dialstatus
        });
      }
    };
    self.ami.on('dial', DialHeadler);

    // Asterisk => 13
    this.ami.on('bridgeenter', evt => {
      if (!self.isJoin) return;

      const sip = evt.callerid2;
      if (sip === self.Sip && evt.bridgestate === 'Link') {
        const phone = evt.callerid1;
        const p = {
          loginName: 'root',
          params: phone
        };
        const msg = {
          event: 'bridge',
          sip: sip,
          phone: phone,
        };
        self.send(msg);
      }
    });
  }

  msgDisconnect() {
    this.isJoin = false;
  }

  hangup(phone) {
    this.action.hangup(phone);
  }

  toCall(data) {
    const self = this;
    const phone = data.source.phone;
    const exten = data.exten;
    if (this.isDiale) {
      const errMsg = `Already is a call by number: ${this.dialPhone}`;
      return this.sendError(errMsg);
    }
    if (phone.length < 11) {
      const errMsg = `Phone number is not validate: ${phone}`;
      return this.sendError(errMsg);
    }
    if (!exten) {
      const errMsg = `SIP-phone is not validate: ${exten}`;
      return this.sendError(errMsg);
    }

    this.action.extensionState(data, (err,params) => {
      if(err) return self.sendError(err);

      this.action.originate({
        source: params.source,
        exten: params.exten,
        duration: 10000
      });
      this.isDiale = true;
      this.dialPhone = params.source.phone;
    });
  }

  prgStart(data) {
    const self = this;
    if (this.isProgress) {
      const data = {
        event: 'err',
        data: 'redial is already running'
      };
      return self.send(data);
    }
    this.isProgress = true;
    const params = {
      factor: data.factor ? data.factor : 1,
      exten: data.exten ? data.exten : this.extenDefault,
      ffID: data.ffID,
      uri: data.url,
      maxduration: data.maxduration ? data.maxduration : 10000
    };
    self.action.extensionState(params, self.robocall);
  }

  prgAuto(data) {
    const self = this;
    if (this.isProgress) {
      const data = {
        event: 'err',
        data: 'redial is already running'
      };
      return self.send(data);
    }
    this.isProgress = true;

    const params = {
      factor: data.factor ? data.factor : 1,
      exten: data.exten ? data.exten : this.extenDefault,
      ffID: data.ffID,
      uri: data.url,
      maxduration: data.maxduration ? data.maxduration : 10000
    };
    
    self.action.queuestatus(params, self.robocall);
  }

  prgStop() {
    this.isProgress = false;
  }
}
module.exports = WsClient;