/*jshint node:true*/
'use strict';
const model = require('./fmQuestionSchema');

function fmQuestionValidate() {}
fmQuestionValidate.prototype = (() => {
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
        delete: {
            params: (() => {
                const schema = new model().schema;
                return {
                    qID: schema.qID
                };
            })()
        },
        findReport: {
            payload: (() => {
                const schema = new model().schemaReport();
                return schema;
            })()
        },
    };
})();
const validate = new fmQuestionValidate();
module.exports = validate;
