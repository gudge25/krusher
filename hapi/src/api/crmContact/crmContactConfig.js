/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./crmContactHandler');
const validate = require('./crmContactValidate');
const crmContactSchema = require('./crmContactSchema');

function crmContactConfig() {
    const schema = new crmContactSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find Contact',
        tags: ['api'],
        validate: validate.findPost
    };
    self.insert = {
        handler: handlers.insert,
        description: 'Insert Contact',
        tags: ['api'],
        validate: validate.insert
    };

    return self;
}

const handler = new crmContactConfig();
module.exports = handler;