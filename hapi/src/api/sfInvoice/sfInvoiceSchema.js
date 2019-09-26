const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');
const Model = require('src/base/BaseModelDoc');

class sfInvoiceSchema extends BaseSchema {
    constructor() {
        const schema = new Model.Schema();
        delete schema.dcState;
        schema.Delivery = Joi.string().max(255).optional().allow(null);
        schema.VATSum = Joi.number().precision(2).optional().allow(null);
        schema.isActive = Joi.boolean().optional().allow(null);

        const name = 'Invoices';
        const params = { schema, name };
        super(params);
    }

    schemaFindPost() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        /*delete obj.dcNo;
        delete obj.dcDate;
        delete obj.dcLink;
        delete obj.dcComment;
        delete obj.dcSum;
        delete obj.dcStatus;
        delete obj.clID;
        delete obj.emID;
        delete obj.isActive;
        delete obj.Delivery;
        delete obj.VATSum;*/

        obj.sorting = Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)');
        obj.field   = Joi.string().max(50).optional().allow(null).description('Field for sorting');
        obj.offset  = Joi.number().integer().optional().allow(null);
        obj.limit   = Joi.number().integer().optional().allow(null);
        return obj;
    };

    schemaInsert() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        return obj;
    }
}

module.exports = sfInvoiceSchema;
