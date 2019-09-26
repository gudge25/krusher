/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./hClientHandler');
const validate = require('./hClientValidate');
const hClientSchema = require('./hClientSchema');

function HClientConfig() {
    const schema = new hClientSchema();
    const params = {validate, handlers, schema};
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find Client',
        tags: ['api'],
        validate: validate.findPost
    };

    return self;
}

const handler = new HClientConfig();
module.exports = handler;