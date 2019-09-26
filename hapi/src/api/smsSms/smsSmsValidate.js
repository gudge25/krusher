/*jshint node:true*/
'use strict';
const model = require('./smsSmsSchema');

function smsSmsValidate() {}
smsSmsValidate.prototype = (() => {

    return {
        /*findPost: {
            payload: (() => new model().schemaFindPost() )()
        },*/
        insert: {
            payload: (() => new model().schemaInsert() )()
        },
        incomingGoip: {
            payload: (() => new model().schemaGoipIncoming() )()
        },
        insertBulk: {
            payload: (() => new model().schemaInsertBulk() )()
        },
        updateBulk: {
            payload: (() => new model().schemaUpdateBulk() )()
        },
        findBulk: {
            payload: (() => new model().schemaFindBulkPost() )()
        },
        deleteBulk: {
            params: (() => {
                const schema = new model().schemaFindBulkPost();
                return {
                    bulkID: schema.bulkID
                };
            })()
        },
    };
})();

const validate = new smsSmsValidate();
module.exports = validate;
