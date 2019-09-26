/*jshint node:true*/
'use strict';
const Joi = require('joi');
const model = require('./stProductSchema');

function stProductValidate() {}
stProductValidate.prototype = (() => {

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
                psID: Joi.number().integer().required()
            }
        }
    };
})();

const validate = new stProductValidate();
module.exports = validate;

// class stProductValidate {
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