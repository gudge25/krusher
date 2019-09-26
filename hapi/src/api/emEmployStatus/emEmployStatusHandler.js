/*jshint node:true*/
'use strict';
const BaseHandler = require('src/base/BaseHandler');
const model = require('./emEmployStatusModel');
const schema = require('./emEmployStatusSchema');
const ReplyHelper = require('src/base/reply-helper');

function emEmployStatusHandler() {
    const params = { model, schema };
    const self = new BaseHandler(params);
    /*self.findPost = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindPost);
        const params = request.plugins.createControllerParams(request.payload, new schema().schemaFindPost());
        model.repoFind(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            const params = { qty : data[1][0].Qty };
            helper.replyFind(err, data[0], params);
        });
    };*/
    self.stat = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.Stat);
        const p = request.plugins.createControllerParams(request.orig.payload, new schema().schemaStat());
        p.params.DateFrom = p.params.DateFrom.replace(/T/, ' ').replace(/\..+/, '');
        p.params.DateTo = p.params.DateTo.replace(/T/, ' ').replace(/\..+/, '');
        const data = new model.StatIn(p.params);
        const params = {
            params: data,
            loginName: p.loginName,
            token: p.token
        };
        model.repoStat(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            helper.replyFind(err, data[0]);
        });
    };
    /*self.insert = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindPost);
        const p = request.plugins.createControllerParams(request.payload, new schema().schema);
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
    };*/

    return self;
}

const handler = new emEmployStatusHandler();
module.exports = handler;
