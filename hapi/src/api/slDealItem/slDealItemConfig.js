/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./slDealItemHandler');
const validate = require('./slDealItemValidate');
const slDealItemSchema = require('./slDealItemSchema');

function slDealItemConfig() {
    const schema = new slDealItemSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find Deal items',
        tags: ['api'],
        validate: validate.findPost
    };
    self.insert = {
        handler: handlers.insert,
        description: 'Insert Deal items',
        tags: ['api'],
        validate: validate.insert
    };


    return self;
}

const handler = new slDealItemConfig();
module.exports = handler;
