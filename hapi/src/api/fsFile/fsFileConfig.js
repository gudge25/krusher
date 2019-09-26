/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./fsFileHandler');
const validate = require('./fsFileValidate');
const fsFileSchema = require('./fsFileSchema');

function fsFileConfig() {
    const schema = new fsFileSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);

    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find db',
        tags: ['api'],
        validate: validate.findPost
    };
    self.updStatus = {
        handler: handlers.updStatus,
        description: 'Update db status',
        tags: ['api'],
        validate: validate.updStatus
    };
    self.insert = {
        handler: handlers.insert,
        description: 'Add db with clients',
        plugins: {
            'hapi-swagger': {
                payloadType: 'form'
            }
        },
        tags: ['api', 'fs', 'files'],
        validate: validate.insert,
        payload: {
            maxBytes: 20000000,
            output: 'stream',
            parse: true
        },
    };
    self.detail = {
        handler: handlers.detail,
        description: 'Get db detail',
        tags: ['api'],
        validate: validate.detail
    };
    self.insertForce = {
        handler: handlers.insertForce,
        description: 'Add db without file',
        tags: ['api'],
        validate: validate.insertForce
    };
    self.update = {
        handler: handlers.update,
        description: 'Update file by ID',
        tags: ['api'],
        validate: validate.update
    };
    self.delete = {
        handler: handlers.delete,
        description: 'Remove file by ID',
        tags: ['api'],
        validate: validate.delete
    };
    self.bulkdel = {
        handler: handlers.bulkdel,
        description: 'Remove clients by db ID',
        tags: ['api'],
        validate: validate.bulkdel
    };
    self.fileExport = {
        handler: handlers.fileExport,
        description: 'Export db by ID',
        tags: ['api', 'fs', 'files'],
        validate: validate.fileExport,
        //auth: false,
    };
    self.findByID = {
        handler: handlers.findByID,
        description: 'Get db summary',
        tags: ['api'],
        validate: validate.findByID,
    };

    return self;
}

const handler = new fsFileConfig();
module.exports = handler;
