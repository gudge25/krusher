/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./fmFormTypeHandler');
const validate = require('./fmFormTypeValidate');
const fmFormTypeSchema = require('./fmFormTypeSchema');

function fmFormTypeConfig() {
    const schema = new fmFormTypeSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find form types',
        tags: ['api'],
        validate: validate.findPost
    };
    self.findLookup = {
        handler: handlers.findLookup,
        description: 'search form type',
        tags: ['api'],
        validate: validate.lookup
    };
    self.insert = {
        handler: handlers.insert,
        description: 'Insert forms',
        tags: ['api'],
        validate: validate.insert
    };

    return self;
}

const handler = new fmFormTypeConfig();
module.exports = handler;
