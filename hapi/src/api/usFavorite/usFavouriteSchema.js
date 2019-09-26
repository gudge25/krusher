const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class usFavouriteSchema extends BaseSchema {
    constructor() {
        const schema = {
            uID: Joi.string().max(20).optional().allow(null),
            faComment: Joi.string().max(200).allow(null),
            isActive: Joi.boolean().optional().allow(null)
        };

        const name = 'usFavourites';
        const params = { schema, name };
        super(params);
    }

    schemaFindPost() {
        let obj = Object.assign({}, this.schema);
        obj.faID = Joi.number().integer().optional().allow(null);
        obj.faModel = Joi.string().max(20).optional().allow(null);
        obj.faInfo = Joi.string().max(200).optional().allow(null);
        obj.sorting = Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)');
        obj.field   = Joi.string().max(50).optional().allow(null).description('Field for sorting');
        obj.offset  = Joi.number().integer().optional().allow(null);
        obj.limit   = Joi.number().integer().optional().allow(null);
        return obj;
    }

}

module.exports = usFavouriteSchema;