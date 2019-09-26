const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class fmFormItemSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID: Joi.number().integer().optional().allow(null),
            fiID: Joi.number().integer().optional().allow(null),
            dcID: Joi.number().integer().optional().allow(null),
            qID: Joi.number().integer().optional().allow(null),
            qName: Joi.string().max(2000).optional().allow(null),
            qiID: Joi.number().integer().optional().allow(null),
            qiAnswer: Joi.string().max(100).optional().allow(null),
            qiComment: Joi.string().max(2000).optional().allow(null),
            isActive: Joi.boolean().optional().allow(null),
        };

        const name = 'fmFormItem';
        const params = { schema, name };
        super(params);
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

    schemaInsert() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        return obj;
    }
}

module.exports = fmFormItemSchema;