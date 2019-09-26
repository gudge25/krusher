/*jshint node:true*/
'use strict';
const BaseHandler = require('src/base/BaseHandler');
const model = require('./smsSmsModel');
const schema = require('./smsSmsSchema');
const ReplyHelper = require('src/base/reply-helper');

function smsSmsHandler() {
    const params = { model, schema };
    const self = new BaseHandler(params);
    /*self.findPost = (request, reply) => {
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
    };*/
    self.insert = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.Insert);
        const p = request.plugins.createControllerParams(request.payload, new schema().schemaInsert());
        p.params.emID = p.emIDEditor;
        const data = new model.Insert(p.params);
        const params = {
            params: data,
            loginName: p.loginName,
            token: p.token
        };
        console.log(params);
        model.repoInsert(params, (err, data) => {
            if (err) return helper.replyInsert(err, null);
            helper.replyInsert(err, data);
        });
    };
    self.insertBulk = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.InsertBulk);
        const p = request.plugins.createControllerParams(request.orig.payload, new schema().schemaInsertBulk());
        p.params.emID = p.emIDEditor;
        p.params.timeBegin = p.params.timeBegin ? p.params.timeBegin.replace(/T/, ' ').replace(/\..+/, '') : null;
        const data = new model.InsertBulk(p.params);
        const params = {
            params: data,
            loginName: p.loginName,
            token: p.token
        };
        model.repoInsertBulk(params, (err, data) => {
            if (err) return helper.replyInsert(err, null);
            helper.replyInsert(err, data);
        });
    };
    self.updateBulk = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.UpdateBulk);
        const p = request.plugins.createControllerParams(request.orig.payload, new schema().schemaUpdateBulk());
        p.params.emID = p.emIDEditor;
        p.params.timeBegin = p.params.timeBegin ? p.params.timeBegin.replace(/T/, ' ').replace(/\..+/, '') : null;
        const data = new model.UpdateBulk(p.params);
        const params = {
            params: data,
            loginName: p.loginName,
            token: p.token
        };
        model.repoUpdateBulk(params, (err, data) => {
            if (err) return helper.replyUpdate(err, null);
            helper.replyUpdate(err, data[0]);
        });
    };
    self.findBulk = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindBulkPost);
        const params = request.plugins.createControllerParams(request.orig.payload, new schema().schemaFindBulkPost());
        params.params.timeBegin = params.params.timeBegin ? params.params.timeBegin.replace(/T/, ' ').replace(/\..+/, '') : null;
        /*const p = request.plugins.createControllerParams(request.orig.payload, new schema().schemaFindBulkPost());
        p.params.timeBegin = p.params.timeBegin ? p.params.timeBegin.replace(/T/, ' ').replace(/\..+/, '') : null;
        console.log(p);
        const data = new model.FindBulkPostIn(p.params);
        console.log(data);
        const params = {
            params: data,
            loginName: p.loginName,
            token: p.token
        };*/
        model.repoBulkFind(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            const params = { qty : data[1][0].Qty };
            helper.replyFind(err, data[0], params);
        });
    };
    self.deleteBulk = (request, reply) => {
        const helper = new ReplyHelper(request, reply);
        const params = request.plugins.createControllerParams(request.params);
        model.repoBulkDelete(params, (err, data) => {
            helper.replyDelete(err, data);
        });
    };


    /*self.incoming = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.Insert);
        const p = request.plugins.createControllerParams(request.payload, new schema().schemaInsert());
        const data = new model.Insert(p.params);
        const params = {
            params: data,
            loginName: p.loginName,
            token: p.token
        };
        model.repoIncoming(params, (err, data) => {
            if (err) return helper.replyInsert(err, null);
            helper.replyInsert(err, data);
        });
    };*/
    self.incomingGoip = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.InsertGoipIncoming);
        const p = request.plugins.createControllerParams(request.payload, new schema().schemaGoipIncoming());
        const data = new model.InsertGoipIncoming(p.params);
        const params = {
            params: data,
            loginName: p.loginName,
            token: p.token
        };
        model.repoIncomingGoip(params, (err, data) => {
            if (err) return helper.replyInsert(err, null);
            helper.replyInsert(err, data);
        });
    };

    return self;
}

const handler = new smsSmsHandler();
module.exports = handler;