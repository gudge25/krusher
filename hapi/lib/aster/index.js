'use strict';

const Handlers = require('./handlers');

exports.register = (plugin, options, next) => {

  const server = plugin.select('api');
  const io = require('socket.io')(server.listener);

  io.on('connection', (socket) => {
    const events =  server.events;
    events.on('create-contact',Handlers.create);
  });

  next();
};

exports.register.attributes = {
  name: 'hapi-chat'
};