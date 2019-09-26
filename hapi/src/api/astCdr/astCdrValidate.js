/*jshint node:true*/
'use strict';
const _ = require('lodash');
const Joi = require('joi');
const model = require('./astCdrSchema');

function astCdrValidate() {}
astCdrValidate.prototype = (() => {

    return {
        FindPost: {
            payload: (() => {
                const schema = new model().schema;

                return {
                    GUID : schema.GUID
                }
            })()
        },
    };
})();
const validate = new astCdrValidate();
module.exports = validate;

// class astCdrValidate {
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