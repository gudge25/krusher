'use strict';
const Handlers = require('./handlers');
const externals = {};

externals.routes = [{
  method: 'GET',
  path: '/events',
  config: {
    auth: false,
    handler: Handlers.events
  }
// }, {
//   method: 'GET',
//   path: '/ami',
//   config: {
//     auth: false,
//     handler: Handlers.ami
//   }
}];

module.exports = externals.routes;