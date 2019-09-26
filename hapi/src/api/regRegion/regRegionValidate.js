/*jshint node:true*/
'use strict';
const model = require('./regRegionSchema');

function regRegionValidate() {}
regRegionValidate.prototype = (() => {
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
                    rgID: schema.rgID
                };
            })()
        },
    };
})();

const validate = new regRegionValidate();
module.exports = validate;
