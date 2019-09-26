/*jshint node:true*/
'use strict';
const model = require('./crmStatusSchema');

function crmStatusValidate() {}
crmStatusValidate.prototype = (() => {

    return {
        update: {
            payload: (() => new model().schema )()
        },
    };
})();

const validate = new crmStatusValidate();
module.exports = validate;

// class crmStatusValidate {
//   constructor(){
//   }

//     find(){
//           payload: () => new model().schema ;
//           }

//     findPost() {
//           payload: (() => new model().schemaFindPost() )();

//     }
//     insert() {
//           payload: (() => {
//             const schema = new model().schema;
//             //delete schema.rtID;
//             return schema;
//           })();
//     }
//     update() (() => {
//           const schema = new model().schema;
//           return {
//             params: {
//                 rtID: schema.rtID
//             },
//             payload: schema
//           };
//     })()
//     delete() {
//           params: (() => {
//             const schema = new model().schema;
//             return {
//                 rtID: schema.rtID
//             };
//           })()
//         },
//     }

// }