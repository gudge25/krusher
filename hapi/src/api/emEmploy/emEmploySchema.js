const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class emEmploySchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID: Joi.number().integer().required(),
            emID: Joi.number().integer().optional().allow(null).description('User ID'),
            emName: Joi.string().max(200).optional().allow(null).description('User name'),
            LoginName: Joi.string().max(30).optional().allow(null).description('User login'),
            Password: Joi.string().max(100).optional().allow(null).description('User password'),
            ManageID: Joi.number().integer().optional().allow(null).description('ID of the manager'),
            roleID: Joi.number().integer().optional().allow(null).description('ID of the role'),
            sipName: Joi.string().max(50).optional().allow(null).description('SIP account'),
            Queue: Joi.string().max(128).optional().allow(null).description('Queue (old field)'),
            sipID: Joi.number().integer().optional().allow(null).description('ID of sip account'),
            CompanyID: Joi.number().integer().optional().allow(null).description('Custom ID'),
            onlineStatus: Joi.number().integer().optional().allow(null).description('Online status of employeer'),
            coIDs: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            pauseDelay: Joi.number().integer().allow(null),
            isActive: Joi.boolean().optional().allow(null).description('Is this record Active?!')
        };

        const name = 'Employeers';
        const params = { schema, name };
        super(params);
    }

    schemaFindPost() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        delete obj.Password;
        obj.sorting = Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)');
        obj.field   = Joi.string().max(50).optional().allow(null).description('Field for sorting');
        obj.offset  = Joi.number().integer().optional().allow(null);
        obj.limit   = Joi.number().integer().optional().allow(null);
        return obj;
    }

    schemaInsert() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        obj.url = Joi.string().max(250).optional().allow(null).description('Client user');
        return obj;
    }

    schemaStat() {
        return {
            DateFrom: Joi.date().iso().required(),
            DateTo: Joi.date().iso().required(),
            emIDs: Joi.array().items(Joi.number().integer().allow(null,true,false).description('Employee ID')).allow(null),
            Step: Joi.number().integer().allow(null),
            disposition: Joi.number().integer().allow(null),
            dctID: Joi.number().integer().allow(null),
            IsOut: Joi.boolean().optional().allow(null),
        };
    }

    schemaUpdateStatus() {
        return {
            emID: Joi.number().integer().description('Employee ID'),
            onlineStatus: Joi.number().integer(),
        };
    }

    schemaCounter() {
        return {
            DateFrom: Joi.date().iso().required(),
            DateTo: Joi.date().iso().required(),
            emIDs: Joi.array().items(Joi.number().integer().allow(null,true,false).description('Employee ID')).allow(null),
            sorting: Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)'),
            field: Joi.string().max(50).optional().allow(null).description('Field for sorting'),
            offset: Joi.number().integer().optional().allow(null),
            limit: Joi.number().integer().optional().allow(null),
        };
    }

    schemaCalls() {
        return {
            DateFrom: Joi.date().iso().required(),
            DateTo: Joi.date().iso().required(),
        };
    };

    schemaStatus() {
        return {
            DateFrom: Joi.date().iso().required(),
            DateTo: Joi.date().iso().required(),
            dbID: Joi.number().integer().allow(null),
            ffID: Joi.number().integer().allow(null),
            actualStatus: Joi.number().integer().allow(null),
        };
    };
}

module.exports = emEmploySchema;