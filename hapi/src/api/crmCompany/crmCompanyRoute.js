/*jshint node:true*/
'use strict';
const configs = require('./crmCompanyConfig');
const route = require('src/middleware/route').crmCompany;

const FIND = `${route}/find`;
const PUT = `${route}`;
const DEL = `${route}/{coID}`;

module.exports = (() =>
    [
        { method: 'POST', 	path: FIND, 	config: configs.findPostCtrl },
        { method: 'POST', 	path: route, 	config: configs.insert },
        { method: 'PUT', 	path: PUT, 	    config: configs.update },
        { method: 'DELETE', path: DEL, 		config: configs.delete },
    ]
)();