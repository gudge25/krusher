const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class fmQuestionItemSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID: Joi.number().integer().optional().allow(null),
            qiID: Joi.number().integer().optional().allow(null),
            qID: Joi.number().integer().optional().allow(null),
            qiAnswer: Joi.string().max(100).optional().allow(null),
            isActive: Joi.boolean().optional().allow(null),
        };
        const name = 'QuestionItems';
        const params = { schema, name };
        super(params);
    }

    schemaFindPost() {
        /*let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        obj.sorting = Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)');
        obj.field   = Joi.string().max(50).optional().allow(null).description('Field for sorting');
        obj.offset  = Joi.number().integer().optional().allow(null);
        obj.limit   = Joi.number().integer().optional().allow(null);
        return obj;*/
        return {
            qiID: Joi.number().integer().optional().allow(null),
            qIDs: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            qiAnswer: Joi.string().max(100).optional().allow(null),
            isActive: Joi.boolean().optional().allow(null),
            sorting: Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)'),
            field: Joi.string().max(50).optional().allow(null).description('Field for sorting'),
            offset: Joi.number().integer().optional().allow(null),
            limit: Joi.number().integer().optional().allow(null),
        };
    }

    schemaReport() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        delete obj.qiID;
        delete obj.qiAnswer;
        //delete obj.isActive;
        obj.DateFrom = Joi.date().iso().allow(null);
        obj.DateTo = Joi.date().iso().allow(null);
        obj.Step = Joi.number().integer().allow(null);
        obj.isStepPercent = Joi.boolean().allow(null);
        return obj;
    }

    schemaInsert() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        return obj;
    }
}

module.exports = fmQuestionItemSchema;
