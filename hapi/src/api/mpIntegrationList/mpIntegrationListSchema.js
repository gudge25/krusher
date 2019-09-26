const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class mpIntegrationListSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            mpID: Joi.number().integer().optional().allow(null),
            mpName: Joi.string().max(50).optional().allow(null),
            mpDescription: Joi.string().max(500).optional().allow(null),
            mpLinkProvider: Joi.string().max(100).optional().allow(null),
            mpCategory: Joi.number().integer().optional().allow(null),
            mpLogo: Joi.string().max(250).optional().allow(null),
            mpPrice: Joi.number().optional().allow(null),
            order: Joi.number().integer().optional().allow(null),
            isActive: Joi.boolean().optional().allow(null)
        };

        const name = 'Market Place';
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

module.exports = mpIntegrationListSchema;
