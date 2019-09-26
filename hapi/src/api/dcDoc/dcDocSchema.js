const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');
const Model = require('src/base/BaseModelDoc');

class dcDocSchema extends BaseSchema {
    constructor() {
        const schema = new Model.Schema();

        const name = 'dcDoc';
        const params = { schema, name };
        super(params)
    }

    schemaFindPost() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        delete obj.dcLink;
        delete obj.dcDate;
        obj.dateFrom    = Joi.date().iso().allow(null).description('Date of begin calculation');
        obj.dateTo      = Joi.date().iso().allow(null).description('Date of end calculation');
        obj.dctID       = Joi.number().integer().optional().allow(null);
        obj.clName      = Joi.string().max(200).optional().allow(null);
        obj.crID        = Joi.number().integer().optional().allow(null);
        obj.dcRate      = Joi.number().precision(4).optional().allow(null);
        obj.pcID        = Joi.number().integer().optional().allow(null);
        obj.uID         = Joi.number().integer().optional().allow(null);
        obj.sorting     = Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)');
        obj.field       = Joi.string().max(50).optional().allow(null).description('Field for sorting');
        obj.offset      = Joi.number().integer().optional().allow(null);
        obj.limit       = Joi.number().integer().optional().allow(null);
        return obj;
    }

    schemaFindByCLient() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        delete obj.dcDate;
        delete obj.dcState;
        delete obj.isActive;
        obj.ccName      = Joi.string().max(50).optional().allow(null);
        obj.dctID       = Joi.number().integer().optional().allow(null);
        obj.dcDate      = Joi.date().iso().allow(null);
        obj.dcNo        = Joi.string().max(35).optional().allow(null);
        obj.isActive    = Joi.boolean().optional().allow(null);
        obj.sorting     = Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)');
        obj.field       = Joi.string().max(50).optional().allow(null).description('Field for sorting');
        obj.offset      = Joi.number().integer().optional().allow(null);
        obj.limit       = Joi.number().integer().optional().allow(null);
        return obj;
    }

}

module.exports = dcDocSchema;