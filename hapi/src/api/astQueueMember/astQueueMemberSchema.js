const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class astQueueMemberSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            quemID: Joi.number().integer().optional().allow(null).description('Primary key of queue member'),
            emID: Joi.number().integer().optional().allow(null).description('Employer ID'),
            queID: Joi.number().integer().optional().allow(null).description('Queue ID'),
            membername: Joi.string().max(40).optional().allow(null).description('Member name'),
            queue_name: Joi.string().max(128).optional().allow(null).description('Queue name'),
            interface: Joi.string().max(128).optional().allow(null).description('Interface'),
            penalty: Joi.number().integer().optional().allow(null).description('Penalty'),
            paused: Joi.number().integer().optional().allow(null).description('Paused'),
            isActive: Joi.boolean().optional().allow(null).description('Is this record Active?!')
        };

        const name = 'Queue Members';
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
}

module.exports = astQueueMemberSchema;