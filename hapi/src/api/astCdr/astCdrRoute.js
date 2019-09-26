/*jshint node:true*/
'use strict';
const configs = require('./astCdrConfig');
const route = require('src/middleware/route').astCdr;

const FIND = `${route}`;

module.exports = (() =>
    [
        { method: 'POST', 	path: FIND, 	config: configs.findPostCtrl }
    ]
)();
