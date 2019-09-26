/*jshint node:true*/
'use strict';
const BaseHandler = require('src/base/BaseHandler');
const model = require('./astUpdateModel');
const schema = require('./astUpdateSchema');
const ReplyHelper = require('src/base/reply-helper');

function AstUpdateHandler() {
    const params = { model, schema };
    const self = new BaseHandler(params);

    self.PHPexec = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.PHPexec);
        const params = request.plugins.createControllerParams(request.payload);
        model.repoScript(params, (err, data) => {
            if (err) return helper.replyPhp(err, null);
            helper.replyPhp(err, data);
        });
    };

    return self;
}

const handler = new AstUpdateHandler();
module.exports = handler;