/*jshint node:true*/
'use strict';
const configs = require('./hEmployConfig');
const route = require('src/middleware/route').hEmploy;

const FIND = `${route}/find`;

module.exports = (() =>
        [
            {method: 'POST', path: FIND, config: configs.findPostCtrl},
        ]
)();
