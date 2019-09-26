'use strict';

const db = require('src/middleware/db');
const constants = require('src/config/constants.js').database;

const externals = {}

db.setConn(constants.user, constants.password);
externals.getParams = function (params) {
  const p = {
    loginName: 'lgdmitry',
    params: params
  }
  return p;
}

module.exports = externals
