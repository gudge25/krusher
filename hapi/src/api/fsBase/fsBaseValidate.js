/*jshint node:true*/
'use strict';
const Joi = require('joi');
const model = require('./fsBaseSchema');

function fsBaseValidate() {}
fsBaseValidate.prototype = (() => {
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
            params: (() => {
                const schema = new model().schema;
                return {
                    dbID: schema.dbID
                };
            })()
        },
        sabd: {
            params: (() => {
                return null;
            })()
        },
        sabdDetail: {
            params: {
                ffID: Joi.number().integer().required()
            }
        }
    };
})();

const validate = new fsBaseValidate();
module.exports = validate;
