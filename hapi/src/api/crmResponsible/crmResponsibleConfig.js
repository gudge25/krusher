/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./crmResponsibleHandler');
const validate = require('./crmResponsibleValidate');
const crmResponsibleSchema = require('./crmResponsibleSchema');

function crmResponsibleConfig() {
    const schema = new crmResponsibleSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find Resppnsible',
        tags: ['api'],
        validate: validate.findPost
    };
    self.insList = {
        handler: handlers.insList,
        description: 'Insert list of responsible',
        tags: ['api'],
        validate: validate.insList
    };
    self.setSabd = {
        handler: handlers.setSabd,
        description: 'Set responsible for call',
        tags: ['api'],
        validate: validate.setSabd
    };

    return self;
}

const handler = new crmResponsibleConfig();
module.exports = handler;