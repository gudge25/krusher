/*jshint node:true, esnext:true*/
'use strict';
const AbstractEntity = require('./AbstractEntity');
const toJSONLocal = require(`src/util/toJSONLocal`);
const Joi = require('joi');

module.exports = (function() {
  class Schema {
    constructor() {
      const schema = {
        /*HIID: Joi.number().integer().optional(),
        dcID: Joi.number().integer().optional(),
        dcNo: Joi.string().max(35).optional().allow(null),
        dcState: Joi.number().integer().optional(),
        dcDate: Joi.string().isoDate().optional(),
        dcLink: Joi.number().integer().optional().allow(null),
        dcComment: Joi.string().max(200).optional().allow(null),
        dcSum: Joi.number().precision(4).optional().allow(null),
        dcStatus: Joi.number().integer().optional().allow(null),
        clID: Joi.number().integer().optional(),
        emID: Joi.number().integer().optional(),
        isActive: Joi.boolean().optional().allow(null).description('Is this record Active?!')*/
          HIID: Joi.number().integer().optional().allow(null),
          dcID: Joi.number().integer().optional().allow(null),
          dcNo: Joi.string().max(35).optional().allow(null),
          dcState: Joi.number().integer().optional().allow(null),
          dcDate: Joi.string().isoDate().optional().allow(null),
          dcLink: Joi.number().integer().optional().allow(null),
          dcComment: Joi.string().max(200).optional().allow(null),
          dcSum: Joi.number().precision(4).optional().allow(null),
          dcStatus: Joi.number().integer().optional().allow(null),
          clID: Joi.number().integer().optional().allow(null),
          emID: Joi.number().integer().optional().allow(null),
          isActive: Joi.boolean().optional().allow(null).description('Is this record Active?!')
      };
      return schema;
    }
  }

  class Get extends AbstractEntity {
    constructor(p) {
      const data = {
        HIID: p.HIID,
        dcID: p.dcID,
        dcNo: p.dcNo,
        dcState: p.dcState,
        dcDate: p.dcDate ? toJSONLocal(p.dcDate) : undefined,
        dcLink: p.dcLink,
        dcLinkType: p.dcLinkType,
        dcLinkDate: p.dcLinkDate,
        dcLinkNo: p.dcLinkNo,
        dcComment: p.dcComment,
        dcSum: p.dcSum,
        dcStatus: p.dcStatus,
        dcStatusName: p.dcStatusName,
        crID: p.crID,
        dcRate: p.dcRate,
        clID: p.clID,
        clName: p.clName,
        emID: p.emID,
        emName: p.emName,
        pcID: p.pcID,
        uID: p.uID,
        Created: p.Created ? toJSONLocal(p.Created,true) : undefined,
        CreatedBy: p.CreatedBy,
        Changed: p.Changed ? toJSONLocal(p.Changed,true) : undefined,
        ChangedBy: p.ChangedBy,
        CreatedName: p.CreatedName,
        EditedName: p.EditedName
      };
      super(data);
    }
  }
  class Post extends AbstractEntity {
    constructor(p) {
      const data = {
        dcID: p.dcID,
        dcNo: p.dcNo,
        dcState: p.dcState,
        dcDate: p.dcDate,
        dcLink: p.dcLink,
        dcComment: p.dcComment,
        dcSum: p.dcSum,
        dcStatus: p.dcStatus,
        clID: p.clID,
        emID: p.emID,
      };
      super(data);
    }
  }
  class Put extends AbstractEntity {
    constructor(p) {
      const data = {
        HIID: p.HIID,
        dcID: p.dcID,
        dcNo: p.dcNo,
        dcState: p.dcState,
        dcDate: p.dcDate,
        dcLink: p.dcLink,
        dcComment: p.dcComment,
        dcSum: p.dcSum,
        dcStatus: p.dcStatus,
        clID: p.clID,
        emID: p.emID,
      };
      super(data);
    }
  }
  return {
    Get: Get,
    Post: Post,
    Put: Put,
    Schema: Schema
  };
})();
