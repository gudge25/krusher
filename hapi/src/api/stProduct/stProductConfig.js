/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./stProductHandler');
const validate = require('./stProductValidate');
const stProductSchema = require('./stProductSchema');

function stProductConfig() {
    const schema = new stProductSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find product',
        tags: ['api'],
        validate: validate.findPost
    };
    self.insert = {
        handler: handlers.insert,
        description: 'Insert product',
        tags: ['api'],
        validate: validate.insert
    };

    return self;
}

const handler = new stProductConfig();
module.exports = handler;