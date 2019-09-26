/*jshint node:true*/
'use strict';
const model = require('./pchPaymentSchema');

function pchPaymentValidate() {}
pchPaymentValidate.prototype = (() => {
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

const validate = new pchPaymentValidate();
module.exports = validate;
