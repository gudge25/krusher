const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class crmAddressSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID: Joi.number().integer().optional().allow(null),
            adsID: Joi.number().integer().optional().allow(null),
            adsName: Joi.string().max(200).optional().allow(null),
            adtID: Joi.number().integer().optional().allow(null),
            Postcode: Joi.string().max(10).optional().allow(null),
            clID:  Joi.number().integer().optional().allow(null),
            pntID: Joi.number().integer().optional().allow(null),
            Region: Joi.string().optional().allow(null),
            RegionDesc: Joi.string().optional().allow(null),
            isActive: Joi.boolean().optional().allow(null)
        };

        const name = 'crmAddress';
        const params = { schema, name };
        super(params);
    }


    schemaInsert() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        return obj;
    }

    schemaFindPost() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        obj.sorting = Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)');
        obj.field = Joi.string().max(50).optional().allow(null).description('Field for sorting');
        obj.offset  = Joi.number().integer().optional().allow(null);
        obj.limit   = Joi.number().integer().optional().allow(null);
        return obj;
    }
}

module.exports = crmAddressSchema;