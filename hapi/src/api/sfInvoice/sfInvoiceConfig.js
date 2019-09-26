/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./sfInvoiceHandler');
const validate = require('./sfInvoiceValidate');
const sfInvoiceSchema = require('./sfInvoiceSchema');

function sfInvoiceConfig() {
    const schema = new sfInvoiceSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find Invoices',
        tags: ['api'],
        validate: validate.findPost
    };
    self.insert = {
        handler: handlers.insert,
        description: 'Insert Invoices',
        tags: ['api'],
        validate: validate.insert
    };
    self.update = {
        handler: handlers.update,
        description: 'Update Invoices',
        tags: ['api'],
        validate: validate.update
    };

    return self;
}

const handler = new sfInvoiceConfig();
module.exports = handler;
