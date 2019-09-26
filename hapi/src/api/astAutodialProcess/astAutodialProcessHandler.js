/*jshint node:true*/
'use strict';
const BaseHandler = require('src/base/BaseHandler');
const model = require('./astAutodialProcessModel');
const schema = require('./astAutodialProcessSchema');
const ReplyHelper = require('src/base/reply-helper');

function astAutodialProcessHandler() {
    const params = { model, schema };
    const self = new BaseHandler(params);
    self.findPost = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindPost);
        const params = request.plugins.createControllerParams(request.orig.payload, new schema().schemaFindPost());
        params.params.planDateBegin = params.params.planDateBegin ? params.params.planDateBegin.replace(/T/, ' ').replace(/\..+/, '') : null;
        model.repoFind(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            const params = { qty : data[1][0].Qty };
            helper.replyFind(err, data[0], params);
        });
    };
    self.update = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.Update);
        const p = request.plugins.createControllerParams(request.orig.payload, new schema().schema);
        p.params.planDateBegin = p.params.planDateBegin ? p.params.planDateBegin.replace(/T/, ' ').replace(/\..+/, '') : null;
        const data = new model.Update(p.params);
        const params = {
            params: data,
            loginName: p.loginName,
            token: p.token
        };
        model.repoUpdate(params, (err, data) => {
            if (err) return helper.replyUpdate(err, null);
            helper.replyUpdate(err, data[0]);
        });
    };
    self.Autocall = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.Autocall);
        const params = request.plugins.createControllerParams(request.payload);
        model.repoAutocall(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            helper.replyFind(err, data[0]);
            /*if(data[0].length == 0 || (data[0].length == 1 && data[0][0].Qty == 0))
                helper.replyFind(err, []);
            else
            {
                helper.replyFind(null, data[0]);
             //   helper.replyFind(err, data[0]);
            }*/
        });
    };
    self.insert = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.Insert);
        const p = request.plugins.createControllerParams(request.orig.payload, new schema().schemaInsert());
        p.params.planDateBegin = p.params.planDateBegin ? p.params.planDateBegin.replace(/T/, ' ').replace(/\..+/, '') : null;
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

const handler = new astAutodialProcessHandler();
module.exports = handler;

