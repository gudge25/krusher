const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');

class emClientSchema extends BaseSchema {
    constructor() {
        const schema = {
            HIID: Joi.number().integer().required(),
            LoginName: Joi.string().max(30).optional().allow(null).description('User login'),
            Pass: Joi.string().max(100).optional().allow(null).description('User password'),
            Domain: Joi.string().max(250).optional().allow(null).description('url'),
            IP: Joi.string().max(250).optional().allow(null).description('IP'),
            Port: Joi.number().integer().optional().allow(null).description('port'),
            Phone: Joi.number().integer().optional().allow(null).description('contact phone'),
            mPhone: Joi.number().integer().optional().allow(null).description('mobile phone'),
            Email: Joi.string().max(255).optional().allow(null).description('email for into'),
            EmailTech: Joi.string().max(255).optional().allow(null).description('email for tech messages'),
            EmailFinance: Joi.string().max(255).optional().allow(null).description('email for finance messages'),
            htID: Joi.number().integer().optional().allow(null).description('ID of tarrification'),
            aName: Joi.string().max(255).optional().allow(null).description('Company name'),
            сName: Joi.string().max(255).optional().allow(null).description('Contact name'),
            curID: Joi.number().integer().optional().allow(null).description('currency ID'),
            isActive: Joi.boolean().optional().allow(null).description('Is this record Active?!')
        };

        const name = 'Clients';
        const params = { schema, name };
        super(params);
    }

    schemaFindPost() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        delete obj.LoginName;
        delete obj.Pass;
        delete obj.Domain;
        delete obj.IP;
        delete obj.Port;
        delete obj.Phone;
        delete obj.mPhone;
        delete obj.Email;
        delete obj.EmailTech;
        delete obj.EmailFinance;
        delete obj.htID;
        delete obj.aName;
        delete obj.сName;
        delete obj.curID;
        delete obj.isActive;
        obj.Aid   = Joi.number().integer().optional().allow(null);
        return obj;
    }

    schemaInsert() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        return obj;
    }

}

module.exports = emClientSchema;