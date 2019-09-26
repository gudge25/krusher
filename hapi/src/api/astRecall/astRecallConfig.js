/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./astRecallHandler');
const validate = require('./astRecallValidate');
const astRecallSchema = require('./astRecallSchema');

function astRecallConfig() {
    const schema = new astRecallSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find',
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
    self.recall = {
        handler: handlers.recall,
        description: 'Recall',
        tags: ['api'],
        validate: validate.recall
    };

    return self;
}

const handler = new astRecallConfig();
module.exports = handler;