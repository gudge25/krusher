/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./hEmployHandler');
const validate = require('./hEmployValidate');
const hEmploySchema = require('./hEmploySchema');

function HEmployConfig() {
    const schema = new hEmploySchema();
    const params = {validate, handlers, schema};
    const self = new BaseConfig(params);
    self.findPostCtrl = {
        handler: handlers.findPost,
        description: 'Find Employ',
        tags: ['api'],
        validate: validate.findPost
    };

    return self;
}

const handler = new HEmployConfig();
module.exports = handler;