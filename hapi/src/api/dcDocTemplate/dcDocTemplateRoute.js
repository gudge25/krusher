/*jshint node:true*/
'use strict';
const configs = require('./dcDocTemplateConfig');
const route = require('src/middleware/route').dcDocTemplate;

const FIND = `${route}/find`;
const INSERT = `${route}`;
const UPDATE = `${route}`;
const DELETE = `${route}/{dtID}`;

module.exports = (() => {
  return [
    { method: 'POST',   path: FIND,   config: configs.findPostCtrl },
    { method: 'POST',   path: INSERT, config: configs.insert },
    { method: 'PUT',    path: UPDATE, config: configs.update },
    { method: 'DELETE', path: DELETE, config: configs.delete  }
  ];
})();
