const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class astQueueSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            queID: Joi.number().integer().optional().allow(null).description('Primary key of queue'),
            name: Joi.string().max(128).optional().allow(null).description('Empty'),
            musiconhold: Joi.string().max(128).optional().allow(null).description('Empty'),
            announce: Joi.string().max(128).optional().allow(null).description('Empty'),
            context: Joi.string().max(128).optional().allow(null).description('Empty'),
            timeout: Joi.number().integer().optional().allow(null).description('Empty'),
            monitor_join: Joi.number().integer().optional().allow(null).description('Empty'),
            monitor_format: Joi.string().max(128).optional().allow(null).description('Empty'),
            queue_youarenext: Joi.string().max(128).optional().allow(null).description('Empty'),
            queue_thereare: Joi.string().max(128).optional().allow(null).description('Empty'),
            queue_callswaiting: Joi.string().max(128).optional().allow(null).description('Empty'),
            queue_holdtime: Joi.string().max(128).optional().allow(null).description('Empty'),
            queue_minutes: Joi.string().max(128).optional().allow(null).description('Empty'),
            queue_seconds: Joi.string().max(128).optional().allow(null).description('Empty'),
            queue_lessthan: Joi.string().max(128).optional().allow(null).description('Empty'),
            queue_thankyou: Joi.string().max(128).optional().allow(null).description('Empty'),
            queue_reporthold: Joi.string().max(128).optional().allow(null).description('Empty'),
            announce_frequency: Joi.number().integer().optional().allow(null).description('Empty'),
            announce_round_seconds: Joi.number().integer().optional().allow(null).description('Empty'),
            announce_holdtime: Joi.string().max(128).optional().allow(null).description('Empty'),
            retry: Joi.number().integer().optional().allow(null).description('Empty'),
            wrapuptime: Joi.number().integer().optional().allow(null).description('Empty'),
            maxlen: Joi.number().integer().optional().allow(null).description('Empty'),
            servicelevel: Joi.number().integer().optional().allow(null).description('Empty'),
            strategy: Joi.string().max(128).optional().allow(null).description('Empty'),
            joinempty: Joi.string().max(128).optional().allow(null).description('Empty'),
            leavewhenempty: Joi.string().max(128).optional().allow(null).description('Empty'),
            eventmemberstatus: Joi.number().integer().optional().allow(null).description('Empty'),
            eventwhencalled: Joi.number().integer().optional().allow(null).description('Empty'),
            reportholdtime: Joi.number().integer().optional().allow(null).description('Empty'),
            memberdelay: Joi.number().integer().optional().allow(null).description('Empty'),
            weight: Joi.number().integer().optional().allow(null).description('Empty'),
            timeoutrestart: Joi.number().integer().optional().allow(null).description('Empty'),
            periodic_announce: Joi.string().max(128).optional().allow(null).description('Empty'),
            periodic_announce_frequency: Joi.number().integer().optional().allow(null).description('Empty'),
            ringinuse: Joi.number().integer().optional().allow(null).description('Empty'),
            setinterfacevar: Joi.number().integer().optional().allow(null).description('Empty'),
            max_wait_time: Joi.number().integer().optional().allow(null),
            fail_destination: Joi.number().integer().optional().allow(null),
            fail_destdata: Joi.number().integer().optional().allow(null),
            fail_destdata2: Joi.string().max(100).optional().allow(null),
            isActive: Joi.boolean().optional().allow(null).description('Is this record Active?!')
        };

        const name = 'Queues';
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

module.exports = astQueueSchema;