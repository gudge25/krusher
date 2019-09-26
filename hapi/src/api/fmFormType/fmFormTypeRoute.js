/*jshint node:true*/
'use strict';
const configs = require('./fmFormTypeConfig');
const route = require('src/middleware/route').fmFormType;

const FIND = `${route}/find`;
const INSERT = `${route}`;
const UPDATE = `${route}`;
const DELETE = `${route}/{tpID}`;
const LOOKUP = `${route}/lookup`;

module.exports = (() => {
    return [
        { method: 'POST',   path: FIND,       config: configs.findPostCtrl },
        { method: 'POST',   path: INSERT,     config: configs.insert },
        { method: 'PUT',    path: UPDATE,     config: configs.update },
        { method: 'GET',    path: LOOKUP,     config: configs.findLookup },
        { method: 'DELETE', path: DELETE,     config: configs.delete }
    ];
})();
