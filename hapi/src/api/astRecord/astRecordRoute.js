/*jshint node:true*/
'use strict';
const configs = require('./astRecordConfig');
const route = require('src/middleware/route').astRecord;

const FIND = `${route}/find`;
const INSERTFORCE = `${route}/force`;
const PUT = `${route}`;
const DEL = `${route}/{record_id}`;

module.exports = (() =>
    [
        { method: 'POST', 	path: FIND, 	        config: configs.findPostCtrl },
        { method: 'POST', 	path: route, 	        config: configs.insert },
        { method: 'POST', 	path: INSERTFORCE, 	    config: configs.insertForce },
        { method: 'PUT', 	path: PUT, 	            config: configs.update },
        { method: 'DELETE', path: DEL, 		        config: configs.delete },
    ]
)();