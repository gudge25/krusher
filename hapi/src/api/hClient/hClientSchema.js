const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class HClientSchema extends BaseSchema {
    constructor() {
        const schema = {
            RowID: Joi.number().integer().optional().allow(null),
            clID: Joi.number().integer().optional().allow(null),
            clName: Joi.string().max(200).optional().allow(null),
            IsPerson: Joi.boolean().optional().allow(null),
            Sex: Joi.number().integer().optional().allow(null),
            Comment: Joi.string().max(200).optional().allow(null),
            ffID: Joi.number().integer().optional().allow(null),
            ParentID: Joi.number().integer().optional().allow(null),
            CompanyID: Joi.number().integer().optional().allow(null),
            isActual: Joi.boolean().optional().allow(null),
            responsibleID: Joi.number().integer().optional().allow(null),
            ActualStatus: Joi.number().integer().optional().allow(null),
            Position: Joi.number().integer().allow(null),
            isActive: Joi.boolean().optional().allow(null)
        };

        const name = 'history of Client';
        const params = {schema, name};
        super(params);
    }

    schemaFindPost() {
        return {
            RowID: Joi.number().integer().optional().allow(null),
            DateChangeFrom: Joi.date().iso().optional().allow(null).description('date from'),
            DateChangeTo: Joi.date().iso().optional().allow(null).description('date to'),
            host: Joi.string().max(128).optional().allow(null),
            AppName: Joi.string().max(128).optional().allow(null),
            clID: Joi.number().integer().optional().allow(null),
            clName: Joi.string().max(200).optional().allow(null),
            IsPerson: Joi.boolean().optional().allow(null),
            Sex: Joi.boolean().optional().allow(null),
            ParentID: Joi.number().integer().optional().allow(null),
            ffID: Joi.number().integer().optional().allow(null),
            CompanyID: Joi.number().integer().optional().allow(null),
            uID: Joi.number().integer().optional().allow(null),
            isActual: Joi.boolean().optional().allow(null),
            ActualStatus: Joi.number().integer().optional().allow(null),
            Position: Joi.number().integer().optional().allow(null),
            responsibleID: Joi.number().integer().optional().allow(null),
            CreatedBy: Joi.number().integer().optional().allow(null),
            ChangedBy: Joi.number().integer().optional().allow(null),
            isActive: Joi.boolean().optional().allow(null),
            sorting: Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)'),
            field: Joi.string().max(50).optional().allow(null).description('Field for sorting'),
            offset: Joi.number().integer().optional().allow(null),
            limit: Joi.number().integer().optional().allow(null),
        };
    }

}

module.exports = HClientSchema;