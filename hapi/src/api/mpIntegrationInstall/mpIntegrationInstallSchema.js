const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class mpIntegrationInstallSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            mpiID: Joi.number().integer().optional().allow(null),
            mpID: Joi.number().integer().optional().allow(null),
            login: Joi.string().max(50).optional().allow(null),
            pass: Joi.string().max(50).optional().allow(null),
            tokenAccess: Joi.string().max(50).optional().allow(null),
            link: Joi.string().max(50).optional().allow(null),
            data1: Joi.string().max(250).optional().allow(null),
            data2: Joi.string().max(250).optional().allow(null),
            data3: Joi.string().max(250).optional().allow(null),
            isActive: Joi.boolean().optional().allow(null)
        };

        const name = 'Market Place installation';
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

module.exports = mpIntegrationInstallSchema;
