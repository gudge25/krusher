/*jshint node:true*/
'use strict';
const model = require('./regAreaSchema');

function regAreaValidate() {}
regAreaValidate.prototype = (() => {
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
                    aID: schema.aID
                };
            })()
        },
    };
})();

const validate = new regAreaValidate();
module.exports = validate;
