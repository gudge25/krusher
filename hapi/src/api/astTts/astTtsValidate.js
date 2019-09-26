/*jshint node:true*/
'use strict';
const model = require('./astTtsSchema');

function astTtsValidate() {}
astTtsValidate.prototype = (() => {

    return {
        findPost: {
            payload: (() => new model().schemaFindPost() )()
        },
        insert: {
            payload: (() => new model().schemaInsert() )()
        },
        update: {
            payload: (() => new model().schemaUpdate() )()
        },
        delete: {
            params: (() => {
                const schema = new model().schema;
                return {
                    ttsID: schema.ttsID
                };
            })()
        },
    };
})();

const validate = new astTtsValidate();
module.exports = validate;

// class astTtsValidate {
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