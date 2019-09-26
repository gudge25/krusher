const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class astCustomDestinationSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            cdID: Joi.number().integer().optional().allow(null),
            cdName: Joi.string().max(50).optional().allow(null),
            context: Joi.string().max(50).optional().allow(null),
            exten: Joi.string().max(50).optional().allow(null),
            description: Joi.string().max(250).optional().allow(null),
            notes: Joi.string().max(2000).optional().allow(null),
            return: Joi.boolean().optional().allow(null),
            destination: Joi.number().integer().optional().allow(null),
            destdata: Joi.number().integer().optional().allow(null),
            destdata2: Joi.string().max(100).optional().allow(null),
            priority: Joi.number().integer().optional().allow(null),
            isActive: Joi.boolean().optional().allow(null)
        };

        const name = 'Custom destionation';
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

module.exports = astCustomDestinationSchema;
