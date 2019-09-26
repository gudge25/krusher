const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class astConferenceSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            cfID: Joi.number().integer().optional().allow(null),
            cfName: Joi.string().max(250).optional().allow(null),
            cfDesc: Joi.string().max(500).optional().allow(null),
            userPin: Joi.number().integer().optional().allow(null),
            adminPin: Joi.number().integer().optional().allow(null),
            langID: Joi.number().integer().optional().allow(null),
            record_id: Joi.number().integer().optional().allow(null),
            leaderWait: Joi.boolean().optional().allow(null),
            leaderLeave: Joi.boolean().optional().allow(null),
            talkerOptimization: Joi.boolean().optional().allow(null),
            talkerDetection: Joi.boolean().optional().allow(null),
            quiteMode: Joi.boolean().optional().allow(null),
            userCount: Joi.boolean().optional().allow(null),
            userJoinLeave: Joi.boolean().optional().allow(null),
            moh: Joi.boolean().optional().allow(null),
            mohClass: Joi.number().integer().optional().allow(null),
            allowMenu: Joi.boolean().optional().allow(null),
            recordConference: Joi.boolean().optional().allow(null),
            maxParticipants: Joi.number().integer().optional().allow(null),
            muteOnJoin: Joi.boolean().optional().allow(null),
            isActive: Joi.boolean().optional().allow(null)
        };

        const name = 'Conference';
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

module.exports = astConferenceSchema;
