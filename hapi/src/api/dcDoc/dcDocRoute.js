/*jshint node:true*/
'use strict';
const configs = require('./dcDocConfig');
const route = require('src/middleware/route').dcDoc;

const FIND = `${route}/find`;
const STREAM = `${route}/stream/{emID?}`;
const FINDBYCLIENT = `${route}/clients/find`;

module.exports = (() => {
    return [
        { method: 'POST',   path: FIND,             config: configs.findPostCtrl },
        { method: 'GET',    path: STREAM,           config: configs.findStream },
        { method: 'POST',   path: FINDBYCLIENT,     config: configs.findByClient },
    ];
})();
