const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class astScenarioSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            id_scenario: Joi.number().integer().optional().allow(null),
            name_scenario: Joi.string().max(500).optional().allow(null),
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
            IsRecallForSuccess: Joi.boolean().optional().allow(null),
            IsCallToOtherClientNumbers: Joi.boolean().optional().allow(null),
            IsCheckCallFromOther: Joi.boolean().optional().allow(null),
            AllowPrefix: Joi.array().items(Joi.number().integer().allow(null)).description('Prefixes').allow(null),
            destination: Joi.number().integer().optional().allow(null),
            destdata: Joi.number().integer().optional().allow(null),
            destdata2: Joi.string().max(100).optional().allow(null),
            target: Joi.string().max(50000).optional().allow(null),
            roIDs: Joi.array().items(Joi.number().integer().allow(null)).description('Routes ID').allow(null),
            isFirstClient: Joi.boolean().optional().allow(null),
            limitChecker: Joi.number().integer().optional().allow(null),
            limitStatuses: Joi.array().items(Joi.number().integer().allow(null)).description('Statues ID for check').allow(null),
            isActive: Joi.boolean().optional().allow(null)
        };

        const name = 'Scenario';
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
}

module.exports = astScenarioSchema;
