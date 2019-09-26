/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./astAutodialProcessHandler');
const validate = require('./astAutodialProcessValidate');
const astAutodialProcessSchema = require('./astAutodialProcessSchema');

function astAutodialProcessConfig() {
    const schema = new astAutodialProcessSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find',
        tags: ['api'],
        validate: validate.findPost
    };
    self.AutocallCtrl = {
        handler: handlers.Autocall,
        description: 'Autocall 2.0',
        tags: ['api'],
        validate: validate.Autocall
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

const handler = new astAutodialProcessConfig();
module.exports = handler;