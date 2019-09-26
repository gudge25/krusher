/*jshint node:true*/
'use strict';
const BaseHandler = require('src/base/BaseHandler');
const model = require('./ccContactModel');
const schema = require('./ccContactSchema');
const ReplyHelper = require('src/base/reply-helper');
const Jsn = require('json2xlsx');
const fs = require('fs');
const _ = require('lodash');

function ccContactHandler() {
    const params = { model, schema };
    const self = new BaseHandler(params);
    self.find = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.Find);
        const p = request.plugins.createControllerParams(request.orig.payload, new schema().schemaFind());
        p.params.DateFrom = p.params.DateFrom ? p.params.DateFrom.replace(/T/, ' ').replace(/\..+/, '') : null;
        p.params.DateTo = p.params.DateTo ? p.params.DateTo.replace(/T/, ' ').replace(/\..+/, '') : null;
        const data = new model.FindIn(p.params);
        const params = {
            params: data,
            loginName: p.loginName
        };
        model.repoFind(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            const params = { qty : data[1][0].Qty, qtyVoiceMin : data[1][0].qtyVoiceMin, avgVoiceMin : data[1][0].avgVoiceMin, avgWaitMin : data[1][0].avgWaitMin, avgBillMin : data[1][0].avgBillMin, avgHoldMin : data[1][0].avgHoldMin  };
            helper.replyFind(err, data[0], params);
        });
    };
    self.fileExportRecords = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.InsList);
        const p = request.plugins.createControllerParams(request.orig.payload, new schema().schemaFindRecords());
        p.params.DateFrom = p.params.DateFrom ? p.params.DateFrom.replace(/T/, ' ').replace(/\..+/, '') : null;
        p.params.DateTo = p.params.DateTo ? p.params.DateTo.replace(/T/, ' ').replace(/\..+/, '') : null;
        p.params.emID = p.emIDEditor;
        const data = new model.FindInExportRecord(p.params);
        const params = {
            params: data,
            loginName: p.loginName
        };
        model.repoFindRecords(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            helper.replyInsert(null, data[0]);
        });
    };
    self.fileExportRecordsList = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.RecordExportList);
        const p = request.plugins.createControllerParams(request.orig.payload, new schema().schemaRecordsList());
        p.params.DateFrom = p.params.DateFrom ? p.params.DateFrom.replace(/T/, ' ').replace(/\..+/, '') : null;
        p.params.DateTo = p.params.DateTo ? p.params.DateTo.replace(/T/, ' ').replace(/\..+/, '') : null;
        const data = new model.FindInList(p.params);
        const params = {
            params: data,
            loginName: p.loginName
        };
        model.repoFindRecordsList(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            helper.replyFind(err, data[0]);
        });
    };
    self.deleteExportRecords = (request, reply) => {
        const helper = new ReplyHelper(request, reply);
        const params = request.plugins.createControllerParams(request.params);
        model.repoDeleteExportRecords(params, (err, data) => {
            if (err) return helper.replyDelete(err, null);
            helper.replyDelete(err, data);
        });
    };
    self.getMissed = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.getMissed);
        const params = request.plugins.createControllerParams(request.orig.payload, new schema().schemaGetMissed());
        params.params.DateFrom = params.params.DateFrom ? params.params.DateFrom.replace(/T/, ' ').replace(/\..+/, '') : null;
        model.repogetMissed(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            helper.replyFind(err, data[0]);
        });
    };
    self.fileExport = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FileExport);
        const p = request.plugins.createControllerParams(request.orig.payload, new schema().schemaFindExport());
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
                        Jsn.write(fileName, 'Calling card', o);
                        return reply.file(fileName);
                    } catch (err) {
                        return helper.replyFind(err, null);
                    }
                } else {
                    fs.unlink(fileName, err => {
                        if (err) return helper.replyFind(err, null);
                        Jsn.write(fileName, 'Calling card', o);
                        reply.file(fileName, {
                            filename : 'export.xlsx',
                            mode: 'attachment'
                        });
                    });
                }
            });
        });
    };
    //forSIP не вставлен Aid, ибо хрен ясно что там происходит
    self.forSip = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.ForSip);
        const params = request.plugins.createControllerParams(request.params);
        model.repoForSip(params, (err, data) => {
            if (err) return helper.replyFindOne(err, null);
            helper.replyFindOne(null, data[0][0]);
        });
    };
    self.billReport = (request, reply) => {
        const helper = new ReplyHelper(request, reply);
        const params = request.plugins.createControllerParams(request.params);
        params.params.dateTo = params.params.dateTo ? params.params.dateTo.replace(/T/, ' ').replace(/\..+/, '') : null;
        model.repoBillReport(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            const o = {
                inb : data[0],
                ob: data[1]
            };
            const fileName = 'uploads/export.xlsx';
            fs.exists('uploads', (exists) => {
                if (exists === false) {
                    fs.mkdirSync('uploads');
                }
            });
            fs.stat(fileName, (err, stats) => {
                if (err) {
                    try {
                        Jsn.write(fileName, undefined, o);
                        return reply.file(fileName);
                    }
                    catch (err) {
                        return helper.replyFind(err, null);
                    }
                }
                else {
                    fs.unlink(fileName, (err) => {
                        if (err) {
                            return helper.replyFind(err, null);
                        }
                        Jsn.write(fileName, undefined, o);
                        reply.file(fileName);
                    });
                }
            });
        });
    };
    self.getDashboard = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.Dashboard);
        const params = request.plugins.createControllerParams(request.request);
        model.repoGetDashboard(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            helper.replyFind(err, data[0]);
        });
    };
    self.CallerManager = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.CallerManager);
        const params = request.plugins.createControllerParams(request.params);
        model.repoCallerManager(params, (err, data) => {
            if (err) return helper.replyFindOne(err, null);
            if (typeof data[0] !== "undefined")
                helper.replyFindOne(null, data[0][0]);
            else
                helper.replyFindOne(null, []);
        });
    };
    self.dailyHour = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.dailyHour);
        const p = request.plugins.createControllerParams(request.orig.payload, new schema().schemadailyHour());
        p.params.DateFrom = p.params.DateFrom ? p.params.DateFrom.replace(/T/, ' ').replace(/\..+/, '') : null;
        p.params.DateTo = p.params.DateTo ? p.params.DateTo.replace(/T/, ' ').replace(/\..+/, '') : null;
        const data = new model.dailyHourIn(p.params);
        const params = {
            params: data,
            loginName: p.loginName
        };
        model.repodailyHour(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            const params = { CallsCount : data[1][0].CallsCount
                            , ReceivedBefore20sec : data[1][0].ReceivedBefore20sec
                            , ReceivedBefore20secPercent : data[1][0].ReceivedBefore20secPercent
                            , ReceivedBefore30sec : data[1][0].ReceivedBefore30sec
                            , ReceivedBefore30secPercent : data[1][0].ReceivedBefore30secPercent
                            , ReceivedBefore60sec : data[1][0].ReceivedBefore60sec
                            , ReceivedBefore60secPercent : data[1][0].ReceivedBefore60secPercent
                            , ReceivedAfter60sec : data[1][0].ReceivedAfter60sec
                            , ReceivedAfter60secPercent : data[1][0].ReceivedAfter60secPercent
                            , ReceivedCalls : data[1][0].ReceivedCalls
                            , LostBefore20sec : data[1][0].LostBefore20sec
                            , LostBefore20secPercent : data[1][0].LostBefore20secPercent
                            , LostBefore30sec : data[1][0].LostBefore30sec
                            , LostBefore30secPercent : data[1][0].LostBefore30secPercent
                            , LostBefore60sec : data[1][0].LostBefore60sec
                            , LostBefore60secPercent : data[1][0].LostBefore60secPercent
                            , LostAfter60sec : data[1][0].LostAfter60sec
                            , LostAfter60secPercent : data[1][0].LostAfter60secPercent
                            , LostCalls : data[1][0].LostCalls
                            , AHT : data[1][0].AHT
                            , SL : data[1][0].SL
                            , LCR : data[1][0].LCR
                            , ATT : data[1][0].ATT
            };
            helper.replyFind(err, data[0], params);
        });
    };
    self.dailyHourExport = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.dailyHour);
        const p = request.plugins.createControllerParams(request.orig.payload, new schema().schemadailyHour());
        p.params.DateFrom = p.params.DateFrom ? p.params.DateFrom.replace(/T/, ' ').replace(/\..+/, '') : null;
        p.params.DateTo = p.params.DateTo ? p.params.DateTo.replace(/T/, ' ').replace(/\..+/, '') : null;
        const data = new model.dailyHourIn(p.params);
        const params = {
            params: data,
            loginName: p.loginName
        };
        model.repodailyHourExport(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            const o = _(data[0])
                .groupBy(x => 'Report')
                .value();
            const fileName = 'uploads/exportDailyHour.xlsx';
            fs.stat(fileName, (err, stats) => {
                if (err) {
                    try {
                        Jsn.write(fileName, 'Data', o);
                        return reply.file(fileName);
                    } catch (err) {
                        return helper.replyFind(err, null);
                    }
                } else {
                    fs.unlink(fileName, err => {
                        if (err) return helper.replyFind(err, null);
                        Jsn.write(fileName, 'Data', o);
                        reply.file(fileName, {
                            filename : 'exportDailyHour.xlsx',
                            mode: 'attachment'
                        });
                    });
                }
            });
        });
    };
    self.dailyCalls = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.dailyCalls);
        const p = request.plugins.createControllerParams(request.orig.payload, new schema().schemadailyCalls());
        p.params.DateFrom = p.params.DateFrom ? p.params.DateFrom.replace(/T/, ' ').replace(/\..+/, '') : null;
        p.params.DateTo = p.params.DateTo ? p.params.DateTo.replace(/T/, ' ').replace(/\..+/, '') : null;
        const data = new model.dailyCallsIn(p.params);
        const params = {
            params: data,
            loginName: p.loginName
        };
        model.repodailyCalls(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            const params = { Qty : data[1][0].Qty };
            helper.replyFind(err, data[0], params);
        });
    };
    self.dailyCallsExport = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.dailyCalls);
        const p = request.plugins.createControllerParams(request.orig.payload, new schema().schemadailyCalls());
        p.params.DateFrom = p.params.DateFrom ? p.params.DateFrom.replace(/T/, ' ').replace(/\..+/, '') : null;
        p.params.DateTo = p.params.DateTo ? p.params.DateTo.replace(/T/, ' ').replace(/\..+/, '') : null;
        const data = new model.dailyCallsIn(p.params);
        const params = {
            params: data,
            loginName: p.loginName
        };
        model.repodailyCallsExport(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            const o = _(data[0])
                .groupBy(x => 'Report')
                .value();
            const fileName = 'uploads/exportDailyCalls.xlsx';
            fs.stat(fileName, (err, stats) => {
                if (err) {
                    try {
                        Jsn.write(fileName, 'Data', o);
                        return reply.file(fileName);
                    } catch (err) {
                        return helper.replyFind(err, null);
                    }
                } else {
                    fs.unlink(fileName, err => {
                        if (err) return helper.replyFind(err, null);
                        Jsn.write(fileName, 'Data', o);
                        reply.file(fileName, {
                            filename : 'exportDailyCalls.xlsx',
                            mode: 'attachment'
                        });
                    });
                }
            });
        });
    };
    self.dailyStatuses = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.dailyStatuses);
        const p = request.plugins.createControllerParams(request.orig.payload, new schema().schemadailyStatuses());
        p.params.DateFrom = p.params.DateFrom ? p.params.DateFrom.replace(/T/, ' ').replace(/\..+/, '') : null;
        p.params.DateTo = p.params.DateTo ? p.params.DateTo.replace(/T/, ' ').replace(/\..+/, '') : null;
        const data = new model.dailyStatusesIn(p.params);
        const params = {
            params: data,
            loginName: p.loginName
        };
        model.repodailyStatuses(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            /*const params = { Qty : data[1][0].Qty };*/
            helper.replyFind(err, data[0]);
        });
    };
    self.dailyStatusesExport = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.dailyStatuses);
        const p = request.plugins.createControllerParams(request.orig.payload, new schema().schemadailyStatuses());
        p.params.DateFrom = p.params.DateFrom ? p.params.DateFrom.replace(/T/, ' ').replace(/\..+/, '') : null;
        p.params.DateTo = p.params.DateTo ? p.params.DateTo.replace(/T/, ' ').replace(/\..+/, '') : null;
        const data = new model.dailyStatusesIn(p.params);
        const params = {
            params: data,
            loginName: p.loginName
        };
        model.repodailyStatusesExport(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            const o = _(data[0])
                .groupBy(x => 'Report')
                .value();
            const fileName = 'uploads/exportDailyStatuses.xlsx';
            fs.stat(fileName, (err, stats) => {
                if (err) {
                    try {
                        Jsn.write(fileName, 'Data', o);
                        return reply.file(fileName);
                    } catch (err) {
                        return helper.replyFind(err, null);
                    }
                } else {
                    fs.unlink(fileName, err => {
                        if (err) return helper.replyFind(err, null);
                        Jsn.write(fileName, 'Data', o);
                        reply.file(fileName, {
                            filename : 'exportDailyStatuses.xlsx',
                            mode: 'attachment'
                        });
                    });
                }
            });
        });
    };
    self.dailyReport = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.dailyReport);
        const p = request.plugins.createControllerParams(request.orig.payload, new schema().schemadailyReport());
        p.params.DateFrom = p.params.DateFrom ? p.params.DateFrom.replace(/T/, ' ').replace(/\..+/, '') : null;
        p.params.DateTo = p.params.DateTo ? p.params.DateTo.replace(/T/, ' ').replace(/\..+/, '') : null;
        const data = new model.dailyReportIn(p.params);
        const params = {
            params: data,
            loginName: p.loginName
        };
        model.repodailyReport(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            const params = { CallsCount : data[1][0].CallsCount
                , LostBefore5sec : data[1][0].LostBefore5sec
                , LostBefore5secPercent : data[1][0].LostBefore5secPercent
                , LostBefore30sec : data[1][0].LostBefore30sec
                , LostBefore30secPercent : data[1][0].LostBefore30secPercent
                , LostAfter30sec : data[1][0].LostAfter30sec
                , LostAfter30secPercent : data[1][0].LostAfter30secPercent
                , ReceivedCalls : data[1][0].ReceivedCalls
                , ReceivedBefore20sec : data[1][0].ReceivedBefore20sec
                , ReceivedBefore20secPercent : data[1][0].ReceivedBefore20secPercent
                , ReceivedBefore30sec : data[1][0].ReceivedBefore30sec
                , ReceivedBefore30secPercent : data[1][0].ReceivedBefore30secPercent
                , ReceivedAfter30sec : data[1][0].ReceivedAfter30sec
                , ReceivedAfter30secPercent : data[1][0].ReceivedAfter30secPercent
                , LostCalls : data[1][0].LostCalls
                , AHT : data[1][0].AHT
                , SL : data[1][0].SL
                , LCR : data[1][0].LCR
                , ATT : data[1][0].ATT
                , HT : data[1][0].HT
                , Recalls : data[1][0].Recalls
                , RLCR : data[1][0].RLCR
            };
            helper.replyFind(err, data[0], params);
        });
    };
    self.dailyReportExport = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.dailyReport);
        const p = request.plugins.createControllerParams(request.orig.payload, new schema().schemadailyReport());
        p.params.DateFrom = p.params.DateFrom ? p.params.DateFrom.replace(/T/, ' ').replace(/\..+/, '') : null;
        p.params.DateTo = p.params.DateTo ? p.params.DateTo.replace(/T/, ' ').replace(/\..+/, '') : null;
        const data = new model.dailyReportIn(p.params);
        const params = {
            params: data,
            loginName: p.loginName
        };
        model.repodailyReportExport(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            const o = _(data[0])
                .groupBy(x => 'Report')
                .value();
            const fileName = 'uploads/exportDailyReport.xlsx';
            fs.stat(fileName, (err, stats) => {
                if (err) {
                    try {
                        Jsn.write(fileName, 'Data', o);
                        return reply.file(fileName);
                    } catch (err) {
                        return helper.replyFind(err, null);
                    }
                } else {
                    fs.unlink(fileName, err => {
                        if (err) return helper.replyFind(err, null);
                        Jsn.write(fileName, 'Data', o);
                        reply.file(fileName, {
                            filename : 'exportDailyReport.xlsx',
                            mode: 'attachment'
                        });
                    });
                }
            });
        });
    };
    self.update = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.Update);
        const p = request.plugins.createControllerParams(request.payload, new schema().schemaUpdate());
        const data = new model.Update(p.params);
        const params = {
            params: data,
            loginName: p.loginName
        };
        model.repoUpdate(params, (err, data) => {
            if (err) return helper.replyUpdate(err, null);
            helper.replyUpdate(err, data);
        });
    };
    self.insert = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.Insert);
        const p = request.plugins.createControllerParams(request.payload, new schema().schemaInsert());
        const data = new model.Insert(p.params);
        const params = {
            params: data,
            loginName: p.loginName
        };
        model.repoInsert(params, (err, data) => {
            if (err) return helper.replyInsert(err, null);
            const events = request.server.events;
            events.emit('create', {
                event: 'create-contact',
                data: data
            });
            helper.replyInsert(null, data);
        });
    };

    return self;
}

const handler = new ccContactHandler();
module.exports = handler;

