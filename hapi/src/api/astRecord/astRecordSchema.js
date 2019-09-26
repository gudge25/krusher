const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class astRecordSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            record_id: Joi.number().integer().optional().allow(null),
            record_name: Joi.string().max(500).optional().allow(null),
            record_source: Joi.string().max(500).optional().allow(null),
            isActive: Joi.bool().required().allow(null).description('Active or not active record')
        };

        const name = 'Record';
        const params = { schema, name };
        super(params);
    }

    schemaFindPost() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        obj.sorting = Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)');
        obj.field = Joi.string().max(50).optional().allow(null).description('Field for sorting');
        obj.offset  = Joi.number().integer().optional().allow(null);
        obj.limit   = Joi.number().integer().optional().allow(null);
        return obj;
    }

    schemaInsert() {
        let obj = Object.assign({}, this.schema);
        delete obj.record_id;
        delete obj.HIID;
        obj.file = Joi.any().meta({ swaggerType: 'file' }).description('Voice record');
        return obj;
    }

    schemaInsertF() {
        let obj = Object.assign({}, this.schema);
        delete obj.record_id;
        delete obj.HIID;
        delete obj.isActive;
        obj.Aid = Joi.number().integer().optional().allow(null);
        return obj;
    }
}

module.exports = astRecordSchema;