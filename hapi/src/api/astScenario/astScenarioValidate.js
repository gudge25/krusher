/*jshint node:true*/
'use strict';
const model = require('./astScenarioSchema');

function astScenarioValidate() {}
astScenarioValidate.prototype = (() => {

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
                    id_scenario: schema.id_scenario
                };
            })()
        },
    };
})();

const validate = new astScenarioValidate();
module.exports = validate;

// class astScenarioValidate {
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