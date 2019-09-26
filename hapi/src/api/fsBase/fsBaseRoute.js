/*jshint node:true*/
'use strict';
const configs = require('./fsBaseConfig');
const route = require('src/middleware/route').fsBase;

const FIND = `${route}/find`;
const INSERT = `${route}`;
const UPDATE = `${route}`;
const DELETE = `${route}/{dbID}`;
const SABD = `${route}/sabd`;
const SABDDETAIL = `${route}/sabd/{ffID}`;

module.exports = (() => {
    return [
        { method: 'POST',   path: FIND,         config: configs.findPostCtrl },
        { method: 'POST',   path: INSERT,       config: configs.insert },
        { method: 'GET',    path: SABD,         config: configs.sabd },
        { method: 'GET',    path: SABDDETAIL,   config: configs.sabdDetail },
        { method: 'PUT',    path: UPDATE,       config: configs.update },
        { method: 'DELETE', path: DELETE,       config: configs.delete },
    ];
})();
