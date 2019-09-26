/*jshint node:true*/
'use strict';
const configs = require('./usSequenceConfig');
const route = require('src/middleware/route').usSequence;

const FIND = `${route}/next/{seqName}`;
const TIME = `${route}/time`;

module.exports = (() =>
    [
        { method: 'GET', 	path: FIND, 	config: configs.findByID },
        { method: 'GET', 	path: TIME, 	config: configs.findPostCtrl },
    ]
)();