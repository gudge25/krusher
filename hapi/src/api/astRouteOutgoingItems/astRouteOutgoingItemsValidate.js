/*jshint node:true*/
'use strict';
const model = require('./astRouteOutgoingItemsSchema');

function astRouteOutgoingItemsValidate() {}
astRouteOutgoingItemsValidate.prototype = (() => {

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
                    roiID: schema.roiID
                };
            })()
        },
    };
})();

const validate = new astRouteOutgoingItemsValidate();
module.exports = validate;

// class astRouteOutgoingValidate {
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