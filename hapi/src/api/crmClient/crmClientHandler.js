/*jshint node:true*/
'use strict';
const BaseHandler = require('src/base/BaseHandler');
const model = require('./crmClientModel');
const schema = require('./crmClientSchema');
const ReplyHelper = require('src/base/reply-helper');

function crmClientHandler() {
    const params = { model, schema };
    const self = new BaseHandler(params);
    self.findPost = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindPost);
        const p = request.plugins.createControllerParams(request.payload, new schema().schemaFindPost());
        p.params.CallDate = p.params.CallDate ? p.params.CallDate.toISOString().replace(/T/, ' ').replace(/\..+/, '') : null;
        p.params.CallDateTo = p.params.CallDateTo ? p.params.CallDateTo.toISOString().replace(/T/, ' ').replace(/\..+/, '') : null;
        const data = new model.FindPostIn(p.params);
        const params = {
            params: data,
            loginName: p.loginName
        };
        model.repoFind(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            const params = { qty : data[1][0].Qty };
            helper.replyFind(err, data[0], params);
        });
    };
    self.bulkdelete = (request, reply) => {
        const helper = new ReplyHelper(request, reply);
        const p = request.plugins.createControllerParams(request.payload, new schema().schemaBulkDelete());
        p.params.emIDEditor = p.emIDEditor;
        p.params.host = p.host;
        const data = new model.BulkDelete(p.params);
        const params = {
            params: data,
            loginName: p.loginName,
            token: p.token
        };
        model.repoBulkDelete(params, (err, data) => {
            helper.replyDelete(err, data);
        });
    };
    self.search = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.Search);
        const params = request.plugins.createControllerParams(request.payload, new schema().schemaSearch());
        model.repoSearch(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            const params = { qty : data[1][0].Qty };
            helper.replyFind(err, data[0], params);
        });
    };
    self.getByName = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.GetByName);
        const params = request.plugins.createControllerParams(request.params);
        model.repoGetByName(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            helper.replyFind(err, data[0]);
        });
    };
    self.findStream = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindStream);
        const params = request.plugins.createControllerParams(request.params);
        if (!params.params.emID) {
            params.params.emID = null;
        }
        model.repoFindStream(params, (err, data) => {
                if (err) return helper.replyFind(err, null);
                helper.replyFind(err, data[0]);
        });
    };
    self.getByContact = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.GetByContact);
        const params = request.plugins.createControllerParams(request.params);
        model.repoGetByContact(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            helper.replyFind(err, data[0]);
        });
    };
    self.getByPhone = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.GetByPhone);
        const params = request.plugins.createControllerParams(request.params);

        model.repoGetByPhone(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            helper.replyFind(err, data[0]);
        });
    };
    self.getIPClient = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.GetIPClient);
        const params = request.plugins.createControllerParams(request.params);
        model.repoGetIPClient(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            helper.replyFind(err, data[0]);
        });
    };
    self.findSum = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindSum);
        const params = request.plugins.createControllerParams(request.payload);
        model.repoFindSum(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            helper.replyFind(err, data[0]);
        });
    };
    self.findByParent = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindByParent);
        const params = request.plugins.createControllerParams(request.params);
        model.repoFindByParent(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            helper.replyFind(err, data[0]);
        });
    };
    self.setActual = (request, reply) => {
        const helper = new ReplyHelper(request, reply);
        const params = request.plugins.createControllerParams(request.payload);
        model.repoSetActual(params, (err, data) => {
            if (err) return helper.replyUpdate(err, null);
            helper.replyUpdate(err, data[0]);
        });
    };
    self.updSabd = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.updSabd);
        const params = request.plugins.createControllerParams(request.payload);
        params.params.callDate = params.params.callDate ? params.params.callDate.toISOString().replace(/T/, ' ').replace(/\..+/, '') : null;
        model.repoUpdSabd(params, (err, data) => {
            if (err) return helper.replyUpdate(err, null);
            helper.replyUpdate(err, data[0]);
        });
    };
    self.findSabd = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindSabd);
        const params = request.plugins.createControllerParams(request.params);
        model.repoFindSabd(params, (err, data) => {
            if (err) return helper.replyFindOne(err, null);
            helper.replyFindOne(err, data[0][0]);
        });
    };
    self.getSave = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.GetSave);
        const params = request.plugins.createControllerParams(request.params);
        model.repoGetSave(params, (err, data) => {
            if (err) return helper.replyFindOne(err, null);
            helper.replyFindOne(err, data[0][0]);
        });
    };
    self.insSave = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.InsSave);
        const p = request.plugins.createControllerParams(request.payload);
        p.params.emIDEditor = p.emIDEditor;
        p.params.host = p.host;
        const data = new model.InsSave(p.params);
        const params = {
            params: data,
            loginName: p.loginName
        };
        model.repoInsSave(params, (err, data) => {
            if (err) return helper.replyInsert(err, null);
            helper.replyInsert(err, data[0][0]);
        });
    };
    self.updSave = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.UpdSave);
        const p = request.plugins.createControllerParams(request.payload);
        p.params.emIDEditor = p.emIDEditor;
        p.params.host = p.host;
        const data = new model.UpdSave(p.params);
        const params = {
            params: data,
            loginName: p.loginName
        };
        model.repoUpdSave(params, (err, data) => {
            if (err) return helper.replyUpdate(err, null);
            helper.replyUpdate(err, data[0]);
        });
    };
    self.update = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.Update);
        const p = request.plugins.createControllerParams(request.payload);
        p.params.emIDEditor = p.emIDEditor;
        p.params.host = p.host;
        const data = new model.Update(p.params);
        const params = {
            params: data,
            loginName: p.loginName
        };
        model.repoUpdate(params, (err, data) => {
            if (err) return helper.replyUpdate(err, null);
            helper.replyUpdate(err, data[0]);
        });
    };
    self.insert = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.Insert);
        const p = request.plugins.createControllerParams(request.payload, new schema().schemaInsert());
        p.params.emIDEditor = p.emIDEditor;
        p.params.host = p.host;
        const params = {
            params: p.params,
            loginName: p.loginName,
            token: p.token
        };
        model.repoInsert(params, (err, data) => {
            if (err) return helper.replyInsert(err, null);
            helper.replyInsert(err, data);
        });
    };
    self.delete = (request, reply) => {
        const helper = new ReplyHelper(request, reply);
        const p = request.plugins.createControllerParams(request.payload);
        if(p.params.customDelete === undefined)
        {
            const r = request.plugins.createControllerParams(request.params);
            p.params.clID = r.params.clID;
            p.params.customDelete = true;
        }
        p.params.emIDEditor = p.emIDEditor;
        p.params.host = p.host;
        const params = {
            params: p.params,
            loginName: p.loginName,
            token: p.token
        };
        model.repoDelete(params, (err, data) => {
            if (err) return helper.replyDelete(err, null);
            helper.replyDelete(err, data);
        });
    };

    return self;
}

const handler = new crmClientHandler();
module.exports = handler;
