const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class sfInvoiceItemSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID: Joi.number().integer().optional().allow(null),
            dcID: Joi.number().integer().optional().allow(null),
            iiID: Joi.number().integer().optional().allow(null),
            OwnerID: Joi.number().integer().optional().allow(null),
            psID: Joi.number().integer().optional().allow(null),
            iNo: Joi.number().integer().optional().allow(null),
            iName: Joi.string().max(1020).optional().allow(null),
            iPrice: Joi.number().precision(4).optional().allow(null),
            iQty: Joi.number().precision(4).optional().allow(null),
            iComments: Joi.string().max(200).optional().allow(null),
            isActive: Joi.boolean().optional().allow(null),
        };

        const name = 'Invoice items';
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

    schemaInsert() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        return obj;
    }
}

module.exports = sfInvoiceItemSchema;
