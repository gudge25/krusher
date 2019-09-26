/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./crmStatusHandler');
const validate = require('./crmStatusValidate');
const crmStatusSchema = require('./crmStatusSchema');

function crmStatusConfig() {
    const schema = new crmStatusSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
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

const handler = new crmStatusConfig();
module.exports = handler;