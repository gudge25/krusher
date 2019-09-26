const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class astSippeersSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            sipID : Joi.number().integer().optional().allow(null),
            sipName : Joi.string().max(50).optional().allow(null),
            template : Joi.string().max(50).optional().allow(null),
            secret : Joi.string().max(50).optional().allow(null),
            context : Joi.string().max(50).optional().allow(null),
            callgroup : Joi.number().integer().optional().allow(null),
            pickupgroup : Joi.number().integer().optional().allow(null),
            callerid: Joi.string().max(80).optional().allow(null),
            nat: Joi.number().integer().optional().allow(null),
            lines: Joi.number().integer().optional().allow(null),
            dtmfmode: Joi.number().integer().optional().allow(null),
            emID: Joi.number().integer().optional().allow(null),
            transport: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            encryption: Joi.boolean().optional().allow(null),
            avpf: Joi.boolean().optional().allow(null),
            force_avp: Joi.boolean().optional().allow(null),
            icesupport: Joi.boolean().optional().allow(null),
            videosupport: Joi.boolean().optional().allow(null),
            allow: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            dtlsenable: Joi.boolean().optional().allow(null),
            dtlsverify: Joi.boolean().optional().allow(null),
            dtlscertfile: Joi.string().max(100).optional().allow(null),
            dtlscafile: Joi.string().max(100).optional().allow(null),
            dtlssetup: Joi.string().max(100).optional().allow(null),
            isPrimary: Joi.boolean().optional().allow(null),
            sipType: Joi.number().integer().optional().allow(null),
            isActive: Joi.boolean().optional().allow(null)
        };

        const name = 'Sippeers';
        const params = { schema, name };
        super(params);
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

module.exports = astSippeersSchema;