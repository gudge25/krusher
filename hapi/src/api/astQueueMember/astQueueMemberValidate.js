/*jshint node:true*/
'use strict';
const _ = require('lodash');
const Joi = require('joi');
const model = require('./astQueueMemberSchema');

function astQueueMemberValidate() {}
astQueueMemberValidate.prototype = (() => {

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
            params: (() => {
                const schema = new model().schema;
                return {
                    quemID: schema.quemID
                };
            })()
        },
    };
})();
const validate = new astQueueMemberValidate();
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
//                 entry_id: schema.entry_id
//             },
//             payload: schema
//           };
//     })()
//     delete() {
//           params: (() => {
//             const schema = new model().schema;
//             return {
//                 entry_id: schema.entry_id
//             };
//           })()
//         },
//     }

// }