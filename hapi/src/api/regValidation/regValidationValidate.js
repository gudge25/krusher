/*jshint node:true*/
'use strict';
const model = require('./regValidationSchema');

function regValidationValidate() {}
regValidationValidate.prototype = (() => {
    return {
        findPost: {
            payload: (() => new model().schemaFindPost() )()
        },
        checkPhone: {
            payload: (() => new model().schemaСheckPhone() )()
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
                    vID: schema.vID
                };
            })()
        },
    };
})();

const validate = new regValidationValidate();
module.exports = validate;
