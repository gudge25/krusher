// /*jshint node:true, esnext:true*/
// 'use strict';
// const Joi = require('joi');
// const id = Joi.number().integer().required();

// function BaseValidate(model){
//   this.Model = model;
// }
// BaseValidate.prototype = (() => {
//   return {
//     findByID: {
//       params: () => {
//         const schema = new this.Model().schema;
//         return {
//           id: id
//         };
//       }
//     },
//     // find: {
//     //   query: (() => {
//     //     var schema = new model().schema;
//     //     return schema;
//     //   })()
//     // },
//     insert: {
//       payload: () => {
//         const schema = new this.Model().schema;
//         return schema;
//       }
//     },
//     update: () => {
//       const schema = new this.Model().schema;
//       return {
//         params: {
//           id: id
//         },
//         payload: schema
//       };
//     },
//     delete: {
//       params: {
//         id: id
//       }
//     }
//   };
// })();

// module.exports = BaseValidate;
