const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class astRouteOutgoingSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            roID : Joi.number().integer().optional().allow(null),
            roName : Joi.string().max(50).optional().allow(null),
            destination : Joi.number().integer().optional().allow(null),
            destdata :  Joi.number().integer().optional().allow(null),
            destdata2 :  Joi.string().max(100).optional().allow(null),
            category :  Joi.number().integer().optional().allow(null),
            prepend :  Joi.string().max(50).optional().allow(null),
            prefix :  Joi.string().max(50).optional().allow(null),
            callerID :  Joi.string().max(50).optional().allow(null),
            priority : Joi.number().integer().optional().allow(null),
            coID : Joi.number().integer().optional().allow(null),
            isActive: Joi.boolean().optional().allow(null)
        };

        const name = 'Route Outgoing';
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

    schemaUpdate() {
        let obj = Object.assign({}, this.schema);
        return obj;
    }
}

module.exports = astRouteOutgoingSchema;