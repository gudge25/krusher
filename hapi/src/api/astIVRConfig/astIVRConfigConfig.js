/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./astIVRConfigHandler');
const validate = require('./astIVRConfigValidate');
const astIVRConfigSchema = require('./astIVRConfigSchema');

function astIVRConfigConfig() {
    const schema = new astIVRConfigSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find',
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

const handler = new astIVRConfigConfig();
module.exports = handler;