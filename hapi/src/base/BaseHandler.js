/*jshint node:true, esnext:true*/
'use strict';
const ReplyHelper = require('src/base/reply-helper');

function BaseHandler(params) {
    const model = params.model;
    const schema = params.schema;
    const handlers = {
        findByID: (request, reply) => {
            const helper = new ReplyHelper(request, reply, model.FindOne);
            const params = request.plugins.createControllerParams(request.params);
            model.repoFindByID(params, (err, data) => {
                if (err) return helper.replyFindOne(err, null);
                helper.replyFindOne(null, data[0][0]);
            });
        },
        find: (request, reply) => {
            const helper = new ReplyHelper(request, reply, model.Find);
            const params = request.plugins.createControllerParams(request.params);
            model.repoFind(params, (err, data) => {
                if (err) return helper.replyFind(err, null);
                helper.replyFind(err, data[0]);
            });
        },
        findPost: (request, reply) => {
            const helper = new ReplyHelper(request, reply, model.FindPost);
            const params = request.plugins.createControllerParams(request.params, new schema().schemaFindPost());
            model.repoFind(params, (err, data) => {
                if (err) return helper.replyFind(err, null);
                const params = { qty : data[1][0].Qty };
                helper.replyFind(err, data[0], params);
            });
        },
        insert: (request, reply) => {
            const helper = new ReplyHelper(request, reply);
            const p = request.plugins.createControllerParams(request.payload, new schema().schema);
            //const data = new model.Insert(p.params);
            const params = {
                params: p.params,
                loginName: p.loginName,
                token: p.token
            };
            model.repoInsert(params, (err, data) => {
                helper.replyInsert(err, data);
            });
        },
        update: (request, reply) => {
            const helper = new ReplyHelper(request, reply, model);
            var z = request.plugins.createControllerParams(request.params);
            const params = request.plugins.createControllerParams(request.payload, new schema().schema);
            for (var key in z.params)
                params.params[key] = z.params[key];
            model.repoUpdate(params, (err, data) => {
                if (err) return helper.replyUpdate(err, null);
                helper.replyUpdate(err, data);
            });
        },
        delete: (request, reply) => {
            const helper = new ReplyHelper(request, reply);
            const params = request.plugins.createControllerParams(request.params);
            model.repoDelete(params, (err, data) => {
                helper.replyDelete(err, data);
            });
        },
        lookup: (request, reply) => {
            const helper = new ReplyHelper(request, reply, model.Lookup);
            const params = request.plugins.createControllerParams(request.params);
            model.repoLookup(params, (err, data) => {
                if (err) return helper.replyFind(err, null);
                helper.replyFind(err, data[0]);
            });
        }
    };

    return handlers
}

module.exports = BaseHandler;
