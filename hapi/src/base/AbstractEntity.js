/*jshint node:true, esnext:true*/
'use strict';
module.exports = class AbstractEntity {
  constructor(data) {
      this.Data = data;
      this.toJSONLocal = (date) => {
        var local = new Date(date);
        local.setMinutes(date.getMinutes() - date.getTimezoneOffset());
        return local.toJSON().slice(0, 10);
      };
    }
    // toString() {
    //   const params = [];
    //   for (const key in this.Data) {
    //     const prop = this.Data[key];
    //     if (prop === 'undefined' /*|| isNaN(prop) === true */ )
    //       return;
    //     switch (typeof prop) {
    //       case 'string':
    //         params.push(`'${prop}'`);
    //         break;
    //       case 'Date':
    //         params.push(`'${prop.toISOString()}'`);
    //         break;
    //       case 'object':
    //         break;
    //       default:
    //         params.push(prop);
    //     }
    //   }
    //   return params.join();
    // }
};