const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class regValidationSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            vID: Joi.number().integer().optional().allow(null),
            prefix: Joi.number().integer().optional().allow(null),
            prefixBegin: Joi.number().integer().optional().allow(null),
            prefixEnd: Joi.number().integer().optional().allow(null),
            MCC: Joi.number().integer().optional().allow(null),
            MNC: Joi.number().integer().optional().allow(null),
            cID: Joi.number().integer().optional().allow(null),
            rgID: Joi.number().integer().optional().allow(null),
            aID: Joi.number().integer().optional().allow(null),
            lID: Joi.number().integer().optional().allow(null),
            oID: Joi.number().integer().optional().allow(null),
            gmt: Joi.number().integer().optional().allow(null),
            isActive: Joi.boolean().optional().allow(null),
        };

        const name = 'Validation';
        const params = { schema, name };
        super(params);
    }

    schemaFindPost() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        obj.phone = Joi.number().integer().optional().allow(null);
        obj.isGSM = Joi.boolean().optional().allow(null);
        obj.langID = Joi.number().integer().optional().allow(null);
        obj.sorting = Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)');
        obj.field   = Joi.string().max(50).optional().allow(null).description('Field for sorting');
        obj.offset  = Joi.number().integer().optional().allow(null);
        obj.limit   = Joi.number().integer().optional().allow(null);
        return obj;
    }

    schemaСheckPhone() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        delete obj.vID;
        delete obj.prefix;
        delete obj.prefixBegin;
        delete obj.prefixEnd;
        delete obj.MCC;
        delete obj.MNC;
        delete obj.cID;
        delete obj.rgID;
        delete obj.aID;
        delete obj.lID;
        delete obj.oID;
        delete obj.gmt;
        delete obj.isActive;
        obj.phone = Joi.number().integer().optional().allow(null);
        return obj;
    }
}

module.exports = regValidationSchema;