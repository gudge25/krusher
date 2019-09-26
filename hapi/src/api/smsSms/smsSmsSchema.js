const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class smsSmsSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            dcID: Joi.number().integer().optional(),
            emID: Joi.number().integer().optional().allow(null),
            originator: Joi.string().max(15).optional().allow(null),
            ccName: Joi.string().max(15).optional().allow(null),
            text_sms: Joi.string().max(2000).optional().allow(null),
            IsOut: Joi.boolean().optional().allow(null),
            priority: Joi.number().integer().optional().allow(null),
            statusSms: Joi.number().integer().optional().allow(null),
            isActive: Joi.boolean().optional().allow(null)
        };

        const name = 'Sms';
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

    schemaInsert() {
        const obj = Object.assign({}, this.schema);
        return {
            "dcID": obj.dcID,
            "ccID": Joi.number().integer().optional().allow(null),
            "clID": Joi.number().integer().optional().allow(null),
            "ffID": Joi.number().integer().optional().allow(null),
            "originator": obj.originator,
            "ccName": obj.ccName,
            "text_sms": obj.text_sms,
            "isActive": obj.isActive
        };
    }

    schemaInsertBulk() {
        const obj = Object.assign({}, this.schema);
        return {
            "bulkID": Joi.number().integer().optional(),
            "originator": obj.originator,
            "ffID": Joi.number().integer().optional().allow(null),
            "text_sms": obj.text_sms,
            "timeBegin": Joi.date().iso().allow(null),
            "status": Joi.number().integer().optional().allow(null),
            "isActive": obj.isActive
        };
    }

    schemaUpdateBulk() {
        const obj = Object.assign({}, this.schema);
        return {
            "HIID": Joi.number().integer().optional(),
            "bulkID": Joi.number().integer().optional(),
            "originator": obj.originator,
            "ffID": Joi.number().integer().optional().allow(null),
            "text_sms": obj.text_sms,
            "timeBegin": Joi.date().iso().allow(null),
            "status": Joi.number().integer().optional().allow(null),
            "isActive": obj.isActive
        };
    }

    schemaFindBulkPost() {
        const obj = Object.assign({}, this.schema);
        return {
            "bulkID": Joi.number().integer().optional().allow(null),
            "originator": obj.originator,
            "ffID": Joi.number().integer().optional().allow(null),
            "text_sms": obj.text_sms,
            "timeBegin": Joi.date().iso().allow(null),
            "emID": Joi.number().integer().optional().allow(null),
            "status": Joi.number().integer().optional().allow(null),
            "isActive": obj.isActive,
            "sorting": Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)'),
            "field": Joi.string().max(5).optional().allow(null).description('Field for sorting'),
            "offset": Joi.number().integer().optional().allow(null),
            "limit": Joi.number().integer().optional().allow(null)
        };
    }

    schemaGoipIncoming() {
        const obj = Object.assign({}, this.schema);
        return {
            "name": Joi.string().max(15).optional().allow(null),
            "number": obj.ccName,
            "content": obj.text_sms
        }
    }
}

module.exports = smsSmsSchema;
