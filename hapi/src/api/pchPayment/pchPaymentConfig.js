/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./pchPaymentHandler');
const validate = require('./pchPaymentValidate');
const pchPaymentSchema = require('./pchPaymentSchema');

function pchPaymentConfig() {
    const schema = new pchPaymentSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find payment',
        tags: ['api'],
        validate: validate.findPost
    };
    self.insert = {
        handler: handlers.insert,
        description: 'Insert payment',
        tags: ['api'],
        validate: validate.insert
    };

    return self;
}

const handler = new pchPaymentConfig();
module.exports = handler;
