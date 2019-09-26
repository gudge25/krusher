'use strict';

exports.register = (plugin, options, next) => {
  const routes = require('./routes');
  const server = plugin.select(['https']);
  server.route(routes);
  next();
};

exports.register.attributes = {
  name: 'hapi-events',
  dependencies: ['susie','hapi-emitter']
};