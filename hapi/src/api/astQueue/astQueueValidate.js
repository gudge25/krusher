/*jshint node:true*/
'use strict';
const model = require('./astQueueSchema');

function astQueueValidate() {}
astQueueValidate.prototype = (() => {

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
                    queID: schema.queID
                };
            })()
        },
    };
})();
const validate = new astQueueValidate();
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