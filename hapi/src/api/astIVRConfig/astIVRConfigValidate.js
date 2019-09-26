/*jshint node:true*/
'use strict';
const model = require('./astIVRConfigSchema');

function astIVRConfigValidate() {}
astIVRConfigValidate.prototype = (() => {

  return {

    find: {
            payload: (() => new model().schema )()
    },
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
                    id_ivr_config: schema.id_ivr_config
                };
            })()
        },
    };
})();
const validate = new astIVRConfigValidate();
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