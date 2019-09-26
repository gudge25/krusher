/*jshint node:true*/
'use strict';
const configs = require('./astEventsConfig');
const route = require('src/middleware/route').astEvents;

const FIND = `${route}/find`;

module.exports = (() =>
    [
        { method: 'POST', 	path: FIND, 	config: configs.findPostCtrl },
        { method: 'POST', 	path: route, 	config: configs.insert },
    ]
)();