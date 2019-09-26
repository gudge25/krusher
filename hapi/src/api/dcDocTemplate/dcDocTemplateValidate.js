/*jshint node:true*/
'use strict';
const model = require('./dcDocTemplateSchema');

function dcDocTemplateValidate() {}
dcDocTemplateValidate.prototype = (() => {
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
                  dtID: schema.dtID
              };
            })()
        },
    };
})();

const validate = new dcDocTemplateValidate();
module.exports = validate;
