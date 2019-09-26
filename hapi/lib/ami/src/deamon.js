/*jshint node:true, esnext:true*/
'use strict';
const WsClientDeamon  = require('./ws-robocall');
const request   = require('./middleware/request');
const constants = require('../src/config/constants').application;
const amiAction = require('./ami-action');
const uuidV1  	= require('uuid/v1');
const moment    = require('moment');
const events = require("events");
events.EventEmitter.prototype._maxListeners = 5000;
events.EventEmitter.defaultMaxListeners     = 1000;

function CEvent(message) {
    const data = JSON.parse(message);
    const options = { "DEvent" : DEvent };
    const wsClient = new WsClientDeamon(options);
    switch (data.action) {
        case 'autocall':      wsClient.prgAuto(data);       break;    //Predictive Type
        //case 'join':          wsClient.join(data.user);     break;    //auth & Login from web
        //case 'progress-stop': wsClient.prgStop();           break;    //Stop
        //case 'hangup':        wsClient.hangup(data.phone);  break;    //Hangup call by phone number
    }
}

const httpsport = parseInt(constants.port) == 80 ? 443 :  parseInt(constants.port) + 10;
const http = `https://system:GajQFtnlejJwdEGby73Z7MBlnktMwc@localhost:${httpsport}/api/ast/`;

