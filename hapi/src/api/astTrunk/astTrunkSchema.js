const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class astTrunkSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            trID : Joi.number().integer().optional().allow(null),
            trName : Joi.string().max(50).optional().allow(null),
            template : Joi.string().max(50).optional().allow(null),
            secret : Joi.string().max(50).optional().allow(null),
            context : Joi.string().max(50).optional().allow(null),
            callgroup : Joi.number().integer().positive().optional().allow(null),
            pickupgroup : Joi.number().integer().positive().optional().allow(null),
            callerid: Joi.string().max(80).optional().allow(null),
            host: Joi.string().max(80).optional().allow(null),
            nat: Joi.number().integer().optional().allow(null),
            defaultuser: Joi.string().max(40).optional().allow(null),
            fromuser: Joi.string().max(40).optional().allow(null),
            fromdomain: Joi.string().max(40).optional().allow(null),
            callbackextension: Joi.string().max(40).optional().allow(null),
            port : Joi.number().integer().optional().allow(null),
            isServer: Joi.boolean().optional().allow(null),
            type : Joi.number().integer().optional().allow(null),
            directmedia : Joi.number().integer().optional().allow(null),
            insecure : Joi.number().integer().optional().allow(null),
            outboundproxy: Joi.string().max(60).optional().allow(null),
            acl: Joi.string().max(60).optional().allow(null),
            dtmfmode: Joi.number().integer().optional().allow(null),
            lines: Joi.number().integer().optional().allow(null),
            DIDs: Joi.string().max(250).optional().allow(null),
            ManageID: Joi.number().integer().optional().allow(null),
            coID: Joi.number().integer().optional().allow(null),
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
            isActive: Joi.boolean().optional().allow(null)
        };

        const name = 'Trunk';
        const params = { schema, name };
        super(params);
    }

    schemaInsert() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        delete obj.DIDs;
        obj.DIDs = Joi.array().items(Joi.string().max(16).allow(null)).allow(null);
        return obj;
    }

    schemaUpdate() {
        let obj = Object.assign({}, this.schema);
        delete obj.DIDs;
        obj.DIDs = Joi.array().items(Joi.string().max(16).allow(null)).allow(null);
        return obj;
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
}

module.exports = astTrunkSchema;