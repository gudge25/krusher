const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class astIVRConfigSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            id_ivr_config: Joi.number().integer().optional().allow(null),
            ivr_name: Joi.string().max(255).optional().allow(null),
            ivr_description: Joi.string().max(1000).optional().allow(null),
            record_id: Joi.string().max(250).optional().allow(null),
            enable_direct_dial: Joi.boolean().optional().allow(null),
            timeout: Joi.number().integer().optional().allow(null),
            alert_info: Joi.string().max(50).optional().allow(null),
            volume: Joi.number().integer().optional().allow(null),
            invalid_retries: Joi.number().integer().optional().allow(null),
            retry_record_id: Joi.string().max(250).optional().allow(null),
            append_record_to_invalid: Joi.boolean().optional().allow(null),
            return_on_invalid: Joi.boolean().optional().allow(null),
            invalid_record_id: Joi.string().max(250).optional().allow(null),
            invalid_destination: Joi.number().integer().optional().allow(null),
            invalid_destdata: Joi.number().integer().optional().allow(null),
            invalid_destdata2: Joi.string().max(100).optional().allow(null),
            timeout_retries: Joi.number().integer().optional().allow(null),
            timeout_retry_record_id: Joi.string().max(250).optional().allow(null),
            append_record_on_timeout: Joi.boolean().optional().allow(null),
            return_on_timeout:Joi.boolean().optional().allow(null),
            timeout_record_id: Joi.string().max(250).optional().allow(null),
            timeout_destination: Joi.number().integer().optional().allow(null),
            timeout_destdata: Joi.number().integer().optional().allow(null),
            timeout_destdata2: Joi.string().max(100).optional().allow(null),
            return_to_ivr_after_vm: Joi.boolean().optional().allow(null),
            ttsID: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            isActive: Joi.boolean().optional().allow(null).description('Is this record Active?!')
        };

        const name = 'IVRConfig';
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

    schemaInsert() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        delete obj.record_id;
        delete obj.retry_record_id;
        delete obj.invalid_record_id;
        delete obj.timeout_retry_record_id;
        delete obj.timeout_record_id;
        obj.record_id = Joi.array().items(Joi.number().integer().allow(null)).allow(null);
        obj.retry_record_id = Joi.array().items(Joi.number().integer().allow(null)).allow(null);
        obj.invalid_record_id = Joi.array().items(Joi.number().integer().allow(null)).allow(null);
        obj.timeout_retry_record_id = Joi.array().items(Joi.number().integer().allow(null)).allow(null);
        obj.timeout_record_id = Joi.array().items(Joi.number().integer().allow(null)).allow(null);
        return obj;
    }

    schemaUpdate() {
        let obj = Object.assign({}, this.schema);
        delete obj.record_id;
        delete obj.retry_record_id;
        delete obj.invalid_record_id;
        delete obj.timeout_retry_record_id;
        delete obj.timeout_record_id;
        obj.record_id = Joi.array().items(Joi.number().integer().allow(null)).allow(null);
        obj.retry_record_id = Joi.array().items(Joi.number().integer().allow(null)).allow(null);
        obj.invalid_record_id = Joi.array().items(Joi.number().integer().allow(null)).allow(null);
        obj.timeout_retry_record_id = Joi.array().items(Joi.number().integer().allow(null)).allow(null);
        obj.timeout_record_id = Joi.array().items(Joi.number().integer().allow(null)).allow(null);
        return obj;
    }
}

module.exports = astIVRConfigSchema;