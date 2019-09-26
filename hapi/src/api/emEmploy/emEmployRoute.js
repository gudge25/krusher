/*jshint node:true*/
'use strict';
const configs = require('./emEmployConfig');
const route = require('src/middleware/route').emEmploy;

const FIND = `${route}/find`;
const PUT = `${route}`;
const PUTSTATUS = `${route}/status`;
const DEL = `${route}/{emID}`;
const PRIVATE = `${route}/private`;
const COUNTER = `${route}/counter`;
const STAT = `${route}/stat`;
const EXPORT = `${route}/stat/export`;

module.exports = (() =>
    [
        { method: 'POST', 	path: FIND, 	config: configs.findPostCtrl },
        { method: 'POST', 	path: route, 	config: configs.insert },
        { method: 'POST', 	path: STAT, 	config: configs.stat },
        { method: 'POST', 	path: EXPORT, 	config: configs.fileExport },
        { method: 'POST', 	path: COUNTER, 	config: configs.counter },
        { method: 'GET', 	path: PRIVATE, 	config: configs.private },
        { method: 'PUT', 	path: PUT, 	    config: configs.update },
        { method: 'PUT', 	path: PUTSTATUS,config: configs.updateStatus },
        { method: 'DELETE', path: DEL, 		config: configs.delete },
    ]
)();