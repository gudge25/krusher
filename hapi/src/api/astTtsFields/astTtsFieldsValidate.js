/*jshint node:true*/
'use strict';
const model = require('./astTtsFieldsSchema');

function astTtsFieldsValidate() {
}

astTtsFieldsValidate.prototype = (() => {
    return {
        findPost: {
            payload: (() => new model().schemaFindPost())()
        },
        insert: {
            payload: (() => {
                const schema = new model().schema;
                delete schema.HIID;
                return schema;
            })()
        },
        update: {
            payload: (() => new model().schema)()
        },
        delete: {
            params: (() => {
                const schema = new model().schema;
                return {
                    ttsfID: schema.ttsfID
                };
            })()
        },
    };
})();

const validate = new astTtsFieldsValidate();
module.exports = validate;
