'use strict';
const PassThrough = require('stream').PassThrough;
const externals = {};

externals.events = (request, reply) => {
  const events = request.server.events;
  const stream = new PassThrough({ objectMode: true });
  stream.write({
    event: 'ping'
  });
  var interval = setInterval(() => {
    stream.write({
      event: 'ping'
    });
  }, 10000);

  var handler = msg => {
    stream.write(msg);
  };
  events.on('events', handler);

  request.raw.req.on("close", () => {
      console.log("----------------- OOPS listener closed -----------------");
      clearInterval(interval);
      events.removeListener('events', handler);
  });

  reply.event(stream, null, { event: 'api' });
};

// externals.ami = (request, reply) => {
//   const stream = new PassThrough({ objectMode: true });
//   const events = request.server.events;

//   stream.write({
//     event: 'ping'
//   });

//   setInterval(() => {
//     stream.write({
//       event: 'ping'
//     });
//   }, 60000 * 5);

//   events.on('ami', msg => {
//     stream.write(msg);
//   });

//   reply.event(stream, null, { event: 'ami' });
// };

// externals.autocall = (request, reply) => {
//   reply('ok');
// };

// externals.stop = (request, reply) => {
//   reply('ok');
// };

// externals.progress = (request, reply) => {
//   reply('ok');
// };

// externals.call = (request, reply) => {
//   reply('ok');
// };

// externals.hangup = (request, reply) => {
//   reply('ok');
// };

module.exports = externals;