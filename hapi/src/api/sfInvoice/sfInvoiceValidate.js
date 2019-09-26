/*jshint node:true*/
'use strict';
const model = require('./sfInvoiceSchema');

function sfInvoiceValidate() {}
sfInvoiceValidate.prototype = (() => {
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
    };
})();

const validate = new sfInvoiceValidate();
module.exports = validate;
