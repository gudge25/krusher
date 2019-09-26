const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class astAutodialProcessSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            id_autodial: Joi.number().integer().optional().allow(null),
            process: Joi.number().integer().optional().allow(null),
            ffID: Joi.number().integer().optional().allow(null),
            id_scenario: Joi.number().integer().optional().allow(null),
            emID: Joi.number().integer().optional().allow(null),
            factor: Joi.number().integer().optional().allow(null),
            called: Joi.number().integer().optional().allow(null),
            targetCalls: Joi.number().integer().optional().allow(null),
            planDateBegin: Joi.date().iso().optional().allow(null),
            errorDescription: Joi.string().max(500).optional().allow(null),
            description: Joi.string().max(500).optional().allow(null),
            isActive: Joi.boolean().optional().allow(null).description('Is this record Active?!')
        };

        const name = 'Autodial process';
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

    schemaAutocall() {
        const obj = Object.assign({}, this.schema);
        return {
            "id_autodial": obj.id_autodial,
            "qtyContact": Joi.number().integer().optional().allow(null)
        };
    }
}

module.exports = astAutodialProcessSchema;