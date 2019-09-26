const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class astCallbackSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            cbID: Joi.number().integer().optional().allow(null),
            cbName: Joi.string().max(50).optional().allow(null),
            timeout: Joi.number().integer().optional().allow(null),
            isFirstClient: Joi.boolean().optional().allow(null),
            destination: Joi.number().integer().optional().allow(null),
            destdata: Joi.number().integer().optional().allow(null),
            destdata2: Joi.string().max(100).optional().allow(null),
            isActive: Joi.boolean().optional().allow(null)
        };

        const name = 'astCallback';
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

module.exports = astCallbackSchema;
