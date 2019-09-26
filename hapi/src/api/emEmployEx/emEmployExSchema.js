const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class emEmployExSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            emID: Joi.number().integer().optional(),
            Settings: Joi.object().optional(),
            isActive: Joi.boolean().optional().allow(null).description('Is this record Active?!')
        };

        const name = 'EmployEx';
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

module.exports = emEmployExSchema;
