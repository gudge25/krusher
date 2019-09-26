const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class astRecallSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            rcID: Joi.number().integer().optional().allow(null),
            rcName: Joi.string().max(500).optional().allow(null),
            callerID: Joi.string().max(50).optional().allow(null),
            TimeBegin: Joi.string().max(500).optional().allow(null),
            TimeEnd: Joi.string().max(500).optional().allow(null),
            DaysCall: Joi.string().max(500).optional().allow(null),
            RecallCount: Joi.number().integer().optional().allow(null),
            RecallAfterMin: Joi.number().integer().optional().allow(null),
            RecallCountPerDay: Joi.number().integer().optional().allow(null),
            RecallDaysCount: Joi.number().integer().optional().allow(null),
            RecallAfterPeriod: Joi.number().integer().optional().allow(null),
            AutoDial: Joi.string().max(100).optional().allow(null),
            IsCallToOtherClientNumbers: Joi.boolean().optional().allow(null),
            IsCheckCallFromOther: Joi.boolean().optional().allow(null),
            AllowPrefix: Joi.array().items(Joi.number().integer().allow(null)).description('Prefixes').allow(null),
            destination: Joi.number().integer().optional().allow(null),
            destdata: Joi.number().integer().optional().allow(null),
            destdata2: Joi.string().max(100).optional().allow(null),
            target: Joi.string().max(50000).optional().allow(null),
            roIDs: Joi.array().items(Joi.number().integer().allow(null)).description('Routes ID').allow(null),
            isFirstClient: Joi.boolean().optional().allow(null),
            isResponsible: Joi.boolean().optional().allow(null),
            statusMessage: Joi.string().max(50000).optional().allow(null),
            type: Joi.number().integer().optional().allow(null),
            isActive: Joi.boolean().optional().allow(null)
        };

        const name = 'Recall';
        const params = { schema, name };
        super(params);
    }

    schemaFindPost() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        delete obj.statusMessage;
        obj.sorting = Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)');
        obj.field   = Joi.string().max(50).optional().allow(null).description('Field for sorting');
        obj.offset  = Joi.number().integer().optional().allow(null);
        obj.limit   = Joi.number().integer().optional().allow(null);
        return obj;
    }

    schemaRecall() {
        const obj = Object.assign({}, this.schema);
        return {
            "qtyContact": Joi.number().integer().optional().allow(null)
        };
    }
}

module.exports = astRecallSchema;
