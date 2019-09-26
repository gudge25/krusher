/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./fmQuestionItemHandler');
const validate = require('./fmQuestionItemValidate');
const fmQuestionItemSchema = require('./fmQuestionItemSchema');

function fmQuestionItemConfig() {
    const schema = new fmQuestionItemSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find question items',
        tags: ['api'],
        validate: validate.findPost
    };
    self.findReport = {
        handler: handlers.findReport,
        description: 'Get Question item report',
        tags: ['api'],
        validate: validate.findReport
    };
    self.insert = {
        handler: handlers.insert,
        description: 'Insert Question item',
        tags: ['api'],
        validate: validate.insert
    };

    return self;
}

const handler = new fmQuestionItemConfig();
module.exports = handler;
