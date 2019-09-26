/*jshint node:true*/
'use strict';
const Joi = require('joi');
const model = require('./sfInvoiceItemSchema');

function sfInvoiceItemValidate() {}
sfInvoiceItemValidate.prototype = (() => {
    return {
        findPost: {
            payload: (() => new model().schemaFindPost() )()
        },
        insert: {
            payload: (() => {
                const schema = new model().schema;
                delete schema.HIID;
                return schema;
            })()
        },
        update: {
            payload: (() => new model().schema )()
        },
        delete: {
            params: {
                iiID: Joi.number().integer().required()
            }
        }
    };
})();

const validate = new sfInvoiceItemValidate();
module.exports = validate;
