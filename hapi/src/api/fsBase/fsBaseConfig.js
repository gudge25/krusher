/*jshint node:true*/
'use strict';
const Joi = require('joi');
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./fsBaseHandler');
const validate = require('./fsBaseValidate');
const fsBaseSchema = require('./fsBaseSchema');

function fsBaseConfig() {
    const schema = new fsBaseSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);

    self.sabd = {
        handler: handlers.sabd,
        description: 'Sabd',
        tags: ['api'],
        validate: validate.sabd,
    };
    self.sabdDetail = {
        handler: handlers.sabdDetail,
        description: 'SabdDetail',
        tags: ['api'],
        validate: validate.sabdDetail,
    };
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find Bases',
        tags: ['api'],
        validate: validate.findPost
    };
    self.update = {
        handler: handlers.update,
        description: 'Update',
        tags: ['api'],
        validate: validate.update
    };
    self.insert = {
        handler: handlers.insert,
        description: 'Insert',
        tags: ['api'],
        validate: validate.insert
    };

    return self;
}

const handler = new fsBaseConfig();
module.exports = handler;
