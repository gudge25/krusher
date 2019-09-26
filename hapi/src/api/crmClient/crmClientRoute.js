/*jshint node:true*/
'use strict';
const configs = require('./crmClientConfig');
const route = require('src/middleware/route').crmClient;

const FIND = `${route}/find`;
const PUT = `${route}`;
const DEL = `${route}/{clID}`;
const BULKDEL = `${route}/bulkdel`;
const STREAM = `${route}/stream/{emID?}`;
const FINDBYCONTACT = `${route}/find/{ccName}`;
const FINDBYPHONE = `${route}/find/{Aid}/{ccName}`;
const SEARCH = `${route}/search/{clName}`;
const POSTSEARCH = `${route}/search`;
const GETIPCLIENT = `${route}/findIPClient/{ccName}`;
const FINDSUM = `${route}/summary`;
const FINDBYPARENT = `${route}/parent/{clID}`;
const SETACTUAL = `${route}/actualize`;
const UPDSABD = `${route}/sabd`;
const FINDSABD = `${route}/sabd/{clID}`;
const GETSAVE = `${route}/save/{clID}`;
const INSSAVE = `${route}/save`;
const UPDSAVE = `${route}/save/{clID}`;

module.exports = (() =>
    [
            {method: 'POST', path: FIND, config: configs.findPostCtrl},
            {method: 'POST', path: route, config: configs.insert},
            {method: 'POST', path: FINDSUM, config: configs.findSum},
            {method: 'POST', path: SETACTUAL, config: configs.setActual},
            {method: 'POST', path: UPDSABD, config: configs.updSabd},
            {method: 'POST', path: INSSAVE, config: configs.insSave},
            {method: 'POST', path: POSTSEARCH, config: configs.search},
            {method: 'POST', path: BULKDEL, config: configs.bulkdelete},
            {method: 'GET', path: SEARCH, config: configs.getByName},
            {method: 'GET', path: GETSAVE, config: configs.getSave},
            {method: 'GET', path: STREAM, config: configs.findStream},
            {method: 'GET', path: FINDBYCONTACT, config: configs.getByContact},
            {method: 'GET', path: FINDBYPHONE, config: configs.getByPhone},
            {method: 'GET', path: GETIPCLIENT, config: configs.getIPClient},
            {method: 'GET', path: FINDBYPARENT, config: configs.findByParent},
            {method: 'GET', path: FINDSABD, config: configs.findSabd},
            {method: 'PUT', path: PUT, config: configs.update},
            {method: 'PUT', path: UPDSAVE, config: configs.updSave},
            {method: 'DELETE', path: DEL, config: configs.delete},
    ]
)();
