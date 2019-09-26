/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./fmFormItemHandler');
const validate = require('./fmFormItemValidate');
const fmFormItemSchema = require('./fmFormItemSchema');

function fmFormItemConfig() {
    const schema = new fmFormItemSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find form items',
        tags: ['api'],
        validate: validate.findPost
    };
    self.insert = {
        handler: handlers.insert,
        description: 'Insert forms items',
        tags: ['api'],
        validate: validate.insert
    };

    return self;
}

const handler = new fmFormItemConfig();
module.exports = handler;