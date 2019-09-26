const Joi = require('joi');
const BaseSchema = require('src/base/BaseSchema');
const Model = require('src/base/BaseModelDoc');

class slDealSchema extends BaseSchema {
    constructor() {
        const schema = new Model.Schema();
        delete schema.dcState;
        schema.HasDocNo = Joi.string().max(35).optional().allow(null);

        const name = 'Deal';
        const params = { schema, name };

        super(params);
    }

    schemaChart() {
        return {
            clID: Joi.number().integer().optional().allow(null),
            dcStatus: Joi.number().integer().allow(null),
        };
    };

    schemaByStatus() {
        return {
            comID: Joi.number().integer().optional().allow(null),
            phone: Joi.string().required(),
            sipNum: Joi.string().required(),
            isActive: Joi.boolean().optional().allow(null).description('Is this record Active?!')
        };
    };

    schemaFindPost() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        /*delete obj.dcNo;
        delete obj.dcState;
        delete obj.dcDate;
        delete obj.dcLink;
        delete obj.dcComment;
        delete obj.dcSum;
        delete obj.dcStatus;
        delete obj.clID;
        delete obj.emID;
        delete obj.isActive;
        delete obj.HasDocNo;*/
        obj.sorting = Joi.string().max(5).optional().allow(null).description('Type of sorting (ASC or DESC)');
        obj.field   = Joi.string().max(50).optional().allow(null).description('Field for sorting');
        obj.offset  = Joi.number().integer().optional().allow(null);
        obj.limit   = Joi.number().integer().optional().allow(null);
        return obj;
    };

    schemaInsert() {
        let obj = Object.assign({}, this.schema);
        delete obj.HIID;
        return obj;
    }

    schemaUpdate() {
        let obj = Object.assign({}, this.schema);
        //delete obj.HIID;
        return obj;
    }
}

module.exports = slDealSchema;
