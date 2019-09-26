const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class stCategorySchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            pctID: Joi.number().integer().optional().allow(null),
            pctName: Joi.string().max(50).optional().allow(null),
            ParentID: Joi.number().integer().optional().allow(null),
            isActive: Joi.boolean().optional().allow(null)
        };

        const name = 'stCategory';
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

module.exports = stCategorySchema;