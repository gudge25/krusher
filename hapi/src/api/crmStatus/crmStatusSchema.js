const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class crmStatusSchema extends BaseSchema {
    constructor() {
        const schema = {
            clID: Joi.number().integer().optional(),
            clStatus: Joi.number().integer().optional(),
            isFixed: Joi.boolean().optional()
        };

        const name = 'crmStatus';
        const params = { schema, name };
        super(params);
    }

    schemaFindPost() {
        let obj = Object.assign({}, this.schema);
        obj.sorting = Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)');
        obj.field = Joi.string().max(50).optional().allow(null).description('Field for sorting');
        obj.offset  = Joi.number().integer().optional().allow(null);
        obj.limit   = Joi.number().integer().optional().allow(null);
        return obj;
    }
}

module.exports = crmStatusSchema;