/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./fmQuestionHandler');
const validate = require('./fmQuestionValidate');
const fmQuestionSchema = require('./fmQuestionSchema');

function fmQuestionConfig() {
    const schema = new fmQuestionSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find questions',
        tags: ['api'],
        validate: validate.findPost
    };
    self.findReport = {
        handler: handlers.findReport,
        description: 'Get Question report',
        tags: ['api'],
        validate: validate.findReport
    };
    self.insert = {
        handler: handlers.insert,
        description: 'Insert Question',
        tags: ['api'],
        validate: validate.insert
    };

    return self;
}

const handler = new fmQuestionConfig();
module.exports = handler;
