'use strict';

const fs = require('fs');
const Path = require('path');
const constants = require('src/config/constants').application;
const internals = {};

/* ==============================DEFAULT vars\const=================================== */
const tls = {
    key:  fs.readFileSync( Path.join(__dirname, '../../keys/') + 'privkey.pem'),
    cert: fs.readFileSync( Path.join(__dirname, '../../keys/') + 'cert.pem')
};
const timeout = {
    server: 60000 * 20,
    socket: 60000 * 22
};
const log = false;
const filesWeb = {
    relativeTo: Path.join(__dirname, '../../')
};
const filesWs = {
    relativeTo: Path.join(__dirname, '../../lib/ami')
};
/* ==================================================================================== */
const httpsport = parseInt(constants.port) == 80 ? 443 :  parseInt(constants.port) + 10;

internals.manifest = {
    server: {
        connections: {
            router: {
                stripTrailingSlash: true
                // isCaseSensitive: false
            },
            routes: {
                security: true,
                log
            }
        }
    },
    connections: [
        { //Setting for HAPI port HTTPS 3000 default
            host: constants.host,
            port: parseInt(constants.port),
            routes: {
                cors: true,
                files: filesWeb,
                log,
                //timeout
            },
            labels: ['api']
        },
        { //Setting for HAPI port HTTPS 443 default
            tls,
            host: constants.host,
            port: httpsport,
            routes: {
                cors: true,
                files: filesWeb,
                log,
                timeout
            },
            labels: ['https']
        },
        { //Setting for WS autocall port 3001 default
            host: constants.host,
            port: parseInt(constants.port) + 1,
            routes: {
                cors: true,
                files: filesWs,
                log
            },
            labels: ['ws']
        },
        { //Setting for WSS autocall port 3002 default
            tls,
            host: constants.host,
            port: parseInt(constants.port) + 11,
            routes: {
                cors: true,
                files: filesWs,
            },
            labels: ['wss']
        }],
    registrations: [
        { plugin: { register:'inert'  } },                   // Static file and directory handlers
        { plugin: { register:'vision' } },                  // Templates rendering support
        { plugin: { register:'susie'  } },                    // Server-Sent Events with hapi
        { plugin: 'hapi-auth-basic' },                      // Basic authentificate
        { plugin: 'lib/auth',
            options: {
                select: ['api','https','ws','wss']
            }
        },
        { plugin: 'lib/req'},
        { plugin: 'hapi-plugin-websocket',      // Hapi WebSocket
            options: {
                select: ['https']
            }
        },
        { plugin: {                             // Hapi Router
                register: 'hapi-router',
                options: {
                    routes: 'src/api/**/*Route.js'
                }
            },
            options: {
                select: ['api','https']
            }
        },
        {  plugin: {                             // Swagger
                register: 'hapi-swagger',
                options: {
                    info: {
                        title: 'CRM Krusher API Documentation',
                        description: "Workflow for Inserting, Finding, Updating or Deleting data",
                        contact: {
                            "name": "Develop Team",
                            "url": "https://krusher.biz",
                            "email": "info@krusher.biz"
                        },
                    },
                    expanded: 'none',
                    swaggerUI: true,
                    jsonEditor: false,
                    basePath: '/api',
                    pathPrefixSize: 2,
                    tags: [
                        { name: 'ast',  description: 'Asterisk Service', externalDocs: { 'description': 'more about asterisk', 'url':'http://wiki.asterisk.org'} },
                        { name: 'cc',   description: 'Calling Card or Lead data'},
                        { name: 'crm',  description: 'Clients data'},
                        { name: 'dc',   description: 'Documents data'},
                        { name: 'em',   description: 'Users data'},
                        { name: 'fm',   description: 'Forms & Questions data'},
                        { name: 'fs',   description: 'Files data'},
                        { name: 'pch',  description: 'Payments data'},
                        { name: 'php',  description: 'Exec php script'},
                        { name: 'reg',  description: 'Regions data'},
                        { name: 'sf',   description: 'Invoice data'},
                        { name: 'sl',   description: 'Deals data'},
                        { name: 'st',   description: 'Product,Brand,Category data'},
                        { name: 'us',   description: 'Enum, Comments, etc .... data'},
                        { name: 'h',    description: 'History of changes any data'},
                        { name: 'mp',   description: 'MarketPlace engine'},
                        { name: 'sms',  description: 'SMS service'},
                    ]
                }
            },
            options: {
                select: ['https']
            }
        },
        { plugin: { // WebSocket Plugin and asterisk autocall module
                register: 'lib/ami'
            },
            options: {
                select: ['wss']
            }
        },
        { plugin: {
                register: 'good',
                options: {
                    ops: {
                        'interval': 1000
                    },
                    reporters: {
                        console: [{
                            module: 'good-squeeze',
                            name: 'Squeeze',
                            args: [{
                                response: '*',
                                error: '*',
                                log: '*',
                            }]
                        }, {
                            'module': 'good-console',
                            'args': [{ format: 'YYYY.MM.DD HH:mm:ss.SSS'}]
                        },
                            'stdout'
                        ]
                    }
                }
            }
        }
    ]
};
module.exports = internals.manifest;