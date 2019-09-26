/*jshint node:true*/
'use strict';
const configs = require('./regValidationConfig');
const route = require('src/middleware/route').regValidation;

const FIND = `${route}/find`;
const PHONE = `${route}/phone`;
const INSERT = `${route}`;
const UPDATE = `${route}`;
const DELETE = `${route}/{vID}`;

module.exports = (() => {
    return [
        { method: 'POST',   path: FIND,       config: configs.findPostCtrl },
        { method: 'POST',   path: PHONE,      config: configs.checkPhone },
        { method: 'POST',   path: INSERT,     config: configs.insert },
        { method: 'PUT',    path: UPDATE,     config: configs.update },
        { method: 'DELETE', path: DELETE,     config: configs.delete }
    ];
})();
