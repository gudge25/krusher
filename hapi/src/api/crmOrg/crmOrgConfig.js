/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./crmOrgHandler');
const validate = require('./crmOrgValidate');
const crmOrgSchema = require('./crmOrgSchema');

function crmOrgConfig() {
    const schema = new crmOrgSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find Organization',
        tags: ['api'],
        validate: validate.findPost
    };
    self.insert = {
        handler: handlers.insert,
        description: 'Insert Organization',
        tags: ['api'],
        validate: validate.insert
    };

    return self;
}

const handler = new crmOrgConfig();
module.exports = handler;