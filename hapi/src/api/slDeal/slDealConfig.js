/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./slDealHandler');
const validate = require('./slDealValidate');
const slDealSchema = require('./slDealSchema');

function slDealConfig() {
    const schema = new slDealSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);

    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find Deals',
        tags: ['api'],
        validate: validate.findPost
    };
    self.findChart = {
        handler: handlers.findChart,
        description: 'Get deal chart',
        tags: ['api'],
        validate: validate.findChart
    };
    self.insByStatus = {
        handler: handlers.insByStatus,
        description: 'Create deal by status',
        tags: ['api'],
        validate: validate.insByStatus
    };
    self.insert = {
        handler: handlers.insert,
        description: 'Insert deal',
        tags: ['api'],
        validate: validate.insert
    };
    self.update = {
        handler: handlers.update,
        description: 'Update deal',
        tags: ['api'],
        validate: validate.update
    };

    return self;
}

const handler = new slDealConfig();
module.exports = handler;
