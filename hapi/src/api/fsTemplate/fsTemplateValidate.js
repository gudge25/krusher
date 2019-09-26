/*jshint node:true*/
'use strict';
const model = require('./fsTemplateSchema');

function fsTemplateValidate() {}
fsTemplateValidate.prototype = (() => {
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
                    ftID: schema.ftID
                };
            })()
        }
    };
})();

const validate = new fsTemplateValidate();
module.exports = validate;
