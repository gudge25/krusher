/*jshint node:true, esnext:true*/
'use strict';

const Glue = require('glue');
const _ = require('lodash');
const Manifest = require('src/config/manifest');
const Hapi = require('hapi');
const CorsHeaders = require('hapi-cors-headers');
const HapiEmitter = require('hapi-emitter');
const options = {};
const Events = require('lib/events/');
const ReplyHelper = require('src/base/reply-helper');
const events = require("events");
events.EventEmitter.prototype._maxListeners = 5000;
events.EventEmitter.defaultMaxListeners     = 1000;
const constants2 = require('src/config/constants').application;

//const eventDebug = require('event-debug');

Glue.compose(Manifest, options, (err, server) => {
  //Catch errors
  if(err) throw err;

  server.register([
    {
      register: HapiEmitter,
      options: {
        name: 'events',
      }
    },
    Events
  ], err => {

    //Catch errors
    if(err) throw err;
    
    server.ext('onPreResponse', CorsHeaders);
    const http = server.select(['api']);
    const https = server.select(['https']);
    const config = { auth: false };

    // api.route({config, method: 'GET',path: '/styles.js',handler: {file: '../fuse-admin-7.0.1/dist/styles.js'}});
    // api.route({config, method: 'GET',path: '/runtime.js',handler: {file: '../fuse-admin-7.0.1/dist/runtime.js',     filename: 'runtime.js'}});
    // api.route({config, method: 'GET',path: '/polyfills.js',handler: {file: '../fuse-admin-7.0.1/dist/polyfills.js', filename: 'polyfills.js'}});
    // api.route({config, method: 'GET',path: '/vendor.js',handler: {file: '../fuse-admin-7.0.1/dist/vendor.js',       filename: 'vendor.js'}});
    // api.route({config, method: 'GET',path: '/main.js',handler: {file: '../fuse-admin-7.0.1/dist/main.js',           filename: 'main.js'}});
    
    http.route({ 
      method: '*', 
      path: '/{param*}', 
      config,
      handler: function (request, reply) {
                  let portweb2 = parseInt(constants2.port) == 80 ? 443 :  parseInt(constants2.port) + 10;
                  return reply.redirect(`https://${request.info.hostname}:${portweb2}/${request.params.param}`).code(302); 
      }
    });
   

    

    // //Link with WEB
    // http.route({
    //   config, method: 'GET', path: '/{param*}',
    //   handler: {
    //     directory: {
    //       redirectToSlash: true, index: true,
    //       path: '../web',
    //     }
    //   }
    // });

    //Link with WEB
    https.route({
      config, method: 'GET', path: '/{param*}',
      handler: {
        directory: {
          redirectToSlash: true, index: true,
          path: '../web',
        }
      }
    });

    //Link with WEB for Anton
    https.route({
      config, method: 'GET', path: '/demo/{param*}',
      handler: {
        directory: {
          redirectToSlash: true,index: true,
          path: '../web'
        },
      }
    });


    // // FUSY CONFIG
    // api.route({
    //   config, method: 'GET', path: '/assets/{param*}',
    //   handler: {
    //     directory: {
    //       redirectToSlash: true, index: true,
    //       path: '../fuse-admin-7.0.1/dist/assets',
    //     }
    //   }
    // });

    // api.route({
    //   config, method: 'GET', path: '/new/{param*}',
    //   handler: {
    //     directory: {
    //       redirectToSlash: true, index: true,
    //       path: '../fuse-admin-7.0.1/dist/',
    //     }
    //   }
    // });



    // //Link with ????
    // api.route({
    //   method: 'GET',
    //   path: '/test',
    //   config: {
    //     auth: false,
    //     handler: (request,reply) => {
    //       const helper = new ReplyHelper(request, reply);
    //       helper.replyInsert(null,{ inserted: 0 });
    //     }
    //   }
    // });

    //Start Hapi & WS
    if (process.env.NODE_ENV !== 'test') {
        server.start(() => {
        // Log to the console the host and port info
          _.forEach(server.connections, connection => {
              console.log(`Server ${connection.settings.labels} started at:  ${connection.info.uri} protocol:${connection.info.protocol}(${connection.type})` );
          });
        });
    }
  });
});
