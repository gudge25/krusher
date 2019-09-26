/*jshint node:true*/
'use strict';
const configs = require('./fsTemplateConfig');
const route = require('src/middleware/route').fsTemplate;

const FIND = `${route}/find`;
const INSERT = `${route}`;
const UPDATE = `${route}`;
const DELETE = `${route}/{ftID}`;
const ENCODING = `${route}/encodings`;

module.exports = (() => {
    return [
        {   method: 'POST',   path: FIND,         config: configs.findPostCtrl },
        {   method: 'POST',   path: INSERT,       config: configs.insert },
        {   method: 'GET',    path: ENCODING,     config: configs.findEncoding },
        {   method: 'PUT',    path: UPDATE,       config: configs.update },
        {   method: 'DELETE', path: DELETE,       config: configs.delete },
    ];
})();
