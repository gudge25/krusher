/*jshint node:true*/
'use strict';
const model = require('./emRoleSchema');

function emRoleValidate() {}
emRoleValidate.prototype = (() => {
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
                    roleID: schema.roleID
                };
            })()
        },
    };
})();
const validate = new emRoleValidate();
module.exports = validate;
