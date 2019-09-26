/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./regValidationHandler');
const validate = require('./regValidationValidate');
const regValidationSchema = require('./regValidationSchema');

function regValidationConfig() {
    const schema = new regValidationSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Validate info',
        tags: ['api'],
        validate: validate.findPost
    };
    self.checkPhone = {
        handler: handlers.checkPhone,
        description: 'Check phone',
        tags: ['api'],
        validate: validate.checkPhone
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

const handler = new regValidationConfig();
module.exports = handler;
