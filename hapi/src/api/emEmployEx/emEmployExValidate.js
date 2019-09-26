/*jshint node:true*/
'use strict';
const model = require('./emEmployExSchema');

function emEmployExValidate() {}
emEmployExValidate.prototype = (() => {
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
                    emID: schema.emID
                };
            })()
        },
    };
})();

const validate = new emEmployExValidate();
module.exports = validate;
