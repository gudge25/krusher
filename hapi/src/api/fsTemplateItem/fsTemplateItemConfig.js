/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./fsTemplateItemHandler');
const validate = require('./fsTemplateItemValidate');
const fsTemplateItemSchema = require('./fsTemplateItemSchema');

function fsTemplateItemConfig() {
    const schema = new fsTemplateItemSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find Template items',
        tags: ['api'],
        validate: validate.findPost
    };
    self.insert = {
        handler: handlers.insert,
        description: 'Insert template item',
        tags: ['api'],
        validate: validate.insert
    };
    self.update = {
        handler: handlers.update,
        description: 'Update template item',
        tags: ['api'],
        validate: validate.update
    };

    return self;
}

const handler = new fsTemplateItemConfig();
module.exports = handler;
