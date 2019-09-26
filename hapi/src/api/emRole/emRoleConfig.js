/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./emRoleHandler');
const validate = require('./emRoleValidate');
const emRoleSchema = require('./emRoleSchema');

function emRoleConfig() {
    const schema = new emRoleSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find role by params',
        tags: ['api'],
        validate: validate.findPost
    };
    self.insert = {
        handler: handlers.insert,
        description: 'Insert role',
        tags: ['api'],
        validate: validate.insert
    };

    return self;
}

const handler = new emRoleConfig();
module.exports = handler;
