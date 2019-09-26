/*jshint node:true*/
'use strict';
const model = require('./usSequenceSchema');

function usSequenceValidate() {}
usSequenceValidate.prototype = (() => {

    return {
        findByID: {
            params: (() => {
                const schema = new model().schema;
                return {
                    seqName: schema.seqName
                };
            })()
        },
    };
})();

const validate = new usSequenceValidate();
module.exports = validate;

// class usSequenceValidate {
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