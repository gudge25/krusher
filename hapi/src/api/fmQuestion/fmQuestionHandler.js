/*jshint node:true*/
'use strict';
const BaseHandler = require('src/base/BaseHandler');
const model = require('./fmQuestionModel');
const schema = require('./fmQuestionSchema');
const ReplyHelper = require('src/base/reply-helper');

function fmQuestionHandler() {
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
    self.findReport = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindReport);
        const params = request.plugins.createControllerParams(request.orig.payload, new schema().schemaReport());
        //const p = params.params;
        params.params.DateFrom = params.params.DateFrom ? params.params.DateFrom.replace(/T/, ' ').replace(/\..+/, '') : null;
        params.params.DateTo = params.params.DateTo ? params.params.DateTo.replace(/T/, ' ').replace(/\..+/, '') : null;
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

const handler = new fmQuestionHandler();
module.exports = handler;
