/*jshint node:true*/
'use strict';
const BaseHandler = require('src/base/BaseHandler');
const model = require('./fmQuestionItemModel');
const schema = require('./fmQuestionItemSchema');
const ReplyHelper = require('src/base/reply-helper');

function fmQuestionItemHandler() {
    const params = { model, schema };
    const self = new BaseHandler(params);
    self.findPost = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindPost);
        const p = request.plugins.createControllerParams(request.payload, new schema().schemaFindPost());
        const data = new model.FindPostIn(p.params);
        const params = {
            params: data,
            loginName: p.loginName
        };
        model.repoFind(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            const params = { qty : data[1][0].Qty };
            helper.replyFind(err, data[0], params);
        });
    };
    self.findReport = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindReport);
        const p = request.plugins.createControllerParams(request.orig.payload, new schema().schemaReport());
        p.params.DateFrom = p.params.DateFrom ? p.params.DateFrom.replace(/T/, ' ').replace(/\..+/, '') : null;
        p.params.DateTo = p.params.DateTo ? p.params.DateTo.replace(/T/, ' ').replace(/\..+/, '') : null;
        delete p.params.isActive;
        const data = new model.FindReportIn(p.params);
        const params = {
            params: data,
            loginName: p.loginName,
            token: p.token
        };
        model.repoFindReport(params, (err, data) => {
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

const handler = new fmQuestionItemHandler();
module.exports = handler;
