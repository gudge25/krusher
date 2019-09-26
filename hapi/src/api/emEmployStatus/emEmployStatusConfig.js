/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./emEmployStatusHandler');
const validate = require('./emEmployStatusValidate');
const emEmployStatusSchema = require('./emEmployStatusSchema');
function emEmployStatusConfig() {
    const schema = new emEmployStatusSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    /*self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find',
        tags: ['api'],
        validate: validate.findPost
    };
    self.insert = {
        handler: handlers.insert,
        description: 'Insert',
        tags: ['api'],
        validate: validate.insert
    };*/
    self.stat = {
        handler: handlers.stat,
        description: 'Status stat',
        tags: ['api'],
        validate: validate.stat
    };

    return self;
}

const handler = new emEmployStatusConfig();
module.exports = handler;
