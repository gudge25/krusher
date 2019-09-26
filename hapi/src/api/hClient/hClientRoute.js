/*jshint node:true*/
'use strict';
const configs = require('./hClientConfig');
const route = require('src/middleware/route').hClient;

const FIND = `${route}/find`;

module.exports = (() =>
        [
            {method: 'POST', path: FIND, config: configs.findPostCtrl},
        ]
)();
