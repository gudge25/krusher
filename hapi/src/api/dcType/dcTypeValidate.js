/*jshint node:true*/
'use strict';
const model = require('./dcTypeSchema');

function dcTypeValidate() {}
dcTypeValidate.prototype = (() => {
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
                    dctID: schema.dctID
                };
            })()
        },
    };
})();

const validate = new dcTypeValidate();
module.exports = validate;
