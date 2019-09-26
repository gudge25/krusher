/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./fsTemplateHandler');
const validate = require('./fsTemplateValidate');
const fsTemplateSchema = require('./fsTemplateSchema');

function fsTemplateConfig() {
    const schema = new fsTemplateSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find templates',
        tags: ['api'],
        validate: validate.findPost
    };
    self.findEncoding = {
        handler: handlers.findEncoding,
        description: 'Encoding',
        tags: ['api'],
        validate: validate.findEncoding
    };
    self.update = {
        handler: handlers.update,
        description: 'Update',
        tags: ['api'],
        validate: validate.update
    };
    self.insert = {
        handler: handlers.insert,
        description: 'Insert',
        tags: ['api'],
        validate: validate.insert
    };

    return self;
}

const handler = new fsTemplateConfig();
module.exports = handler;
