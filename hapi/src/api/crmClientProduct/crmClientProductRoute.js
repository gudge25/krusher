/*jshint node:true*/
'use strict';
const configs = require('./crmClientProductConfig');
const route = require('src/middleware/route').crmClientProduct;

const FIND = `${route}/find`;
const INSERT = `${route}`;
const UPDATE = `${route}`;
const DELETE = `${route}/{cpID}`;

module.exports = (() => {
  return [
    { method: 'POST',   path: FIND,     config: configs.findPostCtrl },
    { method: 'POST',   path: INSERT,   config: configs.insert },
    { method: 'PUT',    path: UPDATE,   config: configs.update },
    { method: 'DELETE', path: DELETE,   config: configs.delete }
  ];
})();
