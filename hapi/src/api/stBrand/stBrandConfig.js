/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./stBrandHandler');
const validate = require('./stBrandValidate');
const stBrandSchema = require('./stBrandSchema');

function stBrandConfig() {
    const schema = new stBrandSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find brand',
        tags: ['api'],
        validate: validate.findPost
    };
    self.insert = {
        handler: handlers.insert,
        description: 'Insert brand',
        tags: ['api'],
        validate: validate.insert
    };

    return self;
}

const handler = new stBrandConfig();
module.exports = handler;