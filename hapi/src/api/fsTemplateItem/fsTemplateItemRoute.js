/*jshint node:true*/
'use strict';
const configs = require('./fsTemplateItemConfig');
const route = require('src/middleware/route').fsTemplateItem;

const FIND = `${route}/find`;
const INSERT = `${route}`;
const UPDATE = `${route}`;
const DELETE = `${route}/{ftiID}`;

module.exports = (() => {
    return [
        {   method: 'POST',   path: FIND,         config: configs.findPostCtrl },
        {   method: 'POST',   path: INSERT,       config: configs.insert },
        {   method: 'PUT',    path: UPDATE,       config: configs.update },
        {   method: 'DELETE', path: DELETE,       config: configs.delete },
    ];
})();
