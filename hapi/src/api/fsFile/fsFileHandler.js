/*jshint node:true*/
'use strict';
const BaseHandler = require('src/base/BaseHandler');
const model = require('./fsFileModel');
const schema = require('./fsFileSchema');
const ReplyHelper = require('src/base/reply-helper');
const fs = require('fs');
const path = require('path');
const _ = require('lodash');
const json2xlsx = require('json2xlsx');
const xlsx = require('node-xlsx');
const Boom = require('boom');

var internals = {};

internals.toCsv = function (params, cb) {
    if (fs.existsSync(params.filepath)) {
        fs.chmodSync(`${params.filepath}`, '0755');
        var obj = xlsx.parse(params.filepath); // parses a file
        var rows = [];
        var writeStr = "";
        let sheetData, line;
        //looping through all sheets
        for (let i = 0; i < obj.length; i++) {
            let sheet = obj[i];
            //loop through all rows in the sheet
            //BUG if  for (let j = 1; it is remove first headers or line
            for (let j = 0; j < sheet.data.length; j++) {
                sheetData = sheet.data[j];
                line = [];
                _.forEach(sheetData, value => {
                    line.push(value ? `~${value}~` : '');
                });
                //add the row to the rows array
                rows.push(line);
            }
        }

        //creates the csv string to write it to a file
        for (let e = 0; e < rows.length; e++) {
            writeStr += rows[e].join(",") + "\n";
        }

        //writes to a file, but you will presumably send the csv as a
        //response instead
        fs.writeFile(`${params.uploads}/result.csv`, writeStr, (err, result) => {
            if(err) console.log('error1', err);
            if (err) return cb(err);
            fs.unlink(params.filepath, (err, result) => { if(err) console.log('error2', err); } );
            return cb(null, params);
        });

    }
    else
        return cb(`FILE NOT EXIST ${params.filepath}`);
};

internals.repoInsert = function (err, params) {
    const cb = params.cb;
    if (err) return cb(err);
    const data = params.data;
    if(typeof data.isRobocall === 'undefined')
        data.isRobocall = 0; //временное реение
    const repoParams = {
        params: {
            token: params.token,
            ftID: data.ftID,
            ffID: data.ffID,
            ffPath: params.ffPath,
            ffName: params.filename,
            dbID: data.dbID
        },
        loginName: params.loginName,
        token:      params.token,
        isRobocall: data.isRobocall
    };
    //Return if  pre finish SQL
    cb(null, "ok!");
    model.repoInsert(repoParams, (err, data) => {
        if (err) console.log(err); //return cb(err.message);
        //Return if finish SQL
        //return cb(null, "ok!");
    });
};

function fsFileHandler() {
    const params = { model, schema };
    const self = new BaseHandler(params);

    self.findPost = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindPost);
        const params = request.plugins.createControllerParams(request.payload, new schema().schemaFindPost());
        model.repoFind(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            const params = { qty : data[1][0].Qty };
            helper.replyFind(err, data[0], params);
        });
    };
    self.findByID = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindOne);
        const params = request.plugins.createControllerParams(request.params);
        model.repoFindByID(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            if(data[0].length == 0 || (data[0].length == 1 && data[0][0].Qty == 0))
                helper.replyFind(err, []);
            else
                helper.replyFind(err, data[0]);
        });
    };
    self.detail = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.GetDetail);
        const params = request.plugins.createControllerParams(request.payload, new schema().schemaDetail());
        model.repoDetail(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            helper.replyFind(err, data[0]);
        });
    };
    self.updStatus = (request, reply) => {
        const helper = new ReplyHelper(request, reply);
        const params = request.plugins.createControllerParams(request.params);
        model.repoUpdStatus(params, (err, data) => {
            if (err) return helper.replyUpdate(err, null);
            helper.replyUpdate(null, data);
        });
    };
    self.fileExport = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FileExport);
        const params = request.plugins.createControllerParams(request.params);
        model.repoFileExport(params, (err, data) => {
            if (err) return helper.replyFind(err, null);
            const o = _(data[0])
                .groupBy(x => 'Report')
                .value();
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
                        reply.file(fileName, {
                            filename : `${params.params.ffID}.xlsx`,
                            mode: 'attachment'
                        });
                    });
                }
            });
        });
    };
    self.insert = (request, reply) => {
        const loginName = request.auth.credentials.loginName;
        const token = request.auth.credentials.Token;
        const data = request.payload;
        function cb (err, data) {
            if (err) return reply(Boom.conflict(err));
            return reply("ok!");
        }
        if (data.file) {
            const filename = data.file.hapi.filename;
            const ext = path.extname(filename);
            if (ext != '.csv' && ext != '.xlsx' && ext != '.xls') return cb(`Format "${ext}" is not supported`);
            const uploads = `uploads`;
            fs.exists(uploads, exists => {
                if (exists === false)
                    fs.mkdirSync(uploads);
            });
            var filepath = `${uploads}/${filename}`;
            var file = fs.createWriteStream(filepath);

            file.on('error', err => {
                return cb(err);
            });
            data.file.pipe(file);
            data.file.on('end', err => {
                if (err) return cb(err);
                const params = {
                    data,
                    filename,
                    filepath,
                    uploads,
                    loginName,
                    token,
                    cb
                };
                file.on('finish', () => {
                    if (ext == '.xlsx' || ext == '.xls') {
                        params.ffPath = path.join(__dirname, `../../../${uploads}/result.csv`).replace(/\\/g, "/");
                        params.enclosed = '~';
                        return internals.toCsv(params, internals.repoInsert);
                    } else {
                        params.ffPath = path.join(__dirname, `../../../${uploads}/${filename}`).replace(/\\/g, "/");
                        params.enclosed = '"';
                        return internals.repoInsert(null, params);
                    }
                });
            });
        }
    };
    self.insertForce = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.InsertForce);
        const p = request.plugins.createControllerParams(request.payload, new schema().schemaInsertForce());
        const params = {
            params: p.params,
            loginName: p.loginName,
            token: p.token
        };
        model.repoInsertForce(params, (err, data) => {
            if (err) return helper.replyInsert(err, null);
            helper.replyInsert(err, data);
        });
    };
    self.update = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindPost);
        const params = request.plugins.createControllerParams(request.payload, new schema().schema);

        model.repoUpdate(params, (err, data) => {
            if (err) return helper.replyUpdate(err, null);
            helper.replyUpdate(err, data[0]);
        });
    };
    self.bulkdel = (request, reply) => {
        const helper = new ReplyHelper(request, reply);
        const p = request.plugins.createControllerParams(request.params);
        p.params.emIDEditor = p.emIDEditor;
        p.params.host = p.host;
        const data = new model.ClearDel(p.params);
        const params = {
            params: data,
            loginName: p.loginName,
            token: p.token
        };
        model.repoBulkDelete(params, (err, data) => {
            helper.replyDelete(err, data);
        });
    };

    return self;
}

const handler = new fsFileHandler();
module.exports = handler;
