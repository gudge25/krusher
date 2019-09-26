/*jshint node:true*/
'use strict';
const BaseHandler = require('src/base/BaseHandler');
const model = require('./dcDocModel');
const schema = require('./dcDocSchema');
const ReplyHelper = require('src/base/reply-helper');

function dcDocHandler() {
    const params = { model, schema };
    const self = new BaseHandler(params);
    self.findPost = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindPost);
        const params = request.plugins.createControllerParams(request.payload, new schema().schemaFindPost());
        params.params.dateFrom = params.params.dateFrom ? params.params.dateFrom.toISOString().replace(/T/, ' ').replace(/\..+/, '') : null;
        params.params.dateTo = params.params.dateTo ? params.params.dateTo.toISOString().replace(/T/, ' ').replace(/\..+/, '') : null;
        model.repoFind(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            const params = { qty : data[1][0].Qty };
            helper.replyFind(err, data[0], params);
        });
    };
    self.findByClient = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindByClient);
        const params = request.plugins.createControllerParams(request.payload, new schema().schemaFindByCLient());
        params.params.dcDate = params.params.dcDate ? params.params.dcDate.toISOString().replace(/T/, ' ').replace(/\..+/, '') : null;
        model.repoFindByClient(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            const params = { qty : data[1][0].Qty };
            helper.replyFind(err, data[0], params);
        });
    };
    self.findStream = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindStream);
        const p = request.plugins.createControllerParams(request.params);
        p.params.emID = p.params.emID !== undefined ? p.params.emID : null;
        model.repoFindStream(p, (err, data) => {
            if (err) return helper.replyFind(err, null);
            helper.replyFind(err, data[0]);
        });
    };

    return self
}

const handler = new dcDocHandler();
module.exports = handler;
