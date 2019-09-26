/*jshint node:true*/
'use strict';
const Joi = require('joi');
const model = require('./dcDocSchema');

function dcDocValidate() {}
dcDocValidate.prototype = (() => {
    return {
        findPost: {
            payload: (() => new model().schemaFindPost() )()
        },
        findStream: {
            params: {
                emID: Joi.number().integer()
            }
        },
        findByClient: {
            payload: (() => new model().schemaFindByCLient() )()
        },
    };
})();

const validate = new dcDocValidate();
module.exports = validate;
