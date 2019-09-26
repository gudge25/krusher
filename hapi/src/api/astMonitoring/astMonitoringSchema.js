const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class astMonitoringSchema extends BaseSchema {
    constructor() {
        const schema = {
            SIP: Joi.string().max(30).optional(),
            eventName: Joi.string().max(30).optional(),
            dev_status: Joi.string().max(30).optional().allow(null),
            dev_state: Joi.string().max(30).optional().allow(null),
            pause: Joi.bool().required().allow(null),
            address: Joi.string().max(20).optional().allow(null),
        };

        const name = 'Monitoring';
        const params = { schema, name };
        super(params);
    }

    schemaFindPost() {
        let obj = Object.assign({}, this.schema);
        obj.startDate = Joi.date().iso().allow(null);
        obj.endDate = Joi.date().iso().allow(null);
        delete obj.dev_status;
        delete obj.dev_state;
        delete obj.pause;
        delete obj.eventName;
        delete obj.address;

        return obj;
    }
}

module.exports = astMonitoringSchema;