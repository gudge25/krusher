/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./crmClientProductHandler');
const validate = require('./crmClientProductValidate');
const crmClientProductSchema = require('./crmClientProductSchema');

function crmClientProductConfig() {
    const schema = new crmClientProductSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find Client product',
        tags: ['api'],
        validate: validate.findPost
    };
    self.insert = {
        handler: handlers.insert,
        description: 'Insert Client product',
        tags: ['api'],
        validate: validate.insert
    };

    return self;
}

const handler = new crmClientProductConfig();
module.exports = handler;
