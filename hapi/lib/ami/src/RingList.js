const utils = require('./middleware/utils');

class RingList {
    constructor(param){
            console.log(`====RUN ===== RingList CALLS===================!!!!!!!!!!!!!!!!!!!!!`);
            this.self       = param;
            this.res = { data : [] };      
    }
  
    get name(){
            return this.res;
    }
  
    start(ev,callback){
        //Clear chanel and convert to source
        ev.source         = utils.source(ev.channel);

        //console.dir(ev);
        if( ev.uniqueid == ev.linkedid){
            //console.log(this.res.data);
            //First event
            if(!this.res.data[`${ev.linkedid}`]){
                    var source,sip,ccName;
                    [source,sip,ccName]    = [utils.source(ev.channel),null,utils.clearnum(ev.calleridnum)];
                    this.res.data[`${ev.linkedid}`] = { linkedid : ev.linkedid, source, sip, ccName, calls: [] };
                    this.res.data[`${ev.linkedid}`].calls.push(ev);
                
                    //Lisner Hangup and finish call
                    const hangupHeadlerCall = evt => {
                        const id = ev.linkedid;
                        if( evt.uniqueid == id ) {
                            //Sent all the end call
                            let body = {
                                "event":  `NewstateEndAll`,
                                "phone": this.res.data[`${ev.linkedid}`].ccName,
                                "source": this.res.data[`${ev.linkedid}`].source,
                                "coID": null,
                                "channelstatedesc": ev.channelstatedesc,
                                "channelstate": ev.channelstate,
                                "sip": null,
                            };
                            this.self.send(body);
                            this.self.ami.removeListener('hangup', hangupHeadlerCall);
                            delete this.res.data[`${id}`];
                        }
                    };
                    this.self.ami.on('hangup', hangupHeadlerCall);
                    this.self.ami.on('varset', evt => {
                        const id = ev.linkedid;
                        // if(evt.uniqueid == id){
                        //     if(evt.variable.aid  || evt.variable.clID || evt.variable.ccID || evt.variable.dcID ){
                        //         console.log(evt.variable);
                        //         console.log(evt.value);
                        //     }
                          
                        // }
                    });
            }
        }
        else {
            //Next events
            if(this.res.data[`${ev.linkedid}`]){
                ev.sip      = utils.sip(ev.channel);
                ev.sipName  = utils.source(ev.channel);
                this.res.data[`${ev.linkedid}`].calls.push(ev);
                //console.log(ev);
                //console.dir(this.res.data[`${ev.linkedid}`]);
                let body = {
                    "event":  ev.event,
                    "sip": ev.sipName,
                    "phone": this.res.data[`${ev.linkedid}`].ccName,
                    "source": this.res.data[`${ev.linkedid}`].source,
                    "coID":null,
                    "channelstatedesc": ev.channelstatedesc,
                    "channelstate": ev.channelstate,
                };
                if(ev.sip == this.self.Sip) this.self.send(body);

                //Lisner Hangup sip ringing
                const hangupHeadlerCall2 = evt => {
                    const id = ev.uniqueid;
                    if( evt.uniqueid == id && this.res.data[`${ev.linkedid}`]) {
                        //Sent 
                        let body = {
                            "event":  `NewstateEnd`,
                            "phone": this.res.data[`${ev.linkedid}`].ccName,
                            "source": this.res.data[`${ev.linkedid}`].source,
                            "coID": null,
                            "channelstatedesc": ev.channelstatedesc,
                            "channelstate": ev.channelstate,
                            "sip": utils.source(evt.channel)
                        };
                        if(utils.sip(ev.channel) == this.self.Sip) {
                            this.self.send(body);
                            this.self.ami.removeListener('hangup', hangupHeadlerCall2);
                        }
                    }
                }; 
                this.self.ami.on('hangup', hangupHeadlerCall2);
            }
        }       
    }
  }
  module.exports = RingList;