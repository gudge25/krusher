 const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class crmClientExSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            clID: Joi.number().integer().optional().allow(null),
            CallDate: Joi.string().isoDate().optional().allow(null),
            isNotice: Joi.bool().optional().allow(null),
            isRobocall: Joi.bool().optional().allow(null),
            isCallback: Joi.bool().optional().allow(null),
            isDial: Joi.bool().optional().allow(null),
            curID: Joi.number().integer().optional().allow(null),
            langID: Joi.number().integer().optional().allow(null),
            sum: Joi.number().precision(2).optional().allow(null),
            ttsText: Joi.string().max(5000).optional().allow(null),
            isActive: Joi.bool().optional().allow(null),
        };

        const name = 'crmClientEx';
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

    schemaSetDial() {
        let obj = Object.assign({}, this.schema);
        delete obj.CallDate;
        delete obj.isDial;
        delete obj.isNotice;
        delete obj.isRobocall;
        delete obj.isCallback;
        delete obj.isActive;
        delete obj.langID;
        delete obj.curID;
        delete obj.sum;
        delete obj.HIID;
        delete obj.ttsText;
        obj.isdial  = Joi.bool().optional().allow(null);
        return obj;
    }
}

module.exports = crmClientExSchema;