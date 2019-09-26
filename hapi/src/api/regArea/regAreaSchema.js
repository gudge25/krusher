const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class regAreaSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            aID: Joi.number().integer().optional().allow(null).description('Area ID'),
            aName: Joi.string().max(50).optional().allow(null).description('Area name'),
            cID: Joi.number().integer().optional().allow(null).description('Country ID'),
            rgID: Joi.number().integer().optional().allow(null).description('Region ID'),
            langID: Joi.number().integer().optional().allow(null),
            isActive: Joi.boolean().optional().allow(null),
        };

        const name = 'Area';
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

module.exports = regAreaSchema;