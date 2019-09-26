/*jshint node:true*/
'use strict';
const model = require('./fmQuestionItemSchema');

function fmQuestionItemValidate() {}
fmQuestionItemValidate.prototype = (() => {
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
                    qiID: schema.qiID
                };
            })()
        },
        findReport: {
            payload: (() => new model().schemaReport() )()
        },
    };
})();
const validate = new fmQuestionItemValidate();
module.exports = validate;
