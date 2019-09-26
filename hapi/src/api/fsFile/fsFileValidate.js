/*jshint node:true*/
'use strict';
const Joi = require('joi');
const model = require('./fsFileSchema');

function fsFileValidate() {}
fsFileValidate.prototype = (() => {
    return {
        findPost: {
            payload: (() => new model().schemaFindPost() )()
        },
        updStatus: {
            params: {
                ffID: Joi.number().integer().required()
            }
        },
        fileExport: {
            params: {
                ffID: Joi.number().integer().required()
            }
        },
        detail: {
            payload: (() => {
                const schema = new model().schemaDetail();
                return schema;
            })()
        },
        insert: {
            payload: (() => new model().schemaInsert() )()
        },
        insertForce: {
            payload: (() => new model().schemaInsertForce())()
        },
        update: {
            payload: (() => new model().schema )()
        },
        delete: {
            params: {
                ffID: Joi.number().integer().required()
            }
        },
        bulkdel: {
            params: {
                ffID: Joi.number().integer().required()
            }
        },
        findByID: {
            params: {
                ffID: Joi.number().integer().required()
            }
        },

    };
})();

const validate = new fsFileValidate();
module.exports = validate;
