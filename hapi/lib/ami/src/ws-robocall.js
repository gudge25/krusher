/*jshint node:true*/
'use strict';

const request   = require('./middleware/request');
const amiAction = require('./ami-action');
const utils = require('./middleware/utils');

const CallListRuns = require('./CallList');
const CallListRun = new CallListRuns(amiAction.ami);
 
class WsClientDeamon {
  constructor(data) {
    const self        = this;
    this.isProgress   = false;
    this.id_autodial  = data.id_autodial;
    this.DEvent       = data.DEvent;
    this.action       = amiAction;
    this.ami          = this.action.ami;

    this.send = msg => {
      msg.id_autodial = this.id_autodial;
      if (msg.event == 'err') this.id_autodial = false;
      this.DEvent(JSON.stringify(msg));
    };
    this.sendError = data => {
      self.send({ event : 'err',data  : data});
    };
    //Primary logic for autocall
    this.robocall = (err, params) => {
      if (err) return self.sendError(err);
      const qty         = params.context == `db_queue` ? params.qty : 1;       //Max isAvalible member
      const ffID        = params.ffID;      //Base ID
      const exten       = params.exten;     //Queue or Member name
      const maxduration = params.maxduration;
      const factor      = params.factor;    //N * for calls
      const id_autodial = params.id_autodial;

      /*===================== Конец цыкла и отправка на веб запрова о повторе цыкла =====================*/
      const resultHandler = (err, data) => {
        self.isProgress = false;
        if (err) return self.sendError(err);
        data.event = 'progress-end';
        self.send(data);
      };

      const resultHandlerBridge  = (err, data) => {
        if (err) return self.sendError(err);
        data.event = 'progress-bridge';
        self.send(data);
      };

      //Если есть свободные операторы
      if (!qty) return resultHandler(`Not available SIP numbers for group "${exten}"`);

          let dataC = params.sourceList;//.item.Setting.sourceList;
          if (!dataC.length) self.sendError('Customer not found');
          const sourceList = [],bridgeList = [],hangupList = [];
          //Client Data Maping2 add isBridge
          dataC.forEach(e =>  sourceList.push(e));
          //dataC.forEach(e =>  sourceList.push({ clID : e.clID, phone : e.phone, clName : e.clName, ffID : e.ffID, ccID : e.ccID, isBridge: false, isHangup: false, uuid : e.uuid, "curID": e.curID, "langID": e.langID, "sum":e.sum ,"ttsText":e.ttsText ,"curName" :  e.curName, "langName": e.langName})  );
          /*=====================  START ASTERISK CALL, all sourcelist to ami originate =====================*/
          if (sourceList.length >= 0) {
              self.action.originate({
                "source"  : sourceList,
                "exten"   : exten,
                "duration": maxduration,
                "params"  : params
              }, (err,res) => {
                //if(res) console.log(res);
                if(err) { console.log(`=========================================AMI ACTION ERROR/RESPONCE=======================================`); console.log(err);}
                if (err) return self.sendError(err.message); });
          }
 
          const bridgeHeadler13 = evt => {
            CallListRun.start(evt, cb => {              
              sourceList.forEach( e => {
                if(cb.ccName == e.phone){
                      //console.log(`============================1==================================`);

                      if( bridgeList.findIndex(x => x.phone === e.phone) == -1 ) {
                            //console.log(`============================2==================================`);
                            //console.log(cb); 
                            e.isBridge = true;
                            e.phone = utils.clearnum(e.phone.trim());
                            bridgeList.push(e);
                            resultHandlerBridge(null, { bridgeList });
                      }
                }
              });              
            });
          };
          
          function source(chan){
            //Clear chanel and convert to source
            let a   = chan        ? chan.split("/")[1] : null;
            a       = a ? a.split("-")[0] : null;
            a       = a ? a.split("@")[0] : null;
            return a ? a.split("_")[0] : null;
          }

          //Подсчет завершенных звонков к всему списку, и если все завершеный деалем отправку на веб уведомление
          const hangupHeadler = evt => {
              //const EvtUUID = evt.accountcode.substring(evt.accountcode.lastIndexOf("+") + 1, evt.accountcode.length).trim();
              // console.log(`=============================================evt.accountcode=================================`);
              // console.log(evt);  
              if(evt.accountcode && evt.accountcode != '' && evt.uniqueid == evt.linkedid){
                  let account = JSON.parse(evt.accountcode);
                  const EvtUUID = account.uuid;
                  //Bug when num with + 
                  let ClearNum = utils.clearnum(evt.connectedlinenum.trim()); //connectedlinenum
                  //console.log(`======= Hangup Event =====ClearNum: ${ClearNum}====`);
                  //console.log(evt);
                  //channel: 'Local/380978442044@office_10-000000a0;1',

                  sourceList.forEach( e => {
                    //console.log(`======= Hangup Event == ${ClearNum} == ${e.phone}`);

                    //console.log(`======= Hangup Event == ${ClearNum} == ${e.phone} == ${EvtUUID} == ${e.uuid} == `);
                    if ( (ClearNum == e.phone || utils.clearnum(source(evt.channel.trim())) == e.phone) && !e.isHangup && hangupList.indexOf(ClearNum) == -1 && EvtUUID == e.uuid) {
                      console.log(`======= Hangup Event Client=========EvtUUID: ${EvtUUID} == uuid: ${e.uuid} === ${ClearNum} == ${e.phone}`);
                      e.isHangup = true;
                      e.phone = utils.clearnum(e.phone.trim());
                      hangupList.push(e);
                      if (hangupList.length == sourceList.length) { //sourceList.length - hangupList.length < qty //9call < 10 SIP then run whine
                        //console.log(`)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))`);
                          self.ami.removeListener('bridgeenter', bridgeHeadler13)
                                  .removeListener('hangup', hangupHeadler);
                          resultHandler(null, { sourceList });
                      }
                    }
                  });
              }
          };

          self.ami.on('bridgeenter', bridgeHeadler13)
                  .on('hangup', hangupHeadler);

    };
  } // END CONSTRUCTOR

  //Start auto call for Queue
  prgAuto(data) {
    const self      = this;
    if (this.isProgress) return self.send({ event: 'err', data: 'redial is already running' });
    this.isProgress = true;
    this.id_autodial = data.item.id_autodial;
    const params    = {
          "Aid"           : data.item.Aid                   ? data.item.Aid       : null,
          "factor"        : data.item.factor                ? data.item.factor       : 1,
          "exten"         : data.item.Setting.exten         ? data.item.Setting.exten        : null,
          "ffID"          : data.item.ffID,
          "context"       : data.item.Setting.context,
          "id_autodial"   : data.item.id_autodial,
          "id_scenario"   : data.item.id_scenario,
          "isFirstClient" : data.item.isFirstClient,
          "roIDs"         : data.item.roIDs,
          "qty"           : data.item.Setting.FreeMember,
          "sourceList"    : data.item.Setting.sourceList,
          "destination"   : data.item.destination,
          "destdata"      : data.item.destdata,
          "destdata2"     : data.item.destdata2,
    };
    self.robocall(null,params);
  }

}
module.exports = WsClientDeamon;