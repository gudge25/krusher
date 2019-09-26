/*jshint node:true*/
'use strict';
const model = require('./regOperatorSchema');

function regOperatorValidate() {}
regOperatorValidate.prototype = (() => {
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
                    oID: schema.oID
                };
            })()
        },
    };
})();

const validate = new regOperatorValidate();
module.exports = validate;
