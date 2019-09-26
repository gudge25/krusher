const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class crmOrgSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID: Joi.number().integer().required().allow(null),
            clID: Joi.number().integer().required().allow(null),
            Account: Joi.number().integer().allow(null),
            Bank: Joi.string().max(50).allow(null),
            TaxCode: Joi.string().max(14).allow(null),
            SortCode: Joi.number().integer().allow(null),
            RegCode: Joi.number().integer().allow(null),
            CertNumber: Joi.number().integer().allow(null),
            OrgType: Joi.number().integer().allow(null),
            ShortName : Joi.string().max(50).allow(null),
            KVED : Joi.string().max(7).allow(null),
            KVEDName : Joi.string().max(250).allow(null),
            headPost: Joi.string().max(50).allow(null),
            headFIO: Joi.string().max(100).allow(null),
            headFam:Joi.string().max(50).allow(null),
            headIO: Joi.string().max(100).allow(null),
            headSex: Joi.string().max(10).allow(null),
            orgNote: Joi.string().max(100).allow(null),
            isActive: Joi.boolean().optional().allow(null),
        };

        const name = 'crmOrg';
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
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        return obj;
    }
}

module.exports = crmOrgSchema;