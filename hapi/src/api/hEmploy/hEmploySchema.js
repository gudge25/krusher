const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class HEmploySchema extends BaseSchema {
    constructor() {
        const schema = {
            RowID: Joi.number().integer().optional().allow(null),
            emID: Joi.number().integer().optional().allow(null),
            emName: Joi.string().max(200).optional().allow(null),
            LoginName: Joi.string().max(200).optional().allow(null),
            ManageID: Joi.number().integer().optional().allow(null),
            roleID: Joi.number().integer().optional().allow(null),
            sipID: Joi.number().integer().optional().allow(null),
            sipName: Joi.string().max(200).optional().allow(null),
            Queue: Joi.string().max(200).optional().allow(null),
            CompanyID: Joi.number().integer().optional().allow(null),
            onlineStatus: Joi.number().integer().optional().allow(null),
            isActive: Joi.boolean().optional().allow(null)
        };

        const name = 'history of Employ';
        const params = {schema, name};
        super(params);
    }

    schemaFindPost() {
        let obj = Object.assign({}, this.schema);
        obj.DateChangeFrom = Joi.date().iso().optional().allow(null).description('date from');
        obj.DateChangeTo = Joi.date().iso().optional().allow(null).description('date from');
        obj.host = Joi.string().max(128).optional().allow(null);
        obj.AppName = Joi.string().max(128).optional().allow(null);
        obj.sorting = Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)');
        obj.field   = Joi.string().max(50).optional().allow(null).description('Field for sorting');
        obj.offset  = Joi.number().integer().optional().allow(null);
        obj.limit   = Joi.number().integer().optional().allow(null);
        return obj;
    }

}

module.exports = HEmploySchema;