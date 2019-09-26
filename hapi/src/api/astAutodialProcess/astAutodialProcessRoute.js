/*jshint node:true*/
'use strict';
const configs = require('./astAutodialProcessConfig');
const route = require('src/middleware/route').astAutodialProcess;

const FIND = `${route}/find`;
const PUT = `${route}`;
const DEL = `${route}/{id_autodial}`;
const AUTOCALL = `${route}/autocall`;

module.exports = (() =>
    [
        { method: 'POST', 	path: FIND, 	    config: configs.findPostCtrl },
        { method: 'POST', 	path: route, 	    config: configs.insert },
        { method: 'PUT', 	path: PUT, 	        config: configs.update },
        { method: 'DELETE', path: DEL, 		    config: configs.delete },
        { method: 'POST',   path: AUTOCALL, 	config: configs.AutocallCtrl },
    ]
)();