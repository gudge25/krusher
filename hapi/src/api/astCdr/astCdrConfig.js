/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./astCdrHandler');
const validate = require('./astCdrValidate');
const astCdrSchema = require('./astCdrSchema');


function astCdrConfig() {
    const schema = new astCdrSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find',
        tags: ['api'],
        validate: validate.FindPost
    };

    return self;
}

const handler = new astCdrConfig();
module.exports = handler;