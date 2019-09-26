/*jshint node:true*/
'use strict';
const BaseHandler = require('src/base/BaseHandler');
const model = require('./astEventsModel');
const schema = require('./astEventsSchema');
const ReplyHelper = require('src/base/reply-helper');

function astEventsHandler() {
    const params = { model, schema };
    const self = new BaseHandler(params);
    self.findPost = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindPost);
        const params = request.plugins.createControllerParams(request.payload);
        params.params.DateFrom = params.params.DateFrom ? params.params.DateFrom.toISOString().replace(/T/, ' ').replace(/\..+/, '') : null;
        params.params.DateTo = params.params.DateTo ? params.params.DateTo.toISOString().replace(/T/, ' ').replace(/\..+/, '') : null;
        model.repoFind(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            helper.replyFind(err, data[0]);
        });
    };
    self.insert = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.Insert);
        const p = request.plugins.createControllerParams(request.payload, new schema().schemaInsert());
        const data = new model.Insert(p.params);
        const params = {
            params: data,
            loginName: p.loginName,
            token: p.token
        };
        model.repoInsert(params, (err, data) => {
            if (err) return helper.replyInsert(err, null);
            helper.replyInsert(err, data);
        });
    };

    return self;
}

const handler = new astEventsHandler();
module.exports = handler;