/*jshint node:true*/
'use strict';
const BaseHandler = require('src/base/BaseHandler');
const model = require('./emEmployModel');
const schema = require('./emEmploySchema');
const ReplyHelper = require('src/base/reply-helper');
const _ = require('lodash');
const Jsn = require('json2xlsx');
const fs = require('fs');

function emEmployHandler() {
    const params = { model, schema };
    const self = new BaseHandler(params);
    self.findPost = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindPost);
        const p = request.plugins.createControllerParams(request.payload, new schema().schemaFindPost());
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
    self.stat = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.Stat);
        const p = request.plugins.createControllerParams(request.orig.payload, new schema().schemaStat());
        p.params.DateFrom = p.params.DateFrom.replace(/T/, ' ').replace(/\..+/, '');
        p.params.DateTo = p.params.DateTo.replace(/T/, ' ').replace(/\..+/, '');
        const data = new model.StatIn(p.params);
        const params = {
            params: data,
            loginName: p.loginName
        };
        model.repoStat(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            helper.replyFind(err, data[0]);
        });
    };
    self.counter = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.Counter);
        const p = request.plugins.createControllerParams(request.orig.payload, new schema().schemaCounter());
        p.params.DateFrom = p.params.DateFrom.replace(/T/, ' ').replace(/\..+/, '');
        p.params.DateTo = p.params.DateTo.replace(/T/, ' ').replace(/\..+/, '');
        const data = new model.CounterIn(p.params);
        const params = {
            params: data,
            loginName: p.loginName
        };
        model.repoCounter(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            const params = { qty : data[1][0].Qty };
            helper.replyFind(err, data[0], params);
        });
    };
    self.insert = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.Insert);
        const p = request.plugins.createControllerParams(request.payload, new schema().schemaInsert());
        p.params.emIDEditor = p.emIDEditor;
        p.params.host = p.host;
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
    self.update = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.Update);
        const p = request.plugins.createControllerParams(request.payload);
        p.params.emIDEditor = p.emIDEditor;
        p.params.host = p.host;
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
    self.updateStatus = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.UpdateStatus);
        const p = request.plugins.createControllerParams(request.payload, new schema().schemaUpdateStatus());
        p.params.emIDEditor = p.emIDEditor;
        p.params.host = p.host;
        const data = new model.UpdateStatus(p.params);
        const params = {
            params: data,
            loginName: p.loginName,
            token: p.token
        };
        model.repoUpdateStatus(params, (err, data) => {
            if (err) return helper.replyUpdate(err, null);
            helper.replyUpdate(err, data[0]);
        });
    };
    self.reportCalls = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.ReportCalls);
        const params = request.plugins.createControllerParams(request.payload, new schema().schemaCalls());
        model.repoReportCalls(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            helper.replyFind(err, data[0]);
        });
    };
    self.reportStatus = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.ReportStatus);
        const params = request.plugins.createControllerParams(request.payload, new schema().schemaStatus());
        model.repoReportStatus(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            helper.replyFind(err, data[0]);
        });
    };
    self.private = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.Private);
        const params = request.plugins.createControllerParams(request.params);
        params.params.url = request.info.host;
        params.params.loginName = params.loginName;
        model.repoPrivate(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            helper.replyFind(err, data[0]);
        });
    };
    self.delete = (request, reply) => {
        const helper = new ReplyHelper(request, reply);
        const p = request.plugins.createControllerParams(request.params);
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
    self.fileExport = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FileExport);
        const p = request.plugins.createControllerParams(request.orig.payload, new schema().schemaStat());
        p.params.DateFrom = p.params.DateFrom ? p.params.DateFrom.replace(/T/, ' ').replace(/\..+/, '') : null;
        p.params.DateTo = p.params.DateTo ? p.params.DateTo.replace(/T/, ' ').replace(/\..+/, '') : null;
        const data = new model.FileExportIn(p.params);
        const params = {
            params: data,
            loginName: p.loginName
        };
        model.repoFileExport(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            const o = _(data[0])
                .groupBy(x => 'Report')
                .value();
            const fileName = 'uploads/export.xlsx';
            fs.stat(fileName, (err, stats) => {
                if (err) {
                    try {
                        Jsn.write(fileName, 'Stat', o);
                        return reply.file(fileName);
                    } catch (err) {
                        return helper.replyFind(err, null);
                    }
                } else {
                    fs.unlink(fileName, err => {
                        if (err) return helper.replyFind(err, null);
                        Jsn.write(fileName, 'Stat', o);
                        reply.file(fileName, {
                            filename : 'export.xlsx',
                            mode: 'attachment'
                        });
                    });
                }
            });
        });
    };

    return self;
}

const handler = new emEmployHandler();
module.exports = handler;