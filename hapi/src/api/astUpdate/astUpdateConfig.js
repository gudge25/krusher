/*jshint node:true*/
'use strict';
const Joi = require('joi')
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./astUpdateHandler');
const validate = require('./astUpdateValidate');
const astUpdateSchema = require('./astUpdateSchema');

function AstUpdateConfig() {
    const schema = new astUpdateSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);

    self.findPostCtrl = {
      handler: handlers.PHPexec,
      description: 'Script launch',
      tags: ['api'],
      validate: validate.PHPexec
    };

    return self;
}

const handler = new AstUpdateConfig();
module.exports = handler;