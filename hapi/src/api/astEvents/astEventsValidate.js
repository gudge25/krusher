/*jshint node:true*/
'use strict';
const model = require('./astEventsSchema');

function astEventsValidate() {}
astEventsValidate.prototype = (() => {

    return {
        insert: {
            payload: (() => new model().schemaInsert() )()
        },
        findPost: {
            payload: (() => new model().schemaFindPost() )()
        }
    };
})();
const validate = new astEventsValidate();
module.exports = validate;
