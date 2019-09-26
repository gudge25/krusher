/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./sfInvoiceItemHandler');
const validate = require('./sfInvoiceItemValidate');
const sfInvoiceItemSchema = require('./sfInvoiceItemSchema');

function sfInvoiceItemConfig() {
    const schema = new sfInvoiceItemSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find Invoice items',
        tags: ['api'],
        validate: validate.findPost
    };
    self.insert = {
        handler: handlers.insert,
        description: 'Insert Invoice items',
        tags: ['api'],
        validate: validate.insert
    };

    return self;
}

const handler = new sfInvoiceItemConfig();
module.exports = handler;
