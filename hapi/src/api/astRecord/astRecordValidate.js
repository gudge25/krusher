/*jshint node:true*/
'use strict';
const model = require('./astRecordSchema');

function astRecordValidate() {}
astRecordValidate.prototype = (() => {

    return {
        findPost: {
            payload: (() => new model().schemaFindPost() )()
        },
        insert: {
            payload: (() => {
                const schema = new model().schemaInsert();
                delete schema.HIID;
                return schema;
            })()
        },
        insertForce: {
            payload: (() => {
                const schema = new model().schemaInsertF();
                /*delete schema.record_id;
                delete schema.record_name;
                delete schema.isActive;
                delete schema.HIID;*/
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
                    record_id: schema.record_id
                };
            })()
        },
    };
})();

const validate = new astRecordValidate();
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