/*jshint node:true*/
'use strict';
const Joi = require('joi');
const model = require('./slDealSchema');

function slDealValidate() {}
slDealValidate.prototype = (() => {
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
        findChart: {
            payload: (() => {
                const schema = new model().schemaChart();
                return schema;
            })()
        },
        update: {
            payload: (() => new model().schema )()
        },
        delete: {
            params: {
                dcID: Joi.number().integer().required()
            }
        },
        insByStatus: {
            payload: (() => {
                const schema = new model().schemaByStatus();
                return schema;
            })()
        },
    };
})();

const validate = new slDealValidate();
module.exports = validate;
