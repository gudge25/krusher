/*jshint node:true*/
'use strict';
const configs = require('./fmFormConfig');
const route = require('src/middleware/route').fmForm;

const FIND = `${route}/find`;
const INSERT = `${route}`;
const UPDATE = `${route}`;
const DELETE = `${route}/{dcID}`;
const EXPORT = `${route}/export`;

module.exports = (() => {
    return [
        { method: 'POST',   path: FIND,       config: configs.findPostCtrl },
        { method: 'POST',   path: INSERT,     config: configs.insert },
        { method: 'POST',   path: EXPORT,     config: configs.formExport },
        { method: 'PUT',    path: UPDATE,     config: configs.update },
        { method: 'DELETE', path: DELETE,     config: configs.delete }
    ];
})();
