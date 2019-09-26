/*jshint node:true*/
'use strict';
const BaseHandler = require('src/base/BaseHandler');
const model = require('./fmFormModel');
const schema = require('./fmFormSchema');
const ReplyHelper = require('src/base/reply-helper');
const json2xlsx = require('json2xlsx');
const fs = require('fs');

function fmFormHandler() {
    const params = { model, schema };
    const self = new BaseHandler(params);
    self.findPost = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindPost);
        const params = request.plugins.createControllerParams(request.payload, new schema().schemaFindPost());
        params.params.dcDate = params.params.dcDate ? params.params.dcDate.replace(/T/, ' ').replace(/\..+/, '') : null;
        model.repoFind(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            const params = { qty : data[1][0].Qty };
            helper.replyFind(err, data[0], params);
        });
    };
    self.formExport = (request, reply) => {
        const helper = new ReplyHelper(request, reply);
        const params = request.plugins.createControllerParams(request.orig.payload, new schema().schemaExport());
        params.params.DateFrom = params.params.DateFrom ? params.params.DateFrom.replace(/T/, ' ').replace(/\..+/, '') : null;
        params.params.DateTo = params.params.DateTo ? params.params.DateTo.replace(/T/, ' ').replace(/\..+/, '') : null;
        model.repoFormExport(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            const o = {
                WorkList : data[0]
            };
            const fileName = 'uploads/export.xlsx';
            fs.stat(fileName, (err, stats) => {
                if (err) {
                    try {
                        json2xlsx.write(fileName, undefined, o);
                        return reply.file(fileName);
                    } catch (err) {
                        return helper.replyFind(err, null);
                    }
                } else {
                    fs.unlink(fileName, err => {
                        if (err) return helper.replyFind(err, null);
                        json2xlsx.write(fileName, undefined, o);
                        reply.file(fileName);
                    });
                }
            });
        });
    };
    self.insert = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindPost);
        const p = request.plugins.createControllerParams(request.payload, new schema().schemaInsert());
        p.params.dcDate = p.params.dcDate ? p.params.dcDate.replace(/T/, ' ').replace(/\..+/, '') : null;
        const params = {
            params: p.params,
            loginName: p.loginName,
            token: p.token
        };
        model.repoInsert(params, (err, data) => {
            if (err) return helper.replyInsert(err, null);
            helper.replyInsert(err, data[0]);
        });
    };
    self.update = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.Update);
        const p = request.plugins.createControllerParams(request.payload, new schema().schemaUpdate());
        p.params.dcDate = p.params.dcDate ? p.params.dcDate.replace(/T/, ' ').replace(/\..+/, '') : null;
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

    return self;
}

const handler = new fmFormHandler();
module.exports = handler;
