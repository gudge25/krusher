/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./usSequenceHandler');
const validate = require('./usSequenceValidate');
const usSequenceSchema = require('./usSequenceSchema');

function usSequenceConfig() {
    const schema = new usSequenceSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findByID = {
        handler: handlers.findByID,
        description: 'Find next sequence',
        tags: ['api'],
        validate: validate.findByID
    };
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Server time request',
        tags: ['api'],
        validate: validate.findPost,
        auth: false
    };

    return self;
}

const handler = new usSequenceConfig();
module.exports = handler;