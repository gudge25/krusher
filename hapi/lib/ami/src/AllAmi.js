/*jshint node:true*/
'use strict';
const amiAction     = require('./ami-action');

class AllAmi{
  constructor(){
    this.action = amiAction;
    this.parse  = [];
  }

  get(Aid){
      var res = [];
      if(this.parse.length > 0)
          this.parse.forEach( item => {
              if(item.context.split("_").pop() == `${Aid}`) res.push(item);
          });
      const msg = { event : `coreshowchannels`, data  : res, AllCalls : this.parse.length, ClientCalls: res.length };
      return msg;
  }

  coreshowchannels(){
    this.parse =[];
    this.action.coreshowchannels(null, (err,data) => {
        if(Array.isArray(data))
        if(data.length > 0)
          data.forEach( item => {
              if(item.uniqueid == item.linkedid)
                  this.parse.push(item);
          });
    });
  }

  start(){
      setInterval(() => {
          this.coreshowchannels();
      }, 10000);
  }
}
const AllAmiRun = new AllAmi();
AllAmiRun.start();

module.exports = AllAmiRun;