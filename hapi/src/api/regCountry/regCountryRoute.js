/*jshint node:true*/
'use strict';
const configs = require('./regCountryConfig');
const route = require('src/middleware/route').regCountry;

const FIND = `${route}/find`;
/*const INSERT = `${route}`;
const UPDATE = `${route}`;
const DELETE = `${route}/{cID}`;*/

module.exports = (() => {
    return [
        { method: 'POST',   path: FIND,       config: configs.findPostCtrl },
  /*      { method: 'POST',   path: INSERT,     config: configs.insert },
        { method: 'PUT',    path: UPDATE,     config: configs.update },
        { method: 'DELETE', path: DELETE,     config: configs.delete }*/
    ];
})();
