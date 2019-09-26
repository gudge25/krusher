/*jshint node:true*/
'use strict';
const model = require('./astCallbackSchema');

function astCallbackValidate() {}
astCallbackValidate.prototype = (() => {

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
                    cbID: schema.cbID
                };
            })()
        },
    };
})();

const validate = new astCallbackValidate();
module.exports = validate;

// class astCallbackValidate {
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