const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class fsBaseSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            dbID: Joi.number().integer().optional().allow(null),
            dbName: Joi.string().max(50).optional().allow(null),
            dbPrefix: Joi.string().max(10).optional().allow(null),
            activeTo: Joi.string().max(8).allow(null).description('HH:MM:SS'),
            isActive: Joi.boolean().optional().allow(null),
        };

        const name = 'Base';
        const params = { schema, name };
        super(params);
    }

    schemaLookup() {
        const obj = Object.assign({}, this.schema);
        return {
            dbID: obj.dbID,
            dbName: obj.dbName
        }
    }

    schemaSabd() {
        const obj = Object.assign({}, this.schema);
        return {
            dbName: obj.dbName,
            ffID: Joi.number().integer(),
            ffName: Joi.string(),
        }
    }

    schemaSabdDetail() {
        return {
            FilterID: Joi.number().integer(),
            Name: Joi.string(),
            Qty: Joi.number().integer(),
            clID: Joi.number().integer()
        }
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

module.exports = fsBaseSchema;
