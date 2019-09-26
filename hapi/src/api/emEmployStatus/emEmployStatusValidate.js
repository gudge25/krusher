/*jshint node:true*/
'use strict';
const model = require('./emEmployStatusSchema');

function emEmployStatusValidate() {}
emEmployStatusValidate.prototype = (() => {
    return {
        /*findPost: {
            payload: (() => new model().schemaFindPost() )()
        },
        insert: {
            payload: (() => {
                const schema = new model().schema;
                delete schema.HIID;
                return schema;
            })()
        },*/
        stat: {
            payload: (() => new model().schemaStat() )()
        },
    };
})();

const validate = new emEmployStatusValidate();
module.exports = validate;
