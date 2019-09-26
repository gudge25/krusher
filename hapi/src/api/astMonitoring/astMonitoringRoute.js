/*jshint node:true*/
'use strict';
const configs = require('./astMonitoringConfig');
const route = require('src/middleware/route').astMonitoring;

const FIND = `${route}/find`;

module.exports = (() =>
    [
        { method: 'POST', 	path: FIND, 	config: configs.findPostCtrl },
        { method: 'POST', 	path: route, 	config: configs.insert },
    ]
)();