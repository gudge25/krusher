/*jshint node:true*/
'use strict';
const model = require('./astTimeGroupItemsSchema');

function astTimeGroupItemsValidate() {}
astTimeGroupItemsValidate.prototype = (() => {

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
                    tgiID: schema.tgiID
                };
            })()
        },
    };
})();

const validate = new astTimeGroupItemsValidate();
module.exports = validate;
