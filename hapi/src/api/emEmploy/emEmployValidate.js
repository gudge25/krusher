/*jshint node:true*/
'use strict';
const model = require('./emEmploySchema');
const Joi = require('joi');

function emEmployValidate() {}
emEmployValidate.prototype = (() => {

    return {
        findPost: {
            payload: (() => new model().schemaFindPost() )()
        },
        insert: {
            payload: (() => new model().schemaInsert() )()
        },
        update: {
            payload: (() => new model().schema )()
        },
        updateStatus: {
            payload: (() => new model().schemaUpdateStatus() )()
        },
        delete: {
            params: (() => {
                const schema = new model().schema;
                return {
                    emID: schema.emID
                };
            })()
        },
        stat: {
            payload: (() => new model().schemaStat() )()
        },
        counter: {
            payload: (() => new model().schemaCounter() )()
        },
        reportCalls: {
            payload: (() => new model().schemaCalls() )()
        },
        reportStatus: {
            payload: (() => new model().schemaStatus() )()
        },
        fileExport: {
            payload: (() => new model().schemaStat() )()
        },
    };
})();

const validate = new emEmployValidate();
module.exports = validate;

// class astRouteIncomingValidate {
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
//             return schema;
//           })();
//     }
//     update() (() => {
//           const schema = new model().schema;
//           return {
//             params: {
//                 id_ivr_config: schema.id_ivr_config
//             },
//             payload: schema
//           };
//     })()
//     delete() {
//           params: (() => {
//             const schema = new model().schema;
//             return {
//                 id_ivr_config: schema.id_ivr_config
//             };
//           })()
//         },
//     }

// }