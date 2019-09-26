/*jshint node:true*/
'use strict';
const BaseConfig = require('src/base/BaseConfig');
const handlers = require('./ccContactHandler');
const validate = require('./ccContactValidate');
const ccContactSchema = require('./ccContactSchema');

function ccContactConfig() {
    const schema = new ccContactSchema();
    const params = { validate, handlers, schema };
    const self = new BaseConfig(params);
    self.find = {
        handler: handlers.find,
        description: 'Find Calling Card by any field',
        tags: ['api'],
        validate: validate.find
    };
    self.fileExport = {
        handler: handlers.fileExport,
        description: 'Export calling cards',
        tags: ['api', 'fs', 'files'],
        validate: validate.fileExport
    };
    self.fileExportRecords = {
        handler: handlers.fileExportRecords,
        description: 'Export calling cards records',
        tags: ['api'/*, 'fs', 'files'*/],
        validate: validate.fileExportRecords
    };
    self.fileExportRecordsList = {
        handler: handlers.fileExportRecordsList,
        description: 'Export calling cards records',
        tags: ['api'/*, 'fs', 'files'*/],
        validate: validate.fileExportRecordsList
    };
    self.deleteExportRecords = {
        handler: handlers.deleteExportRecords,
        description: 'Delete',
        tags: ['api'],
        validate: validate.deleteExportRecords
    };
    self.forSip = {                             //нужен ли этот функционал
        handler: handlers.forSip,
        description: 'Get contact for SIP',
        tags: ['api'],
        validate: validate.forSip
    };
    self.billReport = {
        handler: handlers.billReport,
        description: 'Get the billing report',
        tags: ['api', 'fs', 'files'],
        validate: validate.billReport
    };
    self.dailyHour = {
        handler: handlers.dailyHour,
        description: 'Get the daily report',
        //tags: ['api', 'fs', 'files'],
        tags: ['api'],
        validate: validate.dailyHour
    };
    self.dailyHourExport = {
        handler: handlers.dailyHourExport,
        description: 'Export ',
        tags: ['api', 'fs', 'files'],
        validate: validate.dailyHourExport
    };
    self.dailyCalls = {
        handler: handlers.dailyCalls,
        description: 'Get the daily calls report',
        //tags: ['api', 'fs', 'files'],
        tags: ['api'],
        validate: validate.dailyCalls
    };
    self.dailyCallsExport = {
        handler: handlers.dailyCallsExport,
        description: 'Export ',
        tags: ['api', 'fs', 'files'],
        validate: validate.dailyCallsExport
    };
    self.dailyStatuses = {
        handler: handlers.dailyStatuses,
        description: 'Get the daily status report',
        //tags: ['api', 'fs', 'files'],
        tags: ['api'],
        validate: validate.dailyStatuses
    };
    self.dailyStatusesExport = {
        handler: handlers.dailyStatusesExport,
        description: 'Export ',
        tags: ['api', 'fs', 'files'],
        validate: validate.dailyStatusesExport
    };
    self.dailyReport = {
        handler: handlers.dailyReport,
        description: 'Get the daily report',
        //tags: ['api', 'fs', 'files'],
        tags: ['api'],
        validate: validate.dailyReport
    };
    self.dailyReportExport = {
        handler: handlers.dailyReportExport,
        description: 'Export ',
        tags: ['api', 'fs', 'files'],
        validate: validate.dailyReportExport
    };
    self.getDashboard = {
        handler: handlers.getDashboard,
        description: 'Showing a current information on system for current day',
        tags: ['api'],
        validate: validate.getDashboard
    };
    self.getMissed = {
        handler: handlers.getMissed,
        description: 'Showing a count of missed numbers',
        tags: ['api'],
        validate: validate.getMissed
    };
    self.CallerManager = {
        handler: handlers.CallerManager,
        description: 'Return SIP by caller ID',
        tags: ['api'],
        validate: validate.CallerManager
    };
    self.update = {
        handler: handlers.update,
        description: 'Update a calling card',
        tags: ['api'],
        validate: validate.update,
    };
    self.insert = {
        handler: handlers.insert,
        description: 'Adding a new calling card',
        tags: ['api'],
        validate: validate.insert,
    };


    return self;
}

const handler = new ccContactConfig();
module.exports = handler;