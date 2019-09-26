/*jshint node:true, esnext:true*/
'use strict';

const Joi = require('joi');
class BaseSchema {
    constructor(params) {
        this.schema = params.schema;
        this.name = params.name;

        this.Error = Joi.object({
            "statusCode": Joi.number().integer().required().default(400),
            "error": Joi.string().min(3).required().description('Type of error').default('Bad Request'),
            "message": Joi.string().min(3).required().description('Human readable error'),
            "validation": Joi.object()
        }).label('Error');
    }
    schemaFindByID() {
        const obj = Object.assign({}, this.schema);
        return obj;
    }
    schemaFindPost() {
        const obj = Object.assign({}, this.schemaFindPost);
        return obj;
    }
    schemaFind() {
        const obj = Object.assign({}, this.schema);
        return obj;
    }
    schemaInsert() {
        const obj = Object.assign({}, this.schema);
        delete obj.HIID;
        return obj;
    }
    schemaUpdate() {
        const obj = Object.assign({}, this.schema);
        return obj;
    }
    schemaLookup() {
        const obj = Object.assign({}, this.schema);
        return obj;
    }
}

module.exports = BaseSchema;
