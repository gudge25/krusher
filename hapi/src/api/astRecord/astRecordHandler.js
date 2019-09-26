/*jshint node:true*/
'use strict';
const BaseHandler = require('src/base/BaseHandler');
const model = require('./astRecordModel');
const schema = require('./astRecordSchema');
const moment = require('moment');
const ReplyHelper = require('src/base/reply-helper');
const path = require('path');
const fs = require('fs');
const Boom = require('boom');

function astRecordHandler() {
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
    self.insertForce = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.InsertForce);
        const params = request.plugins.createControllerParams(request.payload,  new schema().schemaInsertF());
        params.params.record_name = params.params.record_source;
        params.params.isActive = 1;

        model.repoInsertForce(params, (err, data) => {
            if (err) return helper.replyInsert(err, null);
            helper.replyInsert(err, data[0]);
        });
    };
    self.insert = (request, reply) =>
    {
        const helper = new ReplyHelper(request, reply, model.Insert);
        const loginName = request.auth.credentials.loginName;
        const token = request.auth.credentials.Token;
        const data = request.payload;

        function end(err){
            if (err)
                return cb(err);
            else
            {
                const params = {
                    params: {
                        token: token,
                        record_name: data.record_name,
                        record_source: filename,
                        isActive: data.isActive
                    },
                    loginName: loginName,
                    token: token
                };
                model.repoInsert(params, (err, data) => {
                    if (err) return helper.replyInsert(err, null);
                    helper.replyInsert(err, data);
                });
            }
        }

        function cb(err, data) {
            if (err) return reply(Boom.conflict(err));
            return reply("File uploaded");
        }

        if (data.file)
        {
            var datename = moment().format('YYYYMMDDTHHmmss');
            const ext = path.extname(data.file.hapi.filename);
            var filename = `${loginName}${datename}${ext}`;
            if (ext != '.wav' && ext != '.mp3' && ext != '.gsm')
                return cb(`Format "${ext}" is not supported`);
            const uploads = `uploads`;
            const voiceuploads = `uploads/records`;
            fs.exists(uploads, exists => {
                if (exists === false)
                    fs.mkdirSync(uploads);
                fs.exists(voiceuploads, exists => {
                    if (exists === false)
                        fs.mkdirSync(voiceuploads);

                });
            });
            var filepath    = `${voiceuploads}/${filename}`;
            var file        = fs.createWriteStream(filepath);
            file.on('error', err => cb(err) );

            data.file.pipe(file);
            //file.close(end);

            data.file.on('end', err => {
              if (err) return cb(err);
              end(err);
            });
        }
    };
    self.update = (request, reply) => {
        const helper = new ReplyHelper(request, reply, model.FindPost);
        const params = request.plugins.createControllerParams(request.payload, new schema().schema);

        model.repoUpdate(params, (err, data) => {
            if (err) return helper.replyUpdate(err, null);
            helper.replyUpdate(err, data[0]);
        });
    };

    return self;
}

const handler = new astRecordHandler();
module.exports = handler;


