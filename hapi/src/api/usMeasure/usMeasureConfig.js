/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./usMeasureHandler');
const validate = require('./usMeasureValidate');
const usMeasureSchema = require('./usMeasureSchema');

function usMeasureConfig() {
    const schema = new usMeasureSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find measure by any field',
        tags: ['api'],
        validate: validate.findPost
    };
    self.insert = {
        handler: handlers.insert,
        description: 'Insert measure',
        tags: ['api'],
        validate: validate.insert
    };

    return self;
}

const handler = new usMeasureConfig();
module.exports = handler;