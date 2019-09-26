const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class astEventsSchema extends BaseSchema {
    constructor() {
        const schema = {
            ccName: Joi.number().integer().required(),
            SIP: Joi.string().max(10).required(),
            eventName: Joi.string().max(10).required(),
            /*timeStart: Joi.date().iso().allow(null);
            timeEnd: Joi.date().iso().allow(null);*/
        };

        const name = 'Asterisk Events';
        const params = { schema, name };
        super(params);
    }

    schemaFindPost() {
        let obj = Object.assign({}, this.schema);
        delete obj.ccName;
        delete obj.eventName;
        obj.ccName = Joi.number().integer().optional().allow(null);
        obj.eventName = Joi.string().max(10).optional().allow(null);
        obj.DateFrom = Joi.date().iso().allow(null);
        obj.DateTo = Joi.date().iso().allow(null);
        return obj;
    }

    schemaInsert() {
        let obj = Object.assign({}, this.schema);
        return obj;
    }
}

module.exports = astEventsSchema;