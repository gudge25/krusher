/*jshint node:true*/
'use strict';
const BaseHandler = require('src/base/BaseHandler');
const model = require('./astRecallModel');
const schema = require('./astRecallSchema');
const ReplyHelper = require('src/base/reply-helper');

function astRecallHandler() {
    const params = { model, schema };
    const self = new BaseHandler(params);
    self.findPost = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindPost);
        const p = request.plugins.createControllerParams(request.payload, new schema().schemaFindPost());
        const data = new model.FindPostIn(p.params);
        const params = {
            params: data,
            loginName: p.loginName,
            token: p.token
        };
        model.repoFind(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            const params = { qty : data[1][0].Qty };
            helper.replyFind(err, data[0], params);
        });
    };
    self.update = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindPost);
        const p = request.plugins.createControllerParams(request.payload, new schema().schema);
        const data = new model.Update(p.params);
        const params = {
            params: data,
            loginName: p.loginName,
            token: p.token
        };
        model.repoUpdate(params, (err, data) => {
            if (err) return helper.replyUpdate(err, null);
            helper.replyUpdate(err, data);
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
    self.recall = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.Recall);
        const params = request.plugins.createControllerParams(request.payload);
        model.repoRecall(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            helper.replyFind(null, data[0]);
            /*if(data[0].length == 0 || (data[0].length == 1 && data[0][0].Qty == 0))
                helper.replyFind(err, []);
            else
            {
                helper.replyFind(null, data[0]);
            }*/
        });
    };

    return self;
}

const handler = new astRecallHandler();
module.exports = handler;