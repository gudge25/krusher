const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class astRouteOutgoingItemsSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID: Joi.number().integer().optional().allow(null),
            roiID: Joi.number().integer().optional().allow(null),
            roID: Joi.number().integer().optional().allow(null),
            pattern: Joi.string().max(50).optional().allow(null),
            callerID: Joi.string().max(50).optional().allow(null),
            prepend: Joi.string().max(50).optional().allow(null),
            prefix: Joi.string().max(50).optional().allow(null),
            priority: Joi.number().integer().optional().allow(null),
            isActive: Joi.boolean().optional().allow(null)
        };

        const name = 'Route Outgoing Items';
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
        return {
            roiID : Joi.number().integer().optional().allow(null),
            roID : Joi.number().integer().optional().allow(null),
            pattern : Joi.array().items(Joi.string().max(2000).required()),
            callerID : Joi.string().max(50).optional().allow(null),
            prepend : Joi.string().max(50).optional().allow(null),
            prefix : Joi.string().max(50).optional().allow(null),
            priority : Joi.number().integer().optional().allow(null),
            isActive : Joi.boolean().optional().allow(null)
        };
    }

    schemaUpdate() {
        let obj = Object.assign({}, this.schema);
        return obj;
    }
}

module.exports = astRouteOutgoingItemsSchema;