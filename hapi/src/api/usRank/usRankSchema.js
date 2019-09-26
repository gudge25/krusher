const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class usRankSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            uID : Joi.any().optional().allow(null),
            uRank : Joi.string().max(50).optional().allow(null),
            type : Joi.number().integer().positive().optional().allow(null),
            emID : Joi.number().integer().positive().optional().allow(null),
            isActive: Joi.boolean().optional().allow(null)
        };

        const name = 'Rank';
        const params = { schema, name };
        super(params);
    }

    schemaInsert() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        delete obj.emID;
        return obj;
    }

    schemaUpdate() {
        let obj = Object.assign({}, this.schema);
        delete obj.emID;
        return obj;
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

module.exports = usRankSchema;