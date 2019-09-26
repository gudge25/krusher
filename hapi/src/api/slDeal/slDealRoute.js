/*jshint node:true*/
'use strict';
const configs = require('./slDealConfig');
const route = require('src/middleware/route').slDeal;

const FIND = `${route}/find`;
const INSERT = `${route}`;
const UPDATE = `${route}`;
const DELETE = `${route}/{dcID}`;
const CHART = `${route}/chart`;
const BYSTATUS = `${route}/create`;

module.exports = (() => {
    return [
        {   method: 'POST',   path: FIND,         config: configs.findPostCtrl },
        {   method: 'POST',   path: INSERT,       config: configs.insert },
        {   method: 'POST',   path: CHART,        config: configs.findChart },
        {   method: 'POST',   path: BYSTATUS,     config: configs.insByStatus },
        {   method: 'PUT',    path: UPDATE,       config: configs.update },
        {   method: 'DELETE', path: DELETE,       config: configs.delete },
    ];
})();
