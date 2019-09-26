/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./emClientHandler');
const validate = require('./emClientValidate');
const emClientSchema = require('./emClientSchema');

function emClientConfig() {
    const schema = new emClientSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.insert = {
        handler: handlers.insert,
        tags: ['api'],
        validate: validate.insert,
        description: "Add new client",
        auth: false,
    };
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find clients',
        tags: ['api'],
        validate: validate.findPost
    };

    return self;
}

const handler = new emClientConfig();
module.exports = handler;