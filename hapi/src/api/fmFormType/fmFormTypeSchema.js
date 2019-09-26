const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class fmFormTypeSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID: Joi.number().integer().optional().allow(null),
            tpID: Joi.number().integer().optional().allow(null),
            tpName: Joi.string().max(250).optional().allow(null),
            ffID: Joi.number().integer().optional().allow(null),
            isActive: Joi.boolean().optional().allow(null)
        };
        const name = 'Role';
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

    schemaInsert() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        return obj;
    }
}

module.exports = fmFormTypeSchema;
