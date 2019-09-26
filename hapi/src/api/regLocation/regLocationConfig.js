/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./regLocationHandler');
const validate = require('./regLocationValidate');
const regLocationSchema = require('./regLocationSchema');

function regLocationConfig() {
    const schema = new regLocationSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find location',
        tags: ['api'],
        validate: validate.findPost
    };

    return self;
}

const handler = new regLocationConfig();
module.exports = handler;
