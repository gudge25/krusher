const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class astTimeGroupItemsSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            tgiID: Joi.number().integer().optional().allow(null),
            tgID: Joi.number().integer().optional().allow(null),
            TimeStart: Joi.string().max(8).optional().allow(null),//TimeStart: Joi.date().iso().optional().allow(null),
            TimeFinish: Joi.string().max(8).optional().allow(null),
            DayNumStart: Joi.number().integer().optional().allow(null),
            DayNumFinish: Joi.number().integer().optional().allow(null),
            DayStart: Joi.string().max(10).optional().allow(null),
            DayFinish: Joi.string().max(10).optional().allow(null),
            MonthStart: Joi.string().max(10).optional().allow(null),
            MonthFinish: Joi.string().max(10).optional().allow(null),
            isActive: Joi.boolean().optional().allow(null)
        };

        const name = 'Time Group';
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

module.exports = astTimeGroupItemsSchema;