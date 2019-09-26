/*jshint node:true*/
'use strict';
const BaseHandler = require('src/base/BaseHandler');
const model = require('./astCdrModel');
const schema = require('./astCdrSchema');
const ReplyHelper = require('src/base/reply-helper');

function astCdrHandler() {
    const params = { model, schema };
    const self = new BaseHandler(params);
    self.findPost = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindPost);
        const params = request.plugins.createControllerParams(request.payload);
        model.repoFind(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            /*const params = { qty : data[1][0].Qty };
            helper.replyFind(err, data[0], params);*/
            helper.replyFind(err, data[0]);
        });
    };

    return self;
}

const handler = new astCdrHandler();
module.exports = handler;