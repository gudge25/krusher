/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./dcDocHandler');
const validate = require('./dcDocValidate');
const dcDocSchema = require('./dcDocSchema');

function dcDocConfig() {
    const schema = new dcDocSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find document',
        tags: ['api'],
        validate: validate.findPost
    };
    self.findStream = {
        handler: handlers.findStream,
        description: 'Stream list',
        tags: ['api'],
        validate: validate.findStream
    };
    self.findByClient = {
        handler: handlers.findByClient,
        description: 'Get documents by client ID',
        tags: ['api'],
        validate: validate.findByClient
    };

    return self;
}

const handler = new dcDocConfig();
module.exports = handler;
