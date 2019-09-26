const utils = require('./middleware/utils');

class CallList {
  constructor(ami){
  		  console.log(`====RUN ===== CALLLIST CALLS===================!!!!!!!!!!!!!!!!!!!!!`);
          this.ami    = ami;
          this.res    = { data : [] };
  }

  get name(){
          return this.res;
  }

  start(ev,callback){
    //console.log(` ========start========`);
      const self = this;
      //Clear chanel and convert to source
      ev.source         = utils.source(ev.channel);
      if( ev.uniqueid != ev.linkedid){
        //console.log(ev);

        //First event
        if(!self.res.data[`${ev.linkedid}`]){
            var Type,source,sip,ccName;
            if(ev.bridgenumchannels == 1 && ev.context.split("_")[0] == "incoming" )
                [Type,source,sip,ccName]    = ['OUT',ev.source,ev.connectedlinenum,utils.clearnum(ev.calleridnum)];
            if(ev.bridgenumchannels == 1 && ev.context.split("_")[0] == "office" )
                [Type,source,sip,ccName]    = ['INC',null,utils.sip(ev.channel),utils.clearnum(ev.connectedlinenum)];

                self.res.data[`${ev.linkedid}`] = { linkedid : ev.linkedid, Type, isEnd: false, source, sip, ccName, calls: [] };
            self.res.data[`${ev.linkedid}`].calls.push(ev);
            //Lisner Hangup and finish call
            const hangupHeadlerCall = evt => {
                const id = ev.linkedid;
                if( evt.uniqueid == id ) {
                    //console.log(`hangupHeadlerCallhangupHeadlerCallhangupHeadlerCallhangupHeadlerCall================`);
                    self.ami.removeListener('hangup', hangupHeadlerCall);
                    delete self.res.data[`${id}`];
                }
            };
            self.ami.on('hangup', hangupHeadlerCall);
            // self.ami.on('varset', evt => {
            //   const id = ev.linkedid;
            //   if(evt.uniqueid == id){
            //     console.log(evt.variable);
            //     console.log(evt.value);
                
            //   }
            // });

            
        }
        else {
            //Second event
            this.res.data[`${ev.linkedid}`].calls.push(ev);

            if( (this.res.data[`${ev.linkedid}`].calls.length > 2 || ( this.res.data[`${ev.linkedid}`].calls.length == 2 && !this.res.data[`${ev.linkedid}`].isEnd))) {
              if(this.res.data[`${ev.linkedid}`].calls[0]){
                  if(this.res.data[`${ev.linkedid}`].calls[0].context.split("_")[0] == "incoming" )
                    this.res.data[`${ev.linkedid}`].Type = `ORIGINATION`;

                  if(this.res.data[`${ev.linkedid}`].calls[0].context.split("_")[0] == "office" )
                      this.res.data[`${ev.linkedid}`].Type = `ORIGINATION 2`;
              }
            }
            
            // //FOR OUT call full sip detect  (500_10)
            // console.log(`+++++++++++++++++++++++++++++1+++++++++++++++++++++++++++++++`);
            //     console.log(ev.channel);
            // if(ev.bridgenumchannels == 2 && ev.context.split("_")[0] != "incoming" ){
            //     console.log(`++++++++++++++++++++++++++++2++++++++++++++++++++++++++++++++`);
            //     console.log(ev.channel);
            //     //this.res.data[`${ev.linkedid}`].sip     =  this.sip(ev.channel);
            // }

        }
      }
      //finish
      if(ev.uniqueid == ev.linkedid) {
        if(this.res.data[`${ev.linkedid}`]){
          this.res.data[`${ev.linkedid}`].calls.push(ev);
          this.res.data[`${ev.linkedid}`].isEnd = true;
          this.res.data[`${ev.linkedid}`].channel = ev.channel;
          //OUT
          this.res.data[`${ev.linkedid}`].channelB= this.res.data[`${ev.linkedid}`].calls[0].channel;
          
          if(ev.bridgenumchannels == 2){
            //For inc source
                if(this.res.data[`${ev.linkedid}`].Type == 'INC') { this.res.data[`${ev.linkedid}`].source = ev.source; }
            //For originate source
                if(this.res.data[`${ev.linkedid}`].Type == 'ORIGINATION') { 
                  this.res.data[`${ev.linkedid}`].sip =  utils.sip(this.res.data[`${ev.linkedid}`].calls[2].channel); /*ev.connectedlinenum;*/ 
                  this.res.data[`${ev.linkedid}`].channelB= this.res.data[`${ev.linkedid}`].calls[1].channel;

                }
            //For originate source 2
                if(this.res.data[`${ev.linkedid}`].Type == 'ORIGINATION 2') { this.res.data[`${ev.linkedid}`].sip = utils.sip(this.res.data[`${ev.linkedid}`].calls[0].channel);  this.res.data[`${ev.linkedid}`].source = this.res.data[`${ev.linkedid}`].calls[2].source; }
            
            //bug for sip _ AID 
            if(this.res.data[`${ev.linkedid}`].Type == 'OUT') { this.res.data[`${ev.linkedid}`].sip = utils.sip(this.res.data[`${ev.linkedid}`].calls[1].channel); }
   
          }


          //if(this.res.data[`${ev.linkedid}`].calls[0].accountcode && this.res.data[`${ev.linkedid}`].calls[0].accountcode != 'null'){
              var account = {};
              if(this.res.data[`${ev.linkedid}`].Type == 'INC' || this.res.data[`${ev.linkedid}`].calls[0].accountcode == '') {
                  if(this.res.data[`${ev.linkedid}`].calls[1].accountcode)
                      account = JSON.parse( this.res.data[`${ev.linkedid}`].calls[1].accountcode );
              }
              else {
                  if(this.res.data[`${ev.linkedid}`].calls[1].accountcode)
                      account = JSON.parse( this.res.data[`${ev.linkedid}`].calls[0].accountcode );
              }
              if(account.clID == "null" || !account.clID) account.clID = null;
              if(account.dcID == "null" || !account.dcID) account.dcID = null;
              this.res.data[`${ev.linkedid}`].clID = account.clID;
              this.res.data[`${ev.linkedid}`].dcID = account.dcID;
          //}
              
          //TRIGERS for callingcard
          let cb = this.res.data[`${ev.linkedid}`];
          delete this.res.data[`${ev.linkedid}`];
          //if (ev.channelstatedesc === 'Up')
          if(cb.ccName)cb.ccName=utils.clearnum(cb.ccName);
 
          // var Channel;
          // if(cb.Type == 'ORIGINATION') Channel = cb.channelB; else Channel = cb.channel;
 
 
          //GET DCID
          // this.ami.action({Action:'Getvar',Channel,Variable: `dcID`}, (err, res) => { 
          //   if(err) return console.log(`ERROR!!!!!! GETVAR ${err}`); 
          //   if(res) {
          //     //console.log(res);
          //     if(res.value && res.value != 'null') cb.dcID = parseInt(res.value);
          //     //GET CLID
          //     this.ami.action({Action:'Getvar',Channel,Variable: `clID`}, (err, res) => { 
          //       if(err) return console.log(`ERROR!!!!!! GETVAR ${err}`); 
          //       if(res) {
          //         if(res.value && res.value != 'null') cb.clID = parseInt(res.value);
          //         this.ami.action({Action:'Getvar',Channel,Variable: `ccID`}, (err, res) => { 
          //           if(err) return console.log(`ERROR!!!!!! GETVAR ${err}`); 
          //           if(res) {
          //             if(res.value && res.value != 'null') cb.ccID = parseInt(res.value);
          //             this.ami.action({Action:'Getvar',Channel,Variable: `ffID`}, (err, res) => { 
          //               if(err) return console.log(`ERROR!!!!!! GETVAR ${err}`); 
          //               if(res.value && res.value != 'null') cb.ffID = parseInt(res.value);
          //               this.ami.action({Action:'Getvar',Channel,Variable: `IsOut`}, (err, res) => { 
          //                 if(err) return console.log(`ERROR!!!!!! GETVAR ${err}`); 
          //                 if(res.value && res.value != 'null') cb.IsOut = JSON.parse(res.value);
          //                 this.ami.action({Action:'Getvar',Channel,Variable: `emID`}, (err, res) => { 
          //                   if(err) return console.log(`ERROR!!!!!! GETVAR ${err}`); 
          //                   if(res.value && res.value != 'null') cb.emID = parseInt(res.value);
          //                   this.ami.action({Action:'Getvar',Channel,Variable: `isAutoCall`}, (err, res) => { 
          //                     if(err) return console.log(`ERROR!!!!!! GETVAR ${err}`); 
          //                     if(res.value && res.value != 'null') cb.isAutocall = JSON.parse(res.value); 
          //                     //
          //                     //RETURN
          //                       return callback(cb);
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

          // //GET DCID
          // this.ami.action({Action:'Getvar',Channel,Variable: `dcID`}, (err, res) => { 
          //     if(err) { console.log(`ERROR!!!!!! GETVAR ${err}`); return callback(cb); }
          //     if(res) if(res.value && res.value != 'null') cb.dcID = parseInt(res.value);
          //     //GET CLID
          //     this.ami.action({Action:'Getvar',Channel,Variable: `clID`}, (err, res) => { 
          //         if(err) { console.log(`ERROR!!!!!! GETVAR ${err}`); return callback(cb); }
          //         if(res) if(res.value && res.value != 'null') cb.clID = parseInt(res.value);

          //         //RETURN
          //         console.dir(cb);
          //         return callback(cb);
          //     });
          // });
           
          ///console.dir(cb);
                  return callback(cb);






          //return callback(cb);
        }
      }
  }
}
module.exports = CallList;