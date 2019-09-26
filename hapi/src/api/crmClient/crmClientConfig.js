/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./crmClientHandler');
const validate = require('./crmClientValidate');
const crmClientSchema = require('./crmClientSchema');

function crmClientConfig() {
    const schema = new crmClientSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find Client',
        tags: ['api'],
        validate: validate.findPost
    };
    self.bulkdelete = {
        handler: handlers.bulkdelete,
        description: 'Delete Clients',
        tags: ['api'],
        validate: validate.bulkdelete
    };
    self.findStream = {
        handler: handlers.findStream,
        description: 'Get client stream by ID',
        tags: ['api'],
        validate: validate.findStream
    };
    self.getByContact = {
        handler: handlers.getByContact,
        description: 'Get client by contact (phone, email, etc)',
        tags: ['api'],
        validate: validate.getByContact
    };
    self.getByPhone = {
        handler: handlers.getByPhone,
        description: 'Get client by phone',
        tags: ['api'],
        validate: validate.getByPhone
    };
    self.getIPClient = {
        handler: handlers.getIPClient,
        description: 'Get client by phone',
        tags: ['api'],
        validate: validate.getIPClient
    };
    self.findSum = {
        handler: handlers.findSum,
        description: 'Find client summary',
        tags: ['api'],
        validate: validate.findSum
    };
    self.findByParent = {
        handler: handlers.findByParent,
        description: 'Get client by parent ID',
        tags: ['api'],
        validate: validate.findByParent
    };
    self.setActual = {
        handler: handlers.setActual,
        description: 'Set actual client by ID',
        tags: ['api'],
        validate: validate.setActual
    };
    self.updSabd = {
        handler: handlers.updSabd,
        description: 'Update sabd client',
        tags: ['api'],
        validate: validate.updSabd
    };
    self.findSabd = {
        handler: handlers.findSabd,
        description: 'Get client sabd by ID',
        tags: ['api'],
        validate: validate.findSabd
    };
    self.getSave = {
        handler: handlers.getSave,
        description: 'Save client by ID',
        tags: ['api'],
        validate: validate.getSave
    };
    self.insSave = {
        handler: handlers.insSave,
        description: 'Save new client and add in crm table',
        tags: ['api'],
        validate: validate.insSave
    };
    self.updSave = {
        handler: handlers.updSave,
        description: 'Save by ID',
        tags: ['api'],
        validate: validate.updSave
    };
    self.insert = {
        handler: handlers.insert,
        description: 'Insert new client',
        tags: ['api'],
        validate: validate.insert
    };
    self.search = {
        handler: handlers.search,
        description: 'Search client',
        tags: ['api'],
        validate: validate.search
    };
    self.getByName = {
        handler: handlers.getByName,
        description: 'Search client',
        tags: ['api'],
        validate: validate.getByName
    };
    self.update = {
        handler: handlers.update,
        description: 'Update a client',
        tags: ['api'],
        validate: validate.update
    };
    self.delete = {
        handler: handlers.delete,
        description: 'Delete a client',
        tags: ['api'],
        validate: validate.delete
    };

    return self;
}

const handler = new crmClientConfig();
module.exports = handler;