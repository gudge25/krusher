/*jshint node:true*/
'use strict';
const Joi = require('joi');
const model = require('./slDealItemSchema');

function slDealItemValidate() {}
slDealItemValidate.prototype = (() => {
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
                diID: Joi.number().integer().required()
            }
        }
    };
})();

const validate = new slDealItemValidate();
module.exports = validate;
