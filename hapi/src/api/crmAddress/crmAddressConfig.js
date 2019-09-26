/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./crmAddressHandler');
const validate = require('./crmAddressValidate');
const crmAddressSchema = require('./crmAddressSchema');

function crmAddressConfig() {
    const schema = new crmAddressSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find Address',
        tags: ['api'],
        validate: validate.findPost
    };
    self.insert = {
        handler: handlers.insert,
        description: 'Insert Address',
        tags: ['api'],
        validate: validate.insert
    };

    return self;
}

const handler = new crmAddressConfig();
module.exports = handler;