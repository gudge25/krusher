/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./astRouteOutgoingHandler');
const validate = require('./astRouteOutgoingValidate');
const astRouteOutgoingSchema = require('./astRouteOutgoingSchema');

function astRouteOutgoingConfig() {
    const schema = new astRouteOutgoingSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find scheme',
        tags: ['api'],
        validate: validate.findPost
    };
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

const handler = new astRouteOutgoingConfig();
module.exports = handler;