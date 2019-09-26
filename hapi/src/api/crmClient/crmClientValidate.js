/*jshint node:true*/
'use strict';
const Joi = require('joi');
const model = require('./crmClientSchema');

function crmClientValidate() {}
crmClientValidate.prototype = (() => {
    return {
        findPost: {
            payload: (() => new model().schemaFindPost() )()
        },
        findSum: {
            query: (() => {
                const schema = new model().schemaFindSum();
                return schema;
            })()
        },
        getAutocall: {
            payload: (() => {
                const schema = new model().schemaAutocall;
                return schema;
            })()
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
            params: (() => {
                const schema = new model().schema;
                return {
                    clID: schema.clID
                };
            })()
        },
        search: {
            payload: (() => new model().schemaSearch() )()
        },
        getByContact: {
            params: (() => {
                return {
                    ccName: Joi.string().max(50)
                };
            })()
        },
        getByPhone: {
            params: (() => {
                return {
                    Aid: Joi.number().integer().optional().allow(null),
                    ccName: Joi.number().integer().optional().allow(null)
                };
            })()
        },
        getIPClient: {
            params: (() => {
                return {
                    ccName: Joi.string().max(50)
                };
            })()
        },
        getByName: {
            params: (() => {
                const schema = new model().schema;
                return {
                    clName: schema.clName
                };
            })()
        },
        findStream: {
            params: {
                emID: Joi.number().integer()
            }
        },
        findByParent: {
            params: {
                clID: Joi.number().integer().required()
            }
        },
        setActual: {
            payload: (() => {
                const schema = new model().schema;
                return {
                    HIID: schema.HIID,
                    clID: schema.clID
                };
            })()
        },
        findSabd: {
            params: (() => {
                const schema = new model().schema;
                return {
                    clID: schema.clID
                };
            })()
        },
        checkPhone: {
            params: {
                phone: Joi.string().max(50).required()
            }
        },
        updSabd: {
            payload: (() => {
                const schema = new model().schema;
                return {
                    HIID: schema.HIID,
                    clID: schema.clID,
                    inn: Joi.string().max(14).required(),
                    nameFull: Joi.string().max(400).required(),
                    nameShort: Joi.string().max(400).required(),
                    adress: Joi.string().max(200).required(),
                    fio: Joi.string().max(100).required().allow(null),
                    io: Joi.string().max(100).required().allow(null),
                    post: Joi.string().max(50).required().allow(null),
                    sex: Joi.string().max(10).required().allow(null),
                    famIO: Joi.string().max(50).required().allow(null),
                    kvedCode: Joi.string().max(7).required(),
                    kvedDescr: Joi.string().max(250).required(),
                    orgNote: Joi.string().max(100).required().allow(null),
                    isNotice: Joi.bool().required(),
                    callDate: Joi.string().isoDate().required().allow(null),
                    email: Joi.string().max(50).required().allow(null),
                    actualStatus: Joi.number().integer().required().allow(null),
                    phoneDialer: Joi.string().max(50).required().allow(null),
                    phoneComment: Joi.string().max(100).required().allow(null),
                    phones: Joi.array().items(Joi.object().keys({
                        ccID: Joi.number().integer().required(),
                        ccName: Joi.string().max(50).required(),
                        ccComment: Joi.string().max(100).required().allow(null)
                    })).required().allow(null),
                };
            })()
        },
        insSave: {
            payload: (() => {
                const schema = new model().schemaSave();
                delete schema.HIID;
                delete schema.clID;
                return schema;
            })()
        },
        updSave: {
            payload: (() => new model().schemaSave() )()
        },
        getSave: {
            params: (() => {
                const schema = new model().schema;
                return {
                    clID: schema.clID
                };
            })()
        },
        bulkdelete: {
            payload: (() => new model().schemaBulkDelete() )()
        },
    };
})();

const validate = new crmClientValidate();
module.exports = validate;

// class crmClientValidate {
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