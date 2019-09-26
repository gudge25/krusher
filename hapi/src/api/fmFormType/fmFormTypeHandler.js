/*jshint node:true*/
'use strict';
const BaseHandler = require('src/base/BaseHandler');
const model = require('./fmFormTypeModel');
const schema = require('./fmFormTypeSchema');
const ReplyHelper = require('src/base/reply-helper');

function fmFormTypeHandler() {
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
    self.findLookup = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindLookup);
        const params = request.plugins.createControllerParams(request.params);
        model.repoFindLookup(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            helper.replyFind(err, data[0]);
        });
    };
    self.insert = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindPost);
        const p = request.plugins.createControllerParams(request.payload, new schema().schemaInsert());
        const params = {
            params: p.params,
            loginName: p.loginName,
            token: p.token
        };
        model.repoInsert(params, (err, data) => {
            if (err) return helper.replyInsert(err, null);
            helper.replyInsert(err, data[0]);
        });
    };

    return self
}

const handler = new fmFormTypeHandler();
module.exports = handler;
