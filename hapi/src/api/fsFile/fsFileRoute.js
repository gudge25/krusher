/*jshint node:true*/
'use strict';
const configs = require('./fsFileConfig');
const route = require('src/middleware/route').fsFile;

const FIND = `${route}/find`;
const INSERT = `${route}/import`;
const INSERTFILE = `${route}`;
const UPDATE = `${route}`;
const DELETE = `${route}/{ffID}`;
const BULKDEL = `${route}/clear/{ffID}`;
const FINDBYID = `${route}/{ffID}`;
const UPDSTATUS = `${route}/updstatus/{ffID}`;
const EXPORT = `${route}/export/{ffID}`;
const DETAIL = `${route}/detail`;

module.exports = (() => {
    return [
        { method: 'POST',   path: FIND,         config: configs.findPostCtrl },
        { method: 'POST',   path: UPDSTATUS,    config: configs.updStatus },
        { method: 'POST',   path: INSERT,       config: configs.insert },
        { method: 'POST',   path: INSERTFILE,   config: configs.insertForce},
        { method: 'POST',   path: DETAIL,       config: configs.detail },
        { method: 'GET',    path: EXPORT,       config: configs.fileExport },
        { method: 'GET',    path: FINDBYID,     config: configs.findByID },
        { method: 'PUT',    path: UPDATE,       config: configs.update },
        { method: 'DELETE', path: DELETE,       config: configs.delete },
        { method: 'DELETE', path: BULKDEL,      config: configs.bulkdel },
    ];
})();
