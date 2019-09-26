const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class crmCompanySchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            coID : Joi.number().integer().optional().allow(null),
            coName : Joi.string().max(50).optional().allow(null),
            coDescription : Joi.string().max(50).optional().allow(null),
            inMessage : Joi.string().max(5000).optional().allow(null),
            outMessage : Joi.string().max(5000).optional().allow(null),
            pauseDelay : Joi.number().integer().optional().allow(null),
            isActivePOPup: Joi.boolean().optional().allow(null),
            isRingingPOPup: Joi.boolean().optional().allow(null),
            isUpPOPup: Joi.boolean().optional().allow(null),
            isCCPOPup: Joi.boolean().optional().allow(null),
            isClosePOPup: Joi.boolean().optional().allow(null),
            isActive: Joi.boolean().optional().allow(null)
        };

        const name = 'Company';
        const params = { schema, name };
        super(params);
    }

    schemaInsert() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        return obj;
    }

    schemaUpdate() {
        let obj = Object.assign({}, this.schema);
        return obj;
    }

    schemaFindPost() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        delete obj.inMessage;
        delete obj.outMessage;
        obj.sorting = Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)');
        obj.field   = Joi.string().max(50).optional().allow(null).description('Field for sorting');
        obj.offset  = Joi.number().integer().optional().allow(null);
        obj.limit   = Joi.number().integer().optional().allow(null);
        return obj;
    }
}

module.exports = crmCompanySchema;