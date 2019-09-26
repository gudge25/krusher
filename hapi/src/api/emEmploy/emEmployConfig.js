/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./emEmployHandler');
const validate = require('./emEmployValidate');
const emEmploySchema = require('./emEmploySchema');

function emEmployConfig() {
    const schema = new emEmploySchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find',
        tags: ['api'],
        validate: validate.findPost
    };
    self.stat = {
        handler: handlers.stat,
        description: 'Stat',
        tags: ['api'],
        validate: validate.stat
    };
    self.counter = {
        handler: handlers.counter,
        description: 'Counter',
        tags: ['api'],
        validate: validate.counter
    };
    self.reportCalls = {
        handler: handlers.reportCalls,
        description: 'reportCalls',
        tags: ['api'],
        validate: validate.reportCalls
    };
    self.reportStatus = {
        handler: handlers.reportStatus,
        description: 'reportStatus',
        tags: ['api'],
        validate: validate.reportStatus
    };
    self.private = {
        handler: handlers.private,
        tags: ['api'],
        validate: validate.private,
        description: "Get private employ"
    };
    self.insert = {
        handler: handlers.insert,
        tags: ['api'],
        validate: validate.insert,
        description: "Add new employeer"
    };
    self.fileExport = {
        handler: handlers.fileExport,
        description: 'Export stat',
        tags: ['api', 'fs', 'files'],
        validate: validate.fileExport
    };
    self.updateStatus = {
        handler: handlers.updateStatus,
        description: 'Update status',
        tags: ['api'],
        validate: validate.updateStatus
    };

    return self;
}

const handler = new emEmployConfig();
module.exports = handler;