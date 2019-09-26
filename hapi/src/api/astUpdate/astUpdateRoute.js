/*jshint node:true*/
'use strict';
const configs = require('./astUpdateConfig');
const route = require('src/middleware/route').astUpdate;

const FIND = `${route}/{script}`;

module.exports = (() =>
    [
        { method: 'GET', 	path: FIND, 	config: configs.findPostCtrl },
    ]
)();