const Deamon = class Deamon {
    constructor()
    {
        //FIND PROCCESS
        this.options = {
            uri   : `${http}autodial/process/find`,
            method: 'POST',
            json  : true,
            strictSSL: false,
            body  : { "id_autodial": null,"process": 101602,"ffID": null,"id_scenario": null,"emID": null,"factor": null,"called": null,"targetCalls": null,"errorDescription": null,"description": null, "isActive": null, "planDateBegin": null}
        };
        const self = this;
        if(self.processList === undefined)
            self.processList = [];
    }

    queuememberwatch( ){
        const self        = this;
        this.isQueueWatch = true;
        const qsHandler = evt => {
            self.processList.forEach( item => {
                switch(item.Scenario[0].destination){
                    case 101401 :                      if(item.Scenario[0].destdata.toString() == evt.queue && evt.paused == '0' && evt.incall == '0' && evt.status == '1') self.procces(item.id_autodial); break;                     
                }
            });
        };
        amiAction.ami.on('queuememberpause', qsHandler);
        //console.log(`START QUEUEU WATCH`);
    }

    getProcess()
    {
        const self        = this;
        this.options = new Deamon().get();
        this.options.body.offset   = null;
        this.options.body.limit    = null;
        this.options.body.sorting  = null;
        this.options.body.field    = null;
        this.options.body.planDateBegin         = moment().format("YYYY-MM-DDTHH:mm:ss");
        
        //Get All AutoProcces
        request(this.options, (error, payload, body) => {
            if(error || !Array.isArray(payload)){
                    console.log(`STOP SCRIPT!!!!!! getProcess ERROR ${error} Payload: ${payload}`);
                    
                    setTimeout( () => {
                            console.log(`==========> Re-CONNECT TO HAPI <=========\n`);
                            this.getProcess();
                    }, 20000);
                    return -1;
            }
            else {
                //if(!Array.isArray(payload)) return console.log(`STOP SCRIPT!!!!!! getProcess ERROR ${payload}`);
                //Setup ProcessList
                payload = payload !== undefined ? payload : [];
                if(Array.isArray(payload))
                if(payload.length > 0)
                {
                    //Add to list if new
                    payload.forEach( item => {
                        let model = { 	"Aid": item.Aid,
                            "id_autodial": item.id_autodial,
                            "id_scenario": item.id_scenario,
                            "Scenario": null,
                            "factor": item.factor,
                            "ffID": item.ffID,
                            "isProgress": false,
                            "QtyQ": 0,
                            "QtyS" : 0,
                            "Setting" : {
                                            exten 		: null,
                                            context 	: null,
                                            FreeMember 	: 0,
                                            qtyContact 	: 0,
                                            CurrentCall	: 0,
                                            sourceList  : []
                                        },
                            "roIDs": null,
                            "isFirstClient": null
                        };
                        if( self.processList.findIndex(x => x.id_autodial === item.id_autodial) == -1 ) {
                            //Get scenario for EXTEN
                            let a = {
                                uri   : `${http}scenario/find`,method: 'POST', json: true, strictSSL: false,        
                                body  :   {"id_scenario":item.id_scenario,"name_scenario":null,"callerID":null,"TimeBegin":null,"TimeEnd":null,"DaysCall":null,"RecallCount":null,"RecallAfterMin":null,"RecallCountPerDay":null,"RecallDaysCount":null,"RecallAfterPeriod":null,"AutoDial":null,"IsRecallForSuccess":null,"IsCallToOtherClientNumbers":null,"IsCheckCallFromOther":null,"AllowPrefix":null,"destination":null,"destdata":null,"target":null,"isFirstClient":null,"isActive":null,"offset":0,"limit":null}
                            };                           
                            request(a, (error, payload2, body) => {
                                payload2 = payload2 !== undefined ? payload2 : [];
                                if(Array.isArray(payload2))
                                if(payload2.length > 0){
                                    model.Scenario = payload2;
                                    self.processList.push(model);
                                }
                            });
                            
                        }
                    });
                    //Delete from list not active
                    let arr = [];
                    payload.forEach( item => {
                        self.processList.forEach( item2 => {
                            if( item.id_autodial === item2.id_autodial ) arr.push(item2);
                        });
                    });
                    self.processList = arr;
                }
                else
                    self.processList = [];

                 //Run singl proccess
                if(self.processList.length > 0)
                {
                    self.processList.forEach( item => {
                        if(!item.isProgress){
                            item.isProgress   = true;
                            this.procces(item.id_autodial);
                        }
                    });
                }
                setTimeout( () => {
                    console.log(`==========> Re-Start Process List, Qty procces: ${self.processList.length} <=========\n`);
                    this.getProcess();
                }, 10000);
            }
        });
    }

    get(){
        return this.options;
    }

    stop(ev,type){
        this.processList.forEach( item => {
            if(ev.id_autodial == item.id_autodial) {
                let o = new Deamon().get();
                o.body.id_autodial = item.id_autodial;

                request(o, (error, payload, body) => {
                    payload = payload !== undefined ? payload : [];
                    if(Array.isArray(payload))
                    if(payload.length > 0){
                        o.body=payload[0];
                        delete o.body.limit; delete o.body.offset; delete o.body.Aid; delete o.body.Changed; delete o.body.Created;
                        if(o)if(o.body)if(ev)if(ev.data)    o.body.errorDescription   = ev.data;
                        if(!type) o.body.process            = o.body.errorDescription == `Customer not found`? 101604 :  101603;
                        o.body.isActive           = true;
                        o.uri                     = `${http}autodial/process/`; //${o.body.id_autodial}`;
                        o.method                  = `PUT`;
                        request(o, (error, payload, body) => {
                            if(error) return console.log(`STOP SCRIPT update Procces!!!!!! ERROR ${error} \n`);
                            if(!type){
                                item.isProgress = false;
                                item.QtyQ = 0;
                            }
                        });
                    }
                });
            }
        });
    }

    /*===================== Get source list clients =====================*/
    sourceHandler(item, callback){
        const options = { "uri" : `${http}autodial/process/autocall`, method: 'POST', json: true, strictSSL: false, body: { id_autodial: item.id_autodial, qtyContact : item.Setting.qtyContact } };
        request(options, (error, payload, body) => {
            payload = payload !== undefined ? payload : [];
            if (error) { console.log(error);  this.stop({ id_autodial : item.id_autodial, data: error}); /*self.send({ event : 'err', data  : error }); */ return -1;  }
            //Client Data Maping
            const data = [];
            if(Array.isArray(payload))
            if(payload.length > 0){
                payload.forEach(e => {
                    if(e.phone && e.clID && e.ccID && e.clName) {
                        e.phone.trim();
                        e.phone = e.phone.replace(/\D/g, "");
                        console.log(`====PHONE===CLEAR=====${e.phone}============`);
                        //Fix for Denis bug where i get one client ? relusl more 2;
                        if( data.findIndex(x => x.clID === e.clID && x.phone === e.phone ) == -1 ){
                            //data.push({ "clID": e.clID, "phone": e.phone, "clName": e.clName, "ffID": e.ffID, "ccID": e.ccID, "uuid": e.uuid, "curID": e.curID, "langID": e.langID, "sum":e.sum ,"ttsText":e.ttsText,"curName" :  e.curName, "langName": e.langName });
                            e.isBridge      = false;
                            e.isHangup      = false;
                            e.uuid          = uuidV1();
                            e.isProgress    = false;
                            data.push(e);
                        }
                    }
                });

                //if diferent length payload.length item.Setting.qtyContact
                if (data.length != payload.length ) { 
                    error = `No valid data length in clients, expecting ${payload.length}, got ${data.length}`; console.log(error);   
                }
            }
            else 
                error = `Customer not found`;
            
            // wait for denis fix bug
            if(error)
                this.stop({ "id_autodial" : item.id_autodial, "data": error });
            else
            return callback(error, data);
        });
    }

    procces(id)
    {
        if(id)
        {
            this.processList.forEach( item => {
                if(item.id_autodial === id)
                {
                    //Debounse
                    clearTimeout(item.debounce);
                    item.debounce = setTimeout(() => {
                        console.log(`\n ============================> Start Procces ID ${id} , Queues ${item.QtyS} <================================\n`);
                        item.QtyS++;
                        var [exten,context] = [null,null];
 
                     
                            const payload = item.Scenario ? item.Scenario : null ;
              
                            var ProcessID = (err,data) => {
                                if (err) { console.log(`err ======= `); console.log(err); this.stop({ id_autodial : item.id_autodial, data: err}); return -1; }

                                //IF QTY NULL
                                if (!data.qty && item.destination != 101401) { this.stop({ id_autodial : item.id_autodial, data: 'Not set qty or factory'}); return -1; }
                                if (!data.qty && item.destination == 101401) {
                                    let msg = `EMPTY QUEUES ID ${item.Setting.exten},Queue hold #${item.QtyQ}`;
                                    console.log(`FOR EMPTY QUEUES = TRUE LOGIC Queue hold ${item.QtyQ}, exten ${item.Setting.exten}, context ${item.Setting.context}, id_autodial ${item.id_autodial}\n`);
                                    this.stop({ id_autodial : item.id_autodial, data: msg , isQueueHold: true},true);
                                    //30 min system will check if in queue exist members
                                    if(item.QtyQ > 600)  {
                                        console.log(`Автообзвон остановлен!`); this.stop({ id_autodial : item.id_autodial, data: `Not available SIP numbers for group ${item.Setting.exten}`}); return -1;
                                    }
                                    debounce = setTimeout(() => { item.QtyQ ++;  this.procces(item.id_autodial); }, 3000);
                                }

                                item.Setting.context     = context;
                                item.Setting.FreeMember  = data.qty;			//10
                                item.Setting.MaxCall     = item.factor*data.qty;  //100
                                item.Setting.CurrentCall = item.Setting.CurrentCall !== undefined ? item.Setting.sourceList.length : 0;
                                console.log(`item.Setting`);
                                console.log(item.Setting);
                                //if len CurrentCall < MaxCall
                                item.Setting.qtyContact  = item.Setting.CurrentCall >= item.Setting.MaxCall ? 0 : item.Setting.MaxCall - item.Setting.CurrentCall;

                                /*===================== Get source list clients =====================*/
                                if(item.Setting.CurrentCall <= item.Setting.MaxCall && item.Setting.qtyContact){
                                    this.sourceHandler(item, (err, data) => {
                                        if (!data.length) console.log('Customer not found');
                                        //Client Data Maping2 add isBridge
                                        //data.forEach(e =>  item.Setting.sourceList.push({ clID : e.clID, phone : e.phone, clName : e.clName, ffID : e.ffID, ccID : e.ccID, isBridge: false, isHangup: false, uuid : uuidV1(), isProgress: false, "curID": e.curID, "langID": e.langID, "sum":e.sum ,"ttsText":e.ttsText ,"curName" :  e.curName, "langName": e.langName})  );
                                        data.forEach(e =>  item.Setting.sourceList.push(e));
                                        /*=====================  START ASTERISK CALL, all sourcelist to ami originate =====================*/
                                        if (item.Setting.sourceList.length >= 0) {
                                            item.Setting.CurrentCall	= item.Setting.sourceList.length;

                                            item.Setting.sourceList.forEach(e => {
                                                if(!e.isProgress)
                                                {
                                                    e.isProgress 	= true;
                                                    const copyModifItem = {
                                                          "Aid"         : item.Aid,
                                                          "id_autodial" : item.id_autodial,
                                                          "id_scenario" : item.id_scenario,
                                                          "factor"      : item.factor,
                                                          "ffID"        : item.ffID,
                                                          "isProgress"  : item.isProgress,
                                                          "QtyQ"        : item.QtyQ,
                                                          "QtyS"        : item.QtyS,
                                                          "destination" : item.destination,
                                                          "destdata"    : item.destdata,
                                                          "destdata2"   : item.destdata2,
                                                          "Setting":
                                                                { "exten"        : item.Setting.exten,
                                                                  "context"      : item.Setting.context,
                                                                  "FreeMember"   : item.Setting.FreeMember,
                                                                  "qtyContact"   : item.Setting.qtyContact,
                                                                  "CurrentCall"  : item.Setting.CurrentCall,
                                                                  "sourceList"   : [e],
                                                                  "MaxCall"      : item.Setting.MaxCall
                                                                },
                                                          "isFirstClient": item.isFirstClient,
                                                          "roIDs"        : item.roIDs
                                                    };

                                                    this.jsn = { action : `autocall`,  item : copyModifItem };
                                                    CEvent(JSON.stringify(this.jsn));
                                                }
                                            });
                                        }
                                    });
                                } else { console.log(`===========FULL CurrentCall======${item.id_autodial}=====`); /*console.dir(item);*/ }
                            };

                            if(Array.isArray(payload) && payload.length > 0){
                                 let cb = payload[0];
                                //for call second leg first
                                item.roIDs          = cb.roIDs;
                                item.isFirstClient  = cb.isFirstClient;
                                item.destination    = cb.destination;
                                item.destdata       = cb.destdata;
                                item.destdata2      = cb.destdata2; // not use
                                //Exten default to context
                                item.Setting.exten  = cb.destdata;

                                const ShowDialPlan = () => {
                                       amiAction.ShowDialPlan({ exten: item.Setting.exten, context, qty : 0 }, ProcessID);
                                };
                                switch(cb.destination){
                                            case 101401 : { context = `db_queue_${item.Aid}`; console.log(`Queuestatus from Demon`);  amiAction.queuestatus({ exten : item.destdata, qty : 0 }, ProcessID );  break; }    //Queues
                                            case 101402 : { //Get sipName from sipID
                                                                  let a2 = {
                                                                      uri   : `${http}sippeers/find`,
                                                                      method: 'POST',
                                                                      json  : true,
                                                                      strictSSL: false,
                                                                      body  :   {"sipID":null,"sipName":null,"callerid":null,"template":null,"secret":null,"context":null,"callgroup":null,"pickupgroup":null,"nat":null,"dtmfmode":null,"emID":cb.destdata,"sorting":null,"field":null,"isActive":true,"offset":0,"limit":null}
                                                                  };
                                                                  request(a2, (error, payload2, body) => {
                                                                    payload2 = payload2 !== undefined ? payload2 : [];
                                                                    if(Array.isArray(payload2))
                                                                        if(payload2.length > 0) {
                                                                            item.Setting.exten = `${payload2[0].sipLogin}`;
                                                                            context = `db_hint_${item.Aid}`; amiAction.extensionState({ exten : item.Setting.exten, context, qty : 0 }, ProcessID);
                                                                        }
                                                                  });   break; 
                                                          } //Extensions
                                            case 101403 : { context = `db_trunk_${item.Aid}`;                                                 ShowDialPlan(); break; }    //Trunks
                                            case 101404 : { context = `db_hangup`;                            item.Setting.exten = `hangup`;  ShowDialPlan(); break; }    //Terminate Call
                                            case 101405 : { context = `db_ivr_${cb.destdata}_${item.Aid}`;    item.Setting.exten = `s`;       ShowDialPlan(); break; }    //IVR
                                            case 101406 : { context = `db_scenario_${item.Aid}`;                                              ShowDialPlan(); break; }    //Scenario
                                            case 101407 : { context = `db_record_${item.Aid}`;                                                ShowDialPlan(); break; }    //Record
                                            case 101408 : { context = `${cb.destdataName}`;                                                   ShowDialPlan(); break; }    //Custom destination
                                            case 101409 : { context = `db_pool_${item.Aid}`;                                                  ShowDialPlan(); break; }    //Pools
                                            default : break ;
                                }
                            }
                            else
                                D.stop({ "data" : `error`, "id_autodial": id});

                    }, 300);
                }
            });
        }
    }
};

