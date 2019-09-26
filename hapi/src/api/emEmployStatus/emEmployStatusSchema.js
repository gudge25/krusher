const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class emEmployStatusSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            emsID: Joi.number().integer().optional().allow(null),
            emID: Joi.number().integer().optional().allow(null),
            onlineStatus: Joi.number().integer().optional().allow(null),
            timeSpent: Joi.number().integer().optional().allow(null),
            isActive: Joi.boolean().optional().allow(null).description('Is this record Active?!')
        };

        const name = 'Employ Status';
        const params = { schema, name };
        super(params);
    }

/*    schemaFindPost() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        obj.sorting = Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)');
        obj.field   = Joi.string().max(50).optional().allow(null).description('Field for sorting');
        obj.offset  = Joi.number().integer().optional().allow(null);
        obj.limit   = Joi.number().integer().optional().allow(null);
        return obj;
    }*/

    schemaStat() {
        /*let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        delete obj.emsID;
        delete obj.timeSpent;
        obj.sorting = Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)');
        obj.field   = Joi.string().max(50).optional().allow(null).description('Field for sorting');
        obj.offset  = Joi.number().integer().optional().allow(null);
        obj.limit   = Joi.number().integer().optional().allow(null);
        return obj;*/
        return {
            DateFrom: Joi.date().iso().required(),
            DateTo: Joi.date().iso().required(),
            emIDs: Joi.array().items(Joi.number().integer().allow(null,true,false).description('Employee ID')).allow(null),
            onlineStatus: Joi.number().integer().optional().allow(null),
            sorting: Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)'),
            field: Joi.string().max(50).optional().allow(null).description('Field for sorting'),
            offset: Joi.number().integer().optional().allow(null),
            limit: Joi.number().integer().optional().allow(null),
        };
    }
}

module.exports = emEmployStatusSchema;
