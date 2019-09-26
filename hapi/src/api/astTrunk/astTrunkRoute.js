/*jshint node:true*/
'use strict';
const configs = require('./astTrunkConfig');
const route = require('src/middleware/route').astTrunk;

const FIND = `${route}/find`;
const PUT = `${route}`;
const DEL = `${route}/{trID}`;

module.exports = (() =>
    [
        { method: 'POST', 	path: FIND, 	config: configs.findPostCtrl },
        { method: 'POST', 	path: route, 	config: configs.insert },
        { method: 'PUT', 	path: PUT, 	    config: configs.update },
        { method: 'DELETE', path: DEL, 		config: configs.delete },
    ]
)();