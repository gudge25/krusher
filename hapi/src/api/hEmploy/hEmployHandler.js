/*jshint node:true*/
'use strict';
const BaseHandler = require('src/base/BaseHandler');
const model = require('./hEmployModel');
const schema = require('./hEmploySchema');
const ReplyHelper = require('src/base/reply-helper');

function HEmployHandler() {
    const params = {model, schema};
    const self = new BaseHandler(params);
    self.findPost = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindPost);
        const p = request.plugins.createControllerParams(request.payload, new schema().schemaFindPost());
        p.params.DateChangeFrom = p.params.DateChangeFrom ? p.params.DateChangeFrom.toISOString().replace(/T/, ' ').replace(/\..+/, '') : null;
        p.params.DateChangeTo = p.params.DateChangeTo ? p.params.DateChangeTo.toISOString().replace(/T/, ' ').replace(/\..+/, '') : null;
        const data = new model.FindPostIn(p.params);
        const params = {
            params: data,
            loginName: p.loginName
        };
        model.repoFind(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            const params = {qty: data[1][0].Qty};
            helper.replyFind(err, data[0], params);
        });
    };

    return self;
}

const handler = new HEmployHandler();
module.exports = handler;
