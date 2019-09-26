const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class astCdrSchema extends BaseSchema {
    constructor() {
        const schema = {
            GUID: Joi.string().max(38).optional().allow(null),
            disposition: Joi.number().integer().optional().allow(null),
        };

        const name = 'Cdr';
        const params = { schema, name };
        super(params);
    }
}

module.exports = astCdrSchema;