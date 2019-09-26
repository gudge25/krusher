const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class astRouteIncomingSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            rtID: Joi.number().integer().optional().allow(null),
            trID: Joi.number().integer().optional().allow(null),
            DID: Joi.string().max(50).optional().allow(null),
            callerID: Joi.string().max(50).optional().allow(null),
            exten: Joi.string().max(500).optional().allow(null),
            context: Joi.string().max(100).optional().allow(null),
            destination: Joi.number().integer().optional().allow(null),
            destdata: Joi.number().integer().optional().allow(null),
            destdata2: Joi.string().max(100).optional().allow(null),
            stick_destination: Joi.number().integer().optional().allow(null),
            isCallback: Joi.boolean().optional().allow(null),
            isFirstClient: Joi.boolean().optional().allow(null),
            isActive: Joi.boolean().optional().allow(null),
        };

        const name = 'RouteIncoming';
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

module.exports = astRouteIncomingSchema;