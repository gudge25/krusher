/*jshint node:true*/
'use strict';
const model = require('./astAutodialProcessSchema');

function astAutodialProcessValidate() {}
astAutodialProcessValidate.prototype = (() => {

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
                    id_autodial: schema.id_autodial
                };
            })()
        },
        Autocall: (() => {
            return {
                payload: (() => new model().schemaAutocall() )()
            };
        })()
    };
})();
const validate = new astAutodialProcessValidate();
module.exports = validate;