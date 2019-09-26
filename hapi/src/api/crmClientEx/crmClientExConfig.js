/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./crmClientExHandler');
const validate = require('./crmClientExValidate');
const crmClientExSchema = require('./crmClientExSchema');

function crmClientExConfig() {
    const schema = new crmClientExSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find ClientEx',
        tags: ['api'],
        validate: validate.findPost
    };
    self.insList = {
        handler: handlers.insList,
        description: 'Add new extended client',
        tags: ['api'],
        validate: validate.insList
    };
    self.setDial = {
        handler: handlers.setDial,
        description: 'Set Dial status client by ID',
        tags: ['api'],
        validate: validate.setDial,
        auth: false,
    };
    self.insert = {
        handler: handlers.insert,
        description: 'Insert',
        tags: ['api'],
        validate: validate.insert
    };
    self.update = {
        handler: handlers.update,
        description: 'Update',
        tags: ['api'],
        validate: validate.update
    };

    return self;
}

const handler = new crmClientExConfig();
module.exports = handler;