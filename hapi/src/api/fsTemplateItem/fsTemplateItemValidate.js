/*jshint node:true*/
'use strict';
const Joi = require('joi');
const model = require('./fsTemplateItemSchema');

function fsTemplateItemValidate() {}
fsTemplateItemValidate.prototype = (() => {
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
                ftiID: Joi.number().integer().required()
            }
        }
    };
})();

const validate = new fsTemplateItemValidate();
module.exports = validate;
