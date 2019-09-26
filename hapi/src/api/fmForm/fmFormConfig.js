/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./fmFormHandler');
const validate = require('./fmFormValidate');
const fmFormSchema = require('./fmFormSchema');

function fmFormConfig() {
    const schema = new fmFormSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find application form',
        tags: ['api'],
        validate: validate.findPost
    };
    self.formExport = {
        handler: handlers.formExport,
        description: 'Export forms',
        tags: ['api'],
        validate: validate.formExport
    };
    self.insert = {
        handler: handlers.insert,
        description: 'Insert forms',
        tags: ['api'],
        validate: validate.insert
    };
    self.update = {
        handler: handlers.update,
        description: 'Update forms',
        tags: ['api'],
        validate: validate.update
    };


    return self;
}

const handler = new fmFormConfig();
module.exports = handler;
