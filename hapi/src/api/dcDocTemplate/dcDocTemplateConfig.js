/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./dcDocTemplateHandler');
const validate = require('./dcDocTemplateValidate');
const dcDocTemplateSchema = require('./dcDocTemplateSchema');
function dcDocTemplateConfig() {
    const schema = new dcDocTemplateSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find Doc Template',
        tags: ['api'],
        validate: validate.findPost
    };
    self.insert = {
        handler: handlers.insert,
        description: 'Insert Doc Template',
        tags: ['api'],
        validate: validate.insert
    };

    return self;
}

const handler = new dcDocTemplateConfig();
module.exports = handler;