const D = new Deamon();
D.queuememberwatch();
D.getProcess();
var debounce;

function DEvent(message)
{
    const ev = JSON.parse(message);

    let exist = false;
    D.processList.forEach( item => {
        if(ev.id_autodial == item.id_autodial)
        {   console.log(`=======Devent=======${item.id_autodial}`);
            exist = true;
            switch(ev.event)
            {
                case "progress-end" : {
                    console.log(`=== progress-end ${item.id_autodial} ====`);
                    if(item.Setting){
                        item.Setting.sourceList.forEach( (e,key) => {
                            ev.sourceList.forEach( e2 => {
                                console.log(item.Setting.sourceList[key]);
                                if(e2.clID === e.clID && e2.ccID === e.ccID) { console.log(`delete from ${item.id_autodial} clID:${e.clID},ccID:${e.ccID},phone:${e.phone}`); item.Setting.sourceList.splice(key,1); } //delete item.Setting.sourceList[key];
                            });
                            item.Setting.CurrentCall = item.Setting.sourceList.length;
                        });
                        console.log(item.Setting);
                        item.QtyQ = 0;
                        D.procces(ev.id_autodial);
                    } else { console.log(`=== no item.Setting for ${item.id_autodial} ===`); }
                    break;
                }
                case "progress-bridge" : {   console.log("progress-bridge");
                    let bridgeQyt = 0;
                    item.Setting.sourceList.forEach( e => {
                        ev.bridgeList.forEach( e2 => {
                            if(e2.phone === e.phone) e.isBridge = true;
                        });
                        if(e.isBridge) bridgeQyt++;
                    });
                    console.log(bridgeQyt);
                    console.dir(item);
                    //item.Setting.sourceList

                    console.log(`*${item.destination}*****${bridgeQyt}******${item.Setting.FreeMember}*`);
                    if(item)
                        if(item.destination == 101401)
                            if(bridgeQyt >= item.Setting.FreeMember && item.Setting.FreeMember != item.Setting.CurrentCall ) { console.log(`HANGUP ALL\n`); console.log(item.Setting.sourceList); amiAction.hangup(item.Setting.sourceList); } // Проверяем чтобы кол. соединений не превышало кол. сипов, если больше все скитдываем
                            // if(item.Setting.context)
                            //     if(item.Setting.context.includes(`db_queue`))
                                    //  if(bridgeQyt >= item.Setting.FreeMember && item.Setting.FreeMember > 1 ) { console.log(`HANGUP ALL\n`); console.log(item.Setting.sourceList); amiAction.hangup(item.Setting.sourceList); } // Проверяем чтобы кол. соединений не превышало кол. сипов, если больше все скитдываем
                    break;
                }
                //case "bridge"       	:   {   console.log("bridge"); console.log(ev); break;}
                case "err" : {
                    console.log(`||||||||||||||||||||||||||||||| ERR END ||||||||||||||||||||||||||||||||||||||`);
                    console.log(ev);
                    let data2 = ev.data;
                    if(item)
                    {
                        let mess = ev.data.substring(ev.data.lastIndexOf(":") + 1, ev.data.length).trim();
                        //FOP CLICK CALL
                        if( data2.substring(27,0) == 'Already is a call by number') break;
                        if(ev.data) console.log(`Автообзвон остановлен!, ${mess}  ${ev.event}, warning \n`);
                        D.stop(ev);
                    }
                    break;
                }
                default :   { console.log(`Default`); console.log(ev); console.log(); /*D.procces();*/ break; }
            }
        }
    });
    if(!exist) { console.log(`===NO==PROCESS==FOR=DIROCHKA==`);}
}