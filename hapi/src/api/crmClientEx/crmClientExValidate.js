/*jshint node:true*/
'use strict';
const Joi = require('joi');
const model = require('./crmClientExSchema');

function crmClientExValidate() {}
crmClientExValidate.prototype = (() => {

    return {
        findPost: {
            payload: (() => new model().schemaFindPost() )()
        },
        insert: {
            payload: (() => {
                const schema = new model().schema;
                delete schema.HIID;
                return schema;
            })()
        },
        update: {
            payload: (() => new model().schema )()
        },
        delete: {
            params: {
                clID: Joi.number().integer().required(),
            }
        },
        insList: {
            payload: (() => {
                const schema = new model().schema;
                return {
                    CallDate : schema.CallDate,
                    clID: Joi.array().items(Joi.number().integer().required())
                };
            })()
        },
        setDial: {
            params: {
                clID: Joi.alternatives().try(Joi.number().integer().optional().allow(null), Joi.allow(null)).description('ID of contacts'),
                isdial: Joi.number().integer().allow(0, 1).default(1)
            }
        }
    };
})();

const validate = new crmClientExValidate();
module.exports = validate;

// class crmClientExValidate {
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
