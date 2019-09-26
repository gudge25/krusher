const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class fsTemplateItemSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            ftID : Joi.number().integer().optional().allow(null),
            ftiID : Joi.number().integer().optional().allow(null),
            ftType: Joi.number().integer().optional().allow(null),
            ColNumber: Joi.array().items(Joi.number().integer().optional().allow(null)),
            ftDelim : Joi.string().max(12).optional().allow(null),
            isActive: Joi.boolean().optional().allow(null),
        };

        const name = 'Templates item';
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
    };
}

module.exports = fsTemplateItemSchema;
