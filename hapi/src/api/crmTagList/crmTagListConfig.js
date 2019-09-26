/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./crmTagListHandler');
const validate = require('./crmTagListValidate');
const crmTagSchema = require('./crmTagListSchema');

function crmTagListConfig() {
    const schema = new crmTagSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find tag',
        tags: ['api'],
        validate: validate.findPost
    };
    self.insert = {
        handler: handlers.Insert,
        description: 'Insert list of tags',
        tags: ['api'],
        validate: validate.insert
    };

    return self;
}

const handler = new crmTagListConfig();
module.exports = handler;