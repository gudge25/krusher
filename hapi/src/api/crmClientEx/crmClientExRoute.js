/*jshint node:true*/
'use strict';
const configs = require('./crmClientExConfig');
const route = require('src/middleware/route').crmClientEx;

const FIND = `${route}/find`;
const PUT = `${route}`;
const DEL = `${route}/{clID}`;
const INSLIST = `${route}/list`;
const SETDIAL = `${route}/setdial/{clID}/{isdial?}`;

module.exports = (() =>
    [
        { method: 'POST', 	path: FIND, 	config: configs.findPostCtrl },
        { method: 'POST', 	path: route, 	config: configs.insert },
        { method: 'POST', 	path: INSLIST, 	config: configs.insList },
        { method: 'POST', 	path: SETDIAL, 	config: configs.setDial },
        { method: 'PUT', 	path: PUT, 	    config: configs.update },
        { method: 'DELETE', path: DEL, 		config: configs.delete },
    ]
)();
