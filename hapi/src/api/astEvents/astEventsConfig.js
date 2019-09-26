/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./astEventsHandler');
const validate = require('./astEventsValidate');
const astEventsSchema = require('./astEventsSchema');

function astEventsConfig() {
    const schema = new astEventsSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find Events',
        tags: ['api'],
        validate: validate.findPost
    };
    self.insert = {
        handler: handlers.insert,
        description: 'Insert',
        tags: ['api'],
        validate: validate.insert
    };

    return self;
}

const handler = new astEventsConfig();
module.exports = handler;