const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class fsFileSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            ffID: Joi.number().integer().optional().allow(null),
            ffName: Joi.string().max(200).optional().allow(null),
            Priority: Joi.number().integer().optional().allow(null),
            dbID: Joi.number().integer().optional().allow(null),
            isActive: Joi.boolean().optional().allow(null),
        };

        const name = 'File';
        const params = { schema, name };
        super(params);
    }

    schemaDetail() {
        return {
            ffID: Joi.number().integer().required().allow(null),
            langID: Joi.number().integer().optional().allow(null),
            isActive: Joi.boolean().optional().allow(null),
        };
    }

    schemaInsert() {
        let obj = Object.assign({}, this.schema);
        return {
            file: Joi.any()
                .meta({ swaggerType: 'file' })
                .description('Import file'),
            ffID: obj.ffID,
            ftID: Joi.number().integer().required(),
            dbID: obj.dbID
        };
    }

    schemaInsertForce() {
        let obj = Object.assign({}, this.schema);
        return {
            ffID: obj.ffID,
            ffName: obj.ffName,
            dbID: obj.dbID,
            Priority: obj.Priority,
            isActive: obj.isActive
        };
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

module.exports = fsFileSchema;
