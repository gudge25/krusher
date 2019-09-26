/*jshint node:true*/
'use strict';
const BaseHandler = require('src/base/BaseHandler');
const model = require('./slDealModel');
const schema = require('./slDealSchema');
const ReplyHelper = require('src/base/reply-helper');

function slDealHandler() {
    const params = { model, schema };
    const self = new BaseHandler(params);
    self.findPost = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindPost);
        const params = request.plugins.createControllerParams(request.payload, new schema().schemaFindPost());

        params.params.dcDate = params.params.dcDate ? params.params.dcDate.replace(/T/, ' ').replace(/\..+/, '') : null;
        model.repoFind(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            const params = { qty : data[1][0].Qty };
            helper.replyFind(err, data[0], params);
        });
    };
    self.findChart = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.Chart);
        const params = request.plugins.createControllerParams(request.payload, new schema().schemaChart());
        model.repoFindChart(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            helper.replyFind(null, data[0]);
        });
    };
    self.insByStatus = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.InsByStatus);
        const p = request.plugins.createControllerParams(request.payload, new schema().schemaByStatus());
        const data = new model.InsByStatus(p.params);
        const params = {
            params: data,
            loginName : p.loginName
        };
        model.repoInsByStatus(params, (err, data) => {
            return helper.replyInsert(err, data);
        });
    };
    self.insert = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindPost);
        const p = request.plugins.createControllerParams(request.payload, new schema().schemaInsert());
        p.params.dcDate = p.params.dcDate ? p.params.dcDate.replace(/T/, ' ').replace(/\..+/, '') : null;
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
    self.update = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.Update);
        const p = request.plugins.createControllerParams(request.payload, new schema().schemaUpdate());
        p.params.dcDate = p.params.dcDate ? p.params.dcDate.replace(/T/, ' ').replace(/\..+/, '') : null;
        const data = new model.Update(p.params);
        const params = {
            params: data,
            loginName: p.loginName
        };
        model.repoUpdate(params, (err, data) => {
            if (err) return helper.replyUpdate(err, null);
            helper.replyUpdate(err, data[0]);
        });
    };

    return self;
}

const handler = new slDealHandler();
module.exports = handler;
