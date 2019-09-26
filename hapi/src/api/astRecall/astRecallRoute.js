/*jshint node:true*/
'use strict';
const configs = require('./astRecallConfig');
const route = require('src/middleware/route').astRecall;

const FIND = `${route}/find`;
const PUT = `${route}`;
const DEL = `${route}/{rcID}`;
const RECALL = `${route}/auto`;

module.exports = (() =>
    [
        { method: 'POST', 	path: FIND, 	config: configs.findPostCtrl },
        { method: 'POST', 	path: route, 	config: configs.insert },
        { method: 'POST',   path: RECALL,   config: configs.recall },
        { method: 'PUT', 	path: PUT, 	    config: configs.update },
        { method: 'DELETE', path: DEL, 		config: configs.delete },
    ]
)();