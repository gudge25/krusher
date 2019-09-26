// 'use strict';

// exports.register = (plugin, options, next) => {

//   plugin.route({
//     method: 'POST',
//     path: '/events',
//     config: {
//       plugins: {
//         websocket: {
//           only: true,
//           create: (wss) => {
//             /* no-op */
//           },
//           connect: (wss, ws) => {
//             ws.send(JSON.stringify({ cmd: 'WELCOME' }));
//             this.to = setInterval(() => {
//               ws.send(JSON.stringify({ cmd: 'PING' }));
//             }, 5000);
//           },
//           disconnect: (wss, ws) => {
//             if (this.to !== null) {
//               clearTimeout(this.to);
//               this.to = null;
//             }
//           }
//         }
//       }
//     },
//     handler: (request, reply) => {
//       if (typeof request.payload.cmd !== 'string') {
//         return reply(Boom.badRequest('invalid request'));
//       }
//       if (request.payload.cmd === 'PING') {
//         return reply({ result: 'PONG' });
//       }
//       else if (request.payload.cmd === 'AWAKE-ALL') {
//         const wss = request.websocket().wss;
//         wss.clients.forEach((ws) => {

//           ws.send(JSON.stringify({ cmd: 'AWAKE' }));
//         });
//         return reply().code(204);
//       }
//       return reply(Boom.badRequest('unknown command'));
//     }
//   });

//   next();
// };

// exports.register.attributes = {
//   name: 'events',
//   dependencies: ['hapi-plugin-websocket']
// };