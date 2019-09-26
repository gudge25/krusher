/*jshint node:true*/
'use strict';
const model = require('./regLocationSchema');

function regLocationValidate() {}
regLocationValidate.prototype = (() => {
    return {
        findPost: {
            payload: (() => new model().schemaFindPost() )()
        },
        /*insert: {
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
                    lID: schema.lID
                };
            })()
        },*/
    };
})();

const validate = new regLocationValidate();
module.exports = validate;
