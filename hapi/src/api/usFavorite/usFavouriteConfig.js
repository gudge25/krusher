/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./usFavouriteHandler');
const validate = require('./usFavouriteValidate');
const usFavouriteSchema = require('./usFavouriteSchema');

function usFavouriteConfig() {
    const schema = new usFavouriteSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find by any field',
        tags: ['api'],
        validate: validate.findPost
    };

    return self;
}

const handler = new usFavouriteConfig();
module.exports = handler;