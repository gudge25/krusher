/*jshint node:true*/
'use strict';
const model = require('./astIVREntriesSchema');

function astIVREntriesValidate() {}
astIVREntriesValidate.prototype = (() => {

    return {
        find: {
            payload: (() => new model().schema )()
        },
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
                    entry_id: schema.entry_id
                };
            })()
        },
    };
})();
const validate = new astIVREntriesValidate();
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