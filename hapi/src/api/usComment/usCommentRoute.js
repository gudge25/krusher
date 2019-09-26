/*jshint node:true*/
'use strict';
const configs = require('./usCommentConfig');
const route = require('src/middleware/route').usComment;

const FIND = `${route}/find`;
const INSERT = `${route}`;
const DELETE = `${route}/{id}`;

module.exports = (() => {
    return [
        { method: 'POST',   path: FIND,       config: configs.findPostCtrl },
        { method: 'POST',   path: INSERT,     config: configs.insert },
        { method: 'DELETE', path: DELETE,     config: configs.delete }
    ];
})();
