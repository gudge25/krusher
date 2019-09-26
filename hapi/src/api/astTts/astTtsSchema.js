const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class astTtsSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID : Joi.number().integer().optional().allow(null),
            ttsID : Joi.number().integer().optional().allow(null),
            ttsName : Joi.string().max(50).optional().allow(null),
            ttsText : Joi.string().optional().allow(null),
            settings : Joi.object(),
            engID : Joi.number().integer().optional().allow(null),
            ttsFields: Joi.array().items(Joi.number().integer().allow(null)).allow(null),
            recIDBefore : Joi.string().max(250).optional().allow(null),
            recIDAfter : Joi.string().max(250).optional().allow(null),
            yandexApikey : Joi.string().max(250).optional().allow(null),
            yandexEmotion : Joi.number().integer().optional().allow(null),
            yandexEmotions : Joi.string().max(250).optional().allow(null),
            yandexFast: Joi.boolean().optional().allow(null),
            yandexGenders: Joi.string().max(250).optional().allow(null),
            yandexLang: Joi.string().max(250).optional().allow(null),
            yandexSpeaker: Joi.string().max(250).optional().allow(null),
            yandexSpeakers: Joi.string().max(250).optional().allow(null),
            yandexSpeed: Joi.number().optional().allow(null),
            isActive: Joi.boolean().optional().allow(null)
        };

        const name = 'TTS settings';
        const params = { schema, name };
        super(params);
    }

    schemaInsert() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        delete obj.recIDBefore;
        delete obj.recIDAfter;
        obj.recIDBefore = Joi.array().items(Joi.number().integer().allow(null)).allow(null);
        obj.recIDAfter = Joi.array().items(Joi.number().integer().allow(null)).allow(null);
        return obj;
    }

    schemaUpdate() {
        let obj = Object.assign({}, this.schema);
        delete obj.recIDBefore;
        delete obj.recIDAfter;
        obj.recIDBefore = Joi.array().items(Joi.number().integer().allow(null)).allow(null);
        obj.recIDAfter = Joi.array().items(Joi.number().integer().allow(null)).allow(null);
        return obj;
    }

    schemaFindPost() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        delete obj.ttsText;
        delete obj.settings;
        delete obj.recIDBefore;
        delete obj.recIDAfter;
        delete obj.yandexApikey;
        delete obj.yandexEmotion;
        delete obj.yandexEmotions;
        delete obj.yandexFast;
        delete obj.yandexGenders;
        delete obj.yandexLang;
        delete obj.yandexSpeaker;
        delete obj.yandexSpeakers;
        delete obj.yandexSpeed;
        obj.sorting = Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)');
        obj.field = Joi.string().max(50).optional().allow(null).description('Field for sorting');
        obj.offset  = Joi.number().integer().optional().allow(null);
        obj.limit   = Joi.number().integer().optional().allow(null);
        return obj;
    }
}

module.exports = astTtsSchema;