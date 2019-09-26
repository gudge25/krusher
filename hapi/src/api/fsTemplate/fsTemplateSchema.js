const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class fsTemplateSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            ftID: Joi.number().integer().optional().allow(null),
            ftName: Joi.string().max(200).optional().allow(null),
            delimiter: Joi.string().optional().allow(null),
            Encoding: Joi.string().optional().allow(null),
            isActive: Joi.boolean().optional().allow(null),
        };

        const name = 'Templates';
        const params = { schema, name };
        super(params);
    }

    schemaDetail() {
        return {
            ffID: Joi.number().integer().optional().allow(null),
            clStatus: Joi.number().integer().allow(null),
            ccStatus: Joi.number().integer().allow(null),
        };
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

module.exports = fsTemplateSchema;
