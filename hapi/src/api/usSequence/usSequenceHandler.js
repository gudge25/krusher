/*jshint node:true*/
'use strict';
const BaseHandler = require('src/base/BaseHandler');
const model = require('./usSequenceModel');
const schema = require('./usSequenceSchema');
const ReplyHelper = require('src/base/reply-helper');

function usSequenceHandler() {
    const params = { model, schema };
    const self = new BaseHandler(params);
    self.findByID = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindOne);
        const params = request.plugins.createControllerParams(request.params, new schema().schemaFindPost());
        model.repoFindByID(params, (err, data) => {
            if (err) return helper.replyFindOne(err, null);
            helper.replyFindOne(err, data[0][0]);
        });
    };
    self.findPost = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.Find);
        const params = request.plugins.createControllerParams(request.payload, new schema().schemaFindPost());
        delete params.params.seqName;
        model.repoFind(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            helper.replyFind(err, data[0]);
        });
    };

    return self;
}

const handler = new usSequenceHandler();
module.exports = handler;