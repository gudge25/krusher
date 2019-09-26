/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./smsSmsHandler');
const validate = require('./smsSmsValidate');
const smsSmsSchema = require('./smsSmsSchema');

function smsSmsConfig() {
    const schema = new smsSmsSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    /*self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find sms',
        tags: ['api'],
        validate: validate.findPost
    };*/
    self.insert = {
        handler: handlers.insert,
        description: 'Insert single sms',
        tags: ['api'],
        validate: validate.insert
    };
    self.insertBulk = {
        handler: handlers.insertBulk,
        description: 'Insert bulk sms',
        tags: ['api'],
        validate: validate.insertBulk
    };
    self.updateBulk = {
        handler: handlers.updateBulk,
        description: 'Update bulk sms',
        tags: ['api'],
        validate: validate.updateBulk
    };
    self.findBulk = {
        handler: handlers.findBulk,
        description: 'Find bulk sms',
        tags: ['api'],
        validate: validate.findBulk
    };
    self.deleteBulk = {
        handler: handlers.deleteBulk,
        description: 'Delete bulk sms',
        tags: ['api'],
        validate: validate.deleteBulk
    };



    /*self.incoming = {
        handler: handlers.incoming,
        description: 'Insert incoming sms',
        tags: ['api'],
        validate: validate.incoming
    };*/
    self.incomingGoip = {
        handler: handlers.incomingGoip,
        description: 'Insert incoming sms from GoIP',
        tags: ['api'],
        validate: validate.incomingGoip,
        auth: false
    };

    return self;
}

const handler = new smsSmsConfig();
module.exports = handler;