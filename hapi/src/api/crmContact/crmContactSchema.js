const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class crmContactSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID: Joi.number().integer().optional().allow(null),
            ccID: Joi.number().integer().optional().allow(null),
            clID: Joi.number().integer().optional().allow(null),
            ccName: Joi.string().max(250).optional().allow(null),
            ccType: Joi.number().integer().optional().allow(null),
            isPrimary: Joi.boolean().optional().allow(null),
            ccStatus: Joi.number().integer().optional().allow(null),
            ccComment: Joi.string().max(100).optional().allow(null),
            isActive: Joi.boolean().optional().allow(null),
        };

        const name = 'crmContact';
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

module.exports = crmContactSchema;