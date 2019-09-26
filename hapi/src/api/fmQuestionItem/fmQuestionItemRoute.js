/*jshint node:true*/
'use strict';
const configs = require('./fmQuestionItemConfig');
const route = require('src/middleware/route').fmQuestionItem;

const FIND = `${route}/find`;
const INSERT = `${route}`;
const UPDATE = `${route}`;
const DELETE = `${route}/{qiID}`;
const REPORT = `${route}/report`;

module.exports = (() => {
    return [
        { method: 'POST',   path: FIND,       config: configs.findPostCtrl },
        { method: 'POST',   path: INSERT,     config: configs.insert },
        { method: 'POST',   path: REPORT,     config: configs.findReport },
        { method: 'PUT',    path: UPDATE,     config: configs.update },
        { method: 'DELETE', path: DELETE,     config: configs.delete }
    ];
})();
