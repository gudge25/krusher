const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class dcDocTemplateSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID: Joi.number().integer().optional().allow(null),
            dtID: Joi.number().integer().optional().allow(null),
            dtName: Joi.string().max(100).optional().trim().allow(null),
            dcTypeID: Joi.number().integer().optional().allow(null),
            dtTemplate: Joi.string().optional().allow(null),
            isDefault: Joi.bool().optional().allow(null),
            isActive: Joi.bool().optional().allow(null),
        };
        
        const name = 'DocTemplate';
        const params = { schema, name };
        super(params)
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

module.exports = dcDocTemplateSchema;
