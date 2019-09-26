/*jshint node:true*/
'use strict';
const configs = require('./crmResponsibleConfig');
const route = require('src/middleware/route').crmResponsible;

const FIND = `${route}/find`;
//const PUT = `${route}/{clID}`;
//const DEL = `${route}/{clID}`;
const LIST = `${route}/list`;
const SETSABD = `${route}/sabd/{ffID}`;

module.exports = (() =>
    [
        { method: 'POST', 	path: FIND, 	config: configs.findPostCtrl },
        { method: 'POST', 	path: route, 	config: configs.insert },
        { method: 'POST', 	path: LIST, 	config: configs.insList },
        { method: 'POST', 	path: SETSABD, 	config: configs.setSabd },
//        { method: 'PUT', 	path: PUT, 	    config: configs.update },
//        { method: 'DELETE', path: DEL, 		config: configs.delete },
    ]
)();