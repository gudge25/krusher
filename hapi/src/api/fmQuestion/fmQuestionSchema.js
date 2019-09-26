const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class fmQuestionSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID: Joi.number().integer().optional().allow(null),
            qID: Joi.number().integer().optional().allow(null),
            qName: Joi.string().max(2000).optional().allow(null),
            ParentID: Joi.number().integer().optional().allow(null),
            tpID: Joi.number().integer().optional().allow(null),
            isActive: Joi.boolean().optional().allow(null),
        };
        const name = 'Questions';
        const params = { schema, name };
        super(params)
    }

    schemaFindPost() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        obj.sorting = Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)');
        obj.field   = Joi.string().max(50).optional().allow(null).description('Field for sorting');
        obj.offset  = Joi.number().integer().optional().allow(null);
        obj.limit   = Joi.number().integer().optional().allow(null);
        return obj;
    }

    schemaReport() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        delete obj.qID;
        delete obj.qName;
        delete obj.ParentID;
        delete obj.isActive;
        obj.DateFrom = Joi.date().iso().allow(null);
        obj.DateTo = Joi.date().iso().allow(null);
        obj.Step = Joi.number().integer().allow(null);
        return obj;
    };

    schemaInsert() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        return obj;
    }
}

module.exports = fmQuestionSchema;
