/*jshint node:true*/
'use strict';
const Joi = require('joi');
const model = require('./crmResponsibleSchema');

function crmResponsibleValidate() {}
crmResponsibleValidate.prototype = (() => {

    return {
        findPost: {
            payload: (() => new model().schemaFindPost() )()
        },
        insert: {
            payload: (() => {
                const schema = new model().schema;
                return {
                    clID: schema.clID,
                    emID: schema.emID
                };
            })()
        },
        insList: {
            payload: (() => {
                const schema = new model().schema;
                return {
                    emID: schema.emID,
                    clIDs: Joi.array().items(Joi.number().integer().required())
                };
            })()
        },
        setSabd: {
            params: (() => {
                return {
                    ffID : Joi.number().integer().required(),
                };
            })()
        },
    };
})();

const validate = new crmResponsibleValidate();
module.exports = validate;

// class crmResponsibleValidate {
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