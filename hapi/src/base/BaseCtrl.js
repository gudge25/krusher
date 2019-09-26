/*jshint node:true, esnext:true*/
'use strict';
const Hapi = require('hapi');
const Q = require('q');
const _ = require('lodash');
const ReplyHelper = require('src/base/reply-helper');

class BaseCtrl {
  constructor(dao, model) {
    const self = {
      dao: dao,
      model: model
    };
    return {
      findByID: (request, reply) => {
        const helper = new ReplyHelper(request, reply, self.model.FindOne);
        const params = request.plugins.createControllerParams(request.params);
        self.dao.repoFindByID(params, (err, data) => {
          if (err) return helper.replyFindOne(err, null);
          helper.replyFindOne(null, data[0][0]);
        });
      },
      find: (request, reply) => {
        const helper = new ReplyHelper(request, reply, self.model.Find);
        const params = request.plugins.createControllerParams(request.params);
        self.dao.repoFind(params, (err, data) => {
          if (err) return helper.replyFind(err, null);
          helper.replyFind(err, data[0]);
        });
      },
      insert: (request, reply) => {
        const helper = new ReplyHelper(request, reply);
        const p = request.plugins.createControllerParams(request.payload);
        const data = new self.model.Insert(p.params);
        const params = {
          params: data,
          loginName : p.loginName
        };
        self.dao.repoInsert(params, (err, data) => {
          helper.replyInsert(err, data);
        });
      },
      update: (request, reply) => {
        const helper = new ReplyHelper(request, reply);
        const p = request.plugins.createControllerParams(request.payload);
        const data = new self.model.Update(p.params);
        const params = {
          params: data,
          loginName : p.loginName
        };
        self.dao.repoUpdate(params, (err, data) => {
          helper.replyUpdate(err, data);
        });
      },
      delete: (request, reply) => {
        const helper = new ReplyHelper(request, reply);
        const params = request.plugins.createControllerParams(request.params);
        self.dao.repoDelete(params, (err, data) => {
          helper.replyDelete(err, data);
        });
      },
      lookup: (request, reply) => {
        const helper = new ReplyHelper(request, reply, self.model.Lookup);
        const params = request.plugins.createControllerParams(request.params);
        self.dao.repoLookup(params, (err, data) => {
          if (err) return helper.replyFind(err, null);
          helper.replyFind(err, data[0]);
        });
      },
    };
  }
}

module.exports = BaseCtrl;
