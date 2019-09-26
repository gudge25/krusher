/*jshint node:true*/
'use strict';
const BaseHandler = require('src/base/BaseHandler');
const model = require('./crmResponsibleModel');
const schema = require('./crmResponsibleSchema');
const ReplyHelper = require('src/base/reply-helper');

function crmResponsibleHandler() {
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
    self.insList = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.InsList);
        const p = request.plugins.createControllerParams(request.payload);
        const data = new model.InsList(p.params);
        const params = {
            params: data,
            loginName: p.loginName
        };
        model.repoInsList(params, (err, data) => {
            if (err) return helper.replyInsert(err, null);
            helper.replyInsert(err, data[0]);
        });
    };
    self.setSabd = (request, reply) => {
        const helper = new ReplyHelper(request, reply);
        const p = request.plugins.createControllerParams(request.params);
        const params = {
            params: p.params,
            loginName: p.loginName
        };
        model.repoSetSabd(params, (err, data) => {
            if (err) return helper.replyInsert(err, null);
            helper.replyInsert(err, data[0]);
        });
    };

    return self;
}

const handler = new crmResponsibleHandler();
module.exports = handler;
