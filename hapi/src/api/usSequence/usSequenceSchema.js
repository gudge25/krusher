const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class usSequenceSchema extends BaseSchema {
    constructor() {
        const schema = {
            seqName: Joi.string().max(30).optional(),
            seqValue: Joi.number().integer().optional()
        };

        const name = 'usSequence';
        const params = { schema, name };
        super(params);
    }

    schemaFindPost() {
        let obj = Object.assign({}, this.schema);
        delete obj.seqValue;
        return obj;
    }
}

module.exports = usSequenceSchema;