/*jshint node:true*/
'use strict';
const Joi = require('joi');
const model = require('./ccContactSchema');

function ccContactValidate() {}
ccContactValidate.prototype = (() => {

    return {
        find: {
            payload: (() => new model().schemaFind() )()
        },
        fileExportRecords: {
            payload: (() => new model().schemaFindRecords() )()
        },
        fileExportRecordsList: {
            payload: (() => new model().schemaRecordsList() )()
        },
        deleteExportRecords: {
            params: (() => new model().schemaRecordsListDelete() )()
        },
        fileExport: {
            payload: (() => new model().schemaFindExport() )()
        },
        forSip: {
            params: (() => {
                return {
                    sip: Joi.string().max(50).required()
                };
            })()
        },
        billReport: {
            params: (() => {
                return {
                    dateTo: Joi.string().isoDate().required()
                };
            })()
        },
        CallerManager: {
            params: (() => {
                return {
                    callerID: Joi.string().max(50).required(),
                    type: Joi.number().integer().required(),
                    Aid: Joi.number().integer().required(),
                };
            })()
        },
        dailyHour: {
            payload: (() => new model().schemadailyHour() )()
        },
        dailyHourExport: {
            payload: (() => new model().schemadailyHour() )()
        },
        dailyCalls: {
            payload: (() => new model().schemadailyCalls() )()
        },
        dailyCallsExport: {
            payload: (() => new model().schemadailyCalls() )()
        },
        dailyStatuses: {
            payload: (() => new model().schemadailyStatuses() )()
        },
        dailyStatusesExport: {
            payload: (() => new model().schemadailyStatuses() )()
        },
        dailyReport: {
            payload: (() => new model().schemadailyReport() )()
        },
        dailyReportExport: {
            payload: (() => new model().schemadailyReport() )()
        },
        delete: {
            params: (() => {
                const schema = new model().schema;
                return {
                    dcID: schema.dcID
                };
            })()
        },
        insert: {
            payload: (() => new model().schemaInsert() )()
        },
        update: {
            payload: (() => new model().schemaUpdate() )()
        },
        getMissed: {
            payload: (() => new model().schemaGetMissed() )()
        },
    };
})();

const validate = new ccContactValidate();
module.exports = validate;