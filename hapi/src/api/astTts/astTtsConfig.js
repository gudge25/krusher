/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./astTtsHandler');
const validate = require('./astTtsValidate');
const astTtsSchema = require('./astTtsSchema');

function astTtsConfig() {
    const schema = new astTtsSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find Trunk',
        tags: ['api'],
        validate: validate.findPost
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

const handler = new astTtsConfig();
module.exports = handler;