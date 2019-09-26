/*jshint node:true*/
'use strict';
const Joi = require('joi');
const model = require('./usCommentSchema');

function usCommentValidate() {}
usCommentValidate.prototype = (() => {
    return {
        findPost: {
            payload: (() => new model().schemaFindPost() )()
        },
        insert: {
            payload: (() => {
                const schema = new model().schema;
                delete schema.id;
                delete schema.HIID;
                return schema;
            })()
        },
        delete: {
            params: {
                id: Joi.number().integer()
            }
        },
    };
})();
const validate = new usCommentValidate();
module.exports = validate;
