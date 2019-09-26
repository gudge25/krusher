/*jshint node:true*/
'use strict';
const BaseHandler = require('src/base/BaseHandler');
const model = require('./astTimeGroupItemsModel');
const schema = require('./astTimeGroupItemsSchema');
const ReplyHelper = require('src/base/reply-helper');

function astTimeGroupItemsHandler() {
    const params = { model, schema };
    const self = new BaseHandler(params);
    self.findPost = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindPost);
        const params = request.plugins.createControllerParams(request.payload, new schema().schemaFindPost());
        model.repoFind(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            const params = { qty : data[1][0].Qty };
            helper.replyFind(err, data[0], params);
        });
    };
    self.update = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindPost);
        const params = request.plugins.createControllerParams(request.payload, new schema().schema);
        model.repoUpdate(params, (err, data) => {
            if (err) return helper.replyUpdate(err, null);
            helper.replyUpdate(err, data[0]);
        });
    };
    self.insert = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.Insert);
        const p = request.plugins.createControllerParams(request.payload, new schema().schemaInsert());
        const params = {
            params: p.params,
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

const handler = new astTimeGroupItemsHandler();
module.exports = handler;