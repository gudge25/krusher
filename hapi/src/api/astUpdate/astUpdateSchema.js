const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class AstUpdateSchema extends BaseSchema {
    constructor() {
        const schema = {
            script: Joi.string().max(100).optional().allow(null),
        };

        const name = 'PHP';
        const params = { schema, name };
        super(params);
    }
}

module.exports = AstUpdateSchema;