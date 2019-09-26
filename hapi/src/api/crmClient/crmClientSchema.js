const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class crmClientSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID: Joi.number().integer().optional().allow(null),
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

        const name = 'crmClient';
        const params = { schema, name };
        super(params);
    }

    schemaFindPost() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        delete obj.Comment;
        delete obj.Sex;
        delete obj.ParentID;
        delete obj.CompanyID;
        delete obj.isActual;
        delete obj.responsibleID;
        delete obj.ActualStatus;
        delete obj.Position;
        delete obj.isActive;
        obj.CompanyIDs = Joi.array().items(Joi.number().integer().allow(null)).allow(null);
        obj.emID = Joi.number().integer().optional().allow(null);
        obj.tagID = Joi.number().integer().optional().allow(null);
        obj.ccStatus = Joi.number().integer().optional().allow(null);
        obj.clStatus = Joi.number().integer().optional().allow(null);
        obj.ffID = Joi.number().integer().optional().allow(null);
        obj.CallDate = Joi.date().iso().optional().allow(null);
        obj.CallDateTo = Joi.date().iso().optional().allow(null).description('Second date from time period');
        obj.cID = Joi.number().integer().optional().allow(null);
        obj.dctID = Joi.number().integer().optional().allow(null);
        obj.isActive = Joi.boolean().optional().allow(null);
        obj.sorting = Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)');
        obj.field = Joi.string().max(50).optional().allow(null).description('Field for sorting');
        obj.offset  = Joi.number().integer().optional().allow(null);
        obj.limit   = Joi.number().integer().optional().allow(null);
        return obj;
    }

    schemaInsert() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        return obj;
    }

    schemaSave() {
        return{
            HIID: Joi.number().integer().required(),
            clID: Joi.number().integer().required(),
            clName: Joi.string().max(200).required(),
            IsPerson: Joi.boolean().required(),
            isActive: Joi.boolean().required(),
            Comment: Joi.string().max(200).required().allow(null),
            ffID: Joi.number().integer().required(),
            ParentID: Joi.number().integer().required().allow(null),
            CompanyID: Joi.number().integer().required().allow(null),
            Position: Joi.number().integer().allow(null),
            TaxCode: Joi.string().max(14).required().allow(null),
            address: Joi.string().max(200).required().allow(null),
            contacts: Joi.array().items(Joi.object().keys({
                ccID: Joi.number().integer().allow(null),
                ccName: Joi.string().max(50).required(),
                ccComment: Joi.string().max(100).allow(null),
                ccType: Joi.number().integer().required()
            })).required().allow(null)
        };
    }

    schemaFindSum() {
        return {
            clName: Joi.string().max(200).optional(),
            ccName: Joi.string().max(50).optional(),
            ccType: Joi.number().integer().optional(),
            regID: Joi.number().integer().optional(),
            emID: Joi.number().integer().optional(),
            tagID: Joi.number().integer().optional(),
            ccStatus: Joi.number().integer().optional(),
            clStatus: Joi.number().integer().optional(),
            ffID: Joi.number().integer().optional(),
            CallDate: Joi.date().iso().optional(),
            cID: Joi.number().integer().optional(),
            offset: Joi.number().integer().optional(),
            limit: Joi.number().integer().optional(),
            dctID: Joi.number().integer().optional()
        };
    }

    schemaSearch() {
        return {
            clName: Joi.string().max(200).optional().allow(null),
            emID: Joi.number().integer().optional().allow(null),
            ccName: Joi.string().max(50).optional().allow(null),
            ccType: Joi.number().integer().optional().allow(null),
            isActive: Joi.boolean().optional().allow(null),
            sorting: Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)'),
            field: Joi.string().max(50).optional().allow(null).description('Field for sorting'),
            offset: Joi.number().integer().optional().allow(null),
            limit: Joi.number().integer().optional().allow(null),
        };
    }

    schemaBulkDelete() {
        return {
            clIDs: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
        };
    }
    
}

module.exports = crmClientSchema;