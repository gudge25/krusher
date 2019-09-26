/*jshint node:true*/
'use strict';
const BaseHandler = require('src/base/BaseHandler');
const model = require('./astMonitoringModel');
const schema = require('./astMonitoringSchema');
const ReplyHelper = require('src/base/reply-helper');

function astMonitoringHandler() {
    const params = { model, schema };
    const self = new BaseHandler(params);
    self.findPost = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindPost);
        const params = request.plugins.createControllerParams(request.payload);
        params.params.startDate = params.params.startDate ? params.params.startDate.toISOString().replace(/T/, ' ').replace(/\..+/, '') : null;
        params.params.endDate = params.params.endDate ? params.params.endDate.toISOString().replace(/T/, ' ').replace(/\..+/, '') : null;
        model.repoFind(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            helper.replyFind(err, data[0]);
        });
    };

    return self;
}

const handler = new astMonitoringHandler();
module.exports = handler;