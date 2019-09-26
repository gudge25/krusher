/*jshint node:true*/
'use strict';
const configs = require('./emEmployStatusConfig');
const route = require('src/middleware/route').emEmployStatus;

/*const FIND = `${route}/find`;
const INSERT = `${route}`;*/
const STAT = `${route}/stat`;

module.exports = [
  /*{ method: 'POST',   path: FIND,   config: configs.findPostCtrl },
  { method: 'POST',   path: INSERT, config: configs.insert },*/
  { method: 'POST',   path: STAT,   config: configs.stat }
];
