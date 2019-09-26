/*jshint node:true*/
'use strict';
const model = require('./fmFormSchema');

function fmFormValidate() {}
fmFormValidate.prototype = (() => {
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
                    dcID: schema.dcID
                };
            })()
        },
        formExport: {
            payload: (() => new model().schemaExport() )()
        },
    };
})();

const validate = new fmFormValidate();
module.exports = validate;
