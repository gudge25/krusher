const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class astIVREntriesSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            entry_id: Joi.number().integer().optional().allow(null),
            id_ivr_config: Joi.number().integer().optional().allow(null),
            extension: Joi.string().max(20).optional().allow(null),
            destination: Joi.number().integer().optional().allow(null),
            destdata: Joi.number().integer().optional().allow(null),
            destdata2: Joi.string().max(100).optional().allow(null),
            return: Joi.boolean().optional().allow(null),
            isActive: Joi.boolean().optional().allow(null).description('Is this record Active?!')
        };

        const name = 'IVREntries';
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

module.exports = astIVREntriesSchema;