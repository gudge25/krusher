/*jshint node:true*/
'use strict';
const BaseHandler = require('src/base/BaseHandler');
const model = require('./emClientModel');
const schema = require('./emClientSchema');
const ReplyHelper = require('src/base/reply-helper');

function emClientHandler() {
    const params = { model, schema };
    const self = new BaseHandler(params);
    self.insert = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.Insert);
        const params = request.plugins.createControllerParams(request.payload, new schema().schemaInsert());
        model.repoInsert(params, (err, data) => {
            if (err) return helper.replyInsert(err, null);
            helper.replyInsert(err, data[0]);
        });
    };
    self.findPost = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindPost);
        const params = request.plugins.createControllerParams(request.payload, new schema().schemaFindPost());
        model.repoFind(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            const params = { qty : data[1][0].Qty };
            helper.replyFind(err, data[0], params);
        });
    };

    return self;
}

const handler = new emClientHandler();
module.exports = handler;