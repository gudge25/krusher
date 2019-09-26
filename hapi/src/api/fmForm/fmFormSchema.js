const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');
const Model = require('src/base/BaseModelDoc');

class fmFormSchema extends BaseSchema {
    constructor() {
        const schema = new Model.Schema();
        delete schema.dcSum;
        delete schema.dcState;
        schema.tpID = Joi.number().integer().optional().allow(null);

        const name = 'Form';
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

    schemaExport() {
        return {
            DateFrom: Joi.date().iso().allow(null).description('date from'),
            DateTo: Joi.date().iso().allow(null).description('date to'),
            ffID: Joi.number().integer().optional().allow(null),
            tpID: Joi.number().integer().required()
        }
    }

    schemaInsert() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        return obj;
    }
}

module.exports = fmFormSchema;