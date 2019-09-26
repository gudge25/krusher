/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./astMonitoringHandler');
const validate = require('./astMonitoringValidate');
const astMonitoringSchema = require('./astMonitoringSchema');

function astMonitoringConfig() {
    const schema = new astMonitoringSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find info from Monitoring',
        tags: ['api'],
        validate: validate.findPost
    };

    return self;
}

const handler = new astMonitoringConfig();
module.exports = handler;