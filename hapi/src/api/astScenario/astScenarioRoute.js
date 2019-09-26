/*jshint node:true*/
'use strict';
const configs = require('./astScenarioConfig');
const route = require('src/middleware/route').astScenario;

const FIND = `${route}/find`;
const PUT = `${route}`;
const DEL = `${route}/{id_scenario}`;

module.exports = (() =>
    [
        { method: 'POST', 	path: FIND, 	config: configs.findPostCtrl },
        { method: 'POST', 	path: route, 	config: configs.insert },
        { method: 'PUT', 	path: PUT, 	    config: configs.update },
        { method: 'DELETE', path: DEL, 		config: configs.delete },
    ]
)();