/*jshint node:true*/
'use strict';
const model = require('./astMonitoringSchema');

function astMonitoringValidate() {}
astMonitoringValidate.prototype = (() => {

    return {
        insert: {
            payload: (() => {
                const schema = new model().schema;
                return schema;
            })()
        },
        findPost: {
            payload: (() => new model().schemaFindPost() )()
        }
    };
})();
const validate = new astMonitoringValidate();
module.exports = validate;
