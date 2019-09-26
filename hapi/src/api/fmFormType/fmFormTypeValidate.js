/*jshint node:true*/
'use strict';
const model = require('./fmFormTypeSchema');

function fmFormTypeValidate() {}
fmFormTypeValidate.prototype = (() => {
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
                    tpID: schema.tpID
                };
            })()
        },
    };
})();
const validate = new fmFormTypeValidate();
module.exports = validate;
