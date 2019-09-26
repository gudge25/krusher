/*jshint node:true*/
'use strict';
const Joi = require('joi');
const model = require('./crmTagListSchema');

function crmTagListValidate() {}
crmTagListValidate.prototype = (() => {

    return {
        findPost: {
            payload: (() => new model().schemaFindPost() )()
        },
        insert: {
            payload: (() => {
                const schema = new model().schema;
                return {
                    clID: schema.clID,
                    tags: Joi.array().items(Joi.number().integer()),
                    isActive: Joi.boolean().optional().allow(null)
                };
            })()
        },
    };
})();

const validate = new crmTagListValidate();
module.exports = validate;

// class crmTagListValidate {
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