/*jshint node:true*/
'use strict';
const model = require('./crmClientProductSchema');

function crmClientProductValidate() {}
crmClientProductValidate.prototype = (() => {
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
                    cpID: schema.cpID
                };
            })()
        },
    };
})();
const validate = new crmClientProductValidate();
module.exports = validate;
