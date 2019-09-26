const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class astPoolsSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            poolID: Joi.number().integer().optional().allow(null),
            poolName: Joi.string().max(50).optional().allow(null),
            priority: Joi.number().integer().optional().allow(null),
            coID: Joi.number().integer().optional().allow(null),
            isActive: Joi.boolean().optional().allow(null)
        };

        const name = 'Pool';
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
}

module.exports = astPoolsSchema;
