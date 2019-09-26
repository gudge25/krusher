/*jshint node:true, esnext:true*/
'use strict';
const request   = require('./middleware/request');
const constants = require('../src/config/constants').application;
const amiAction = require('./ami-action');
const uuidV1  	= require('uuid/v1');
const utils = require('./middleware/utils');

const httpsport = parseInt(constants.port) == 80 ? 443 :  parseInt(constants.port) + 10;
const http = `https://system:GajQFtnlejJwdEGby73Z7MBlnktMwc@localhost:${httpsport}/api/ast/`;

const DemonRecall = class DemonRecall {
    constructor()
    {
        this.action       = amiAction;
        this.ami          = this.action.ami;
        this.Stat = {
            MaxCalls : 0,
            CurCalls : 0,
            Clients : []
        };
    }

    model(){
        this.options = {
            uri   : `${http}recall/auto`,
            method: 'POST',
            json  : true,
            strictSSL: false,
            body  : { "qtyContact": 1 }
        };
    }

    start(){
        const self        = this;
        //Get All AutoProcces
        this.model();
        request(this.options, (error, payload, body) => {
            if(error){ console.log(`ERROR!!!!`); console.log(error);}
            console.dir(self.Stat.Clients);
            if(Array.isArray(payload))
                if(payload.length > 0){
                    console.dir(payload);
                    payload.forEach( item => {
                        item.isHangup      = false;
                        item.uuid          = uuidV1();
                        item.isProgress    = false;
                        if(self.Stat.Clients.findIndex(x => x.phone.toString() == item.phone.toString()) == -1 ) self.Stat.Clients.push(item);
                    });
                    this.mapping();
                }

            setTimeout( () => {
                    console.log(`==========> Re-Start Recall, Qty procces: ${self.Stat} <=========\n`);
                    //console.dir(self.Stat);
                    this.start();
            }, 60000);        
        });
    }

    originate(){
        // console.log(err);
        // console.log(data);
        const self        = this;
        console.log(`======================================================`);
        self.Stat.Clients.forEach( e => {
            e.CallType =101321;
            let params = e;
            
            self.action.originate({
                "source"  : [e],
                "exten"   : e.exten,
                "duration": `maxduration`,
                "params"  : params
            }, (err,res) => {
                
                //if(res) console.log(res);
                if(err) { console.log(`=========================================AMI ACTION ERROR/RESPONCE=======================================`); console.log(err);}
                //if(err) return self.sendError(err.message); 
            });
        });
 
    }
    
    mapping(){
        const self        = this;
        if (self.Stat.Clients.length >= 0) {
            var ProcessID = (err,data) => {
                self.originate();
            };

            self.Stat.Clients.forEach( e => {
                if(!e.isProgress){
                    e.isProgress 	= true;
                     //console.log(`--==-=-=-=-=-=-=-=-=-=-=-`);
                    //item.Setting.context     = context;
                    const ShowDialPlan = () => {

                        amiAction.ShowDialPlan({ exten: e.exten, context: e.context, qty : 0 }, ProcessID);
                    };
                    
                    //Set exten;
                    e.exten = e.destdata;
                    switch(e.destination){
                        case 101401 : { e.context = `db_queue_${e.Aid}`; console.log(`Queuestatus from Recall`); amiAction.queuestatus({ exten : e.destdata, qty : 0 }, ProcessID );  break; }    //Queues
                        case 101402 : { //Get sipName from sipID
                                              let a2 = {
                                                  uri   : `${http}sippeers/find`,
                                                  method: 'POST',
                                                  json  : true,
                                                  strictSSL: false,
                                                  body  :   {"sipID":null,"sipName":null,"callerid":null,"template":null,"secret":null,"context":null,"callgroup":null,"pickupgroup":null,"nat":null,"dtmfmode":null,"emID":e.destdata,"sorting":null,"field":null,"isActive":true,"offset":0,"limit":null}
                                              };
                                              request(a2, (error, payload2, body) => {
                                                payload2 = payload2 !== undefined ? payload2 : [];
                                                if(Array.isArray(payload2))
                                                    if(payload2.length > 0) {
                                                        e.exten = `${payload2[0].sipLogin}`;
                                                        e.context = `db_hint_${e.Aid}`; amiAction.extensionState({ exten : e.exten, context: e.context, qty : 0 }, ProcessID);
                                                    }
                                              });   break; 
                                      } //Extensions
                        case 101403 : { e.context = `db_trunk_${e.Aid}`;                                      ShowDialPlan(); break; }    //Trunks
                        case 101404 : { e.context = `db_hangup`;                      e.exten = `hangup`;     ShowDialPlan(); break; }    //Terminate Call
                        case 101405 : { e.context = `db_ivr_${e.destdata}_${e.Aid}`;  e.exten = `s`;          ShowDialPlan(); break; }    //IVR
                        case 101406 : { e.context = `db_scenario_${e.Aid}`;                                   ShowDialPlan(); break; }    //Scenario
                        case 101407 : { e.context = `db_record_${e.Aid}`;                                     ShowDialPlan(); break; }    //Record
                        case 101408 : { e.context = `${e.destdataName}`;                                      ShowDialPlan(); break; }    //Custom destination
                        case 101409 : { e.context = `db_pool_${e.Aid}`;                                       ShowDialPlan(); break; }    //Pools
                        default : break ;
                    }
                }
            });
        }
        // function clearnum(a){
        //     //Bug when num with +
        //     if(a){
        //         let cn = a.toString();
        //         cn = cn.replace(/\D/g, "");
        //         if (cn.length == 7 && cn.substring(0,1) != 0) cn = `044${cn}`;
        //         if (cn.length == 9 && cn.substring(0,1) != 0) cn = `380${cn}`;
        //         if (cn.length == 10 && cn.substring(0,1) == 0) cn = `38${cn}`;
        //         //ru
        //         if (cn.length == 10 && cn.substring(0,1) != 0) cn = `7${cn}`;
        //         return cn;
        //     }
        // }
        // function source(chan){
        //     if(chan){
        //         //Clear chanel and convert to source
        //         let a   = chan        ? chan.split("/")[1] : null;
        //         a       = a ? a.split("-")[0] : null;
        //         a       = a ? a.split("@")[0] : null;
        //         return a ? a.split("_")[0] : null;
        //     }
        // }

        const hangupHeadler = evt => {
            //console.log(evt);
            if(evt.accountcode && evt.accountcode != '' && evt.uniqueid == evt.linkedid){
                const EvtUUID = evt.accountcode.trim();
                let ClearNum = utils.clearnum(evt.connectedlinenum.trim());

                self.Stat.Clients.forEach( (e,key) => {
                    if ( (ClearNum  == e.phone || utils.clearnum(utils.source(evt.channel.trim())) == e.phone ) && !e.isHangup && EvtUUID == e.uuid ) {
                        e.isHangup = true;
                        console.log(`======= Hangup Event RECALL======EvtUUID: ${EvtUUID} == uuid: ${e.uuid} == ${ClearNum} == ${e.phone}`);
                        console.log(evt);
                        self.ami.removeListener('hangup', hangupHeadler);
                        self.Stat.Clients.splice(key,1);
                        console.log(self.Stat.Clients);
                    }
                });
            }
        };

        self.ami.on('hangup', hangupHeadler);
    }


};


const D = new DemonRecall();
D.start();