/*jshint node:true*/
'use strict';
const configs = require('./emEmployExConfig');
const route = require('src/middleware/route').emEmployEx;

const FIND = `${route}/find`;
const INSERT = `${route}`;
const UPDATE = `${route}`;
const DELETE = `${route}/{emID}`;

module.exports = [
    { method: 'POST', path: FIND, config: configs.findPostCtrl },
    { method: 'POST', path: INSERT, config: configs.insert },
    { method: 'PUT', path: UPDATE, config: configs.update },
    { method: 'DELETE', path: DELETE, config: configs.delete }
];

