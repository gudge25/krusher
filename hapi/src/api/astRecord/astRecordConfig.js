/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./astRecordHandler');
const validate = require('./astRecordValidate');
const astRecordSchema = require('./astRecordSchema');

function astRecordConfig() {
    const schema = new astRecordSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find record',
        tags: ['api'],
        validate: validate.findPost
    };
    self.insert =
    {
        handler: handlers.insert,
        plugins: {
            'hapi-swagger': {
                payloadType: 'form'
            }
        },
        tags: ['api', 'fs', 'files'],
        description: 'Add records for IVR',
        validate: validate.insert,
        payload:
        {
            maxBytes: 20000000,
            output: 'stream',
            parse: true
        }
    };
    self.insertForce =
    {
        handler: handlers.insertForce,
        tags: ['api'],
        description: 'Add records without voice file',
        validate: validate.insertForce,
        auth: false
    };
    self.update = {
        handler: handlers.update,
        description: 'Update',
        tags: ['api'],
        validate: validate.update
    };

    return self;
}

const handler = new astRecordConfig();
module.exports = handler;