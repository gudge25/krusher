/*jshint node:true*/
'use strict';
const BaseHandler = require('src/base/BaseHandler');
const model = require('./crmClientExModel');
const schema = require('./crmClientExSchema');
const ReplyHelper = require('src/base/reply-helper');
const parse = require('js2xmlparser').parse;

function crmClientExHandler() {
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
        const helper = new ReplyHelper(request, reply, model.Find);
        const p = request.plugins.createControllerParams(request.payload, new schema().schemaFindPost());
        const data = parse('data', p.params);
        const params = {
            params: data,
            loginName : p.loginName
        };
        model.repoInsList(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            helper.replyInsert(err, data[0]);
        });
    };
    self.setDial = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.SetDial);
        const params = request.plugins.createControllerParams(request.params, new schema().schemaSetDial());
        model.repoSetDial(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            helper.replyUpdate(err, data[0]);
        });
    };
    self.insert = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.Insert);
        const p = request.plugins.createControllerParams(request.orig.payload, new schema().schema);
        p.params.CallDate = p.params.CallDate ? p.params.CallDate.replace(/T/, ' ').replace(/\..+/, '') : null;
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
    self.update = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindPost);
        const params = request.plugins.createControllerParams(request.orig.payload, new schema().schema);
        params.params.CallDate = params.params.CallDate ? params.params.CallDate.replace(/T/, ' ').replace(/\..+/, '') : null;
        model.repoUpdate(params, (err, data) => {
            if (err) return helper.replyUpdate(err, null);
            helper.replyUpdate(err, data[0]);
        });
    };

    return self;
}

const handler = new crmClientExHandler();
module.exports = handler;