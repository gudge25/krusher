/*jshint node:true*/
'use strict';
const configs = require('./ccContactConfig');
const route = require('src/middleware/route').ccContact;

const FIND = `${route}/find`;
const FINDMISSED = `${route}/missed`;
const EXPORT = `${route}/export`;
const EXPORTRECORDS = `${route}/export/records`;
const EXPORTRECORDSLIST = `${route}/export/records/list`;
const DELEXPORTRECORDS = `${route}/export/records/{idCR}`;
const SIP = `${route}/sip/{sip}`;
const BILLING = `${route}/billing/{dateTo}`;
const DAILY = `${route}/report/daily/hours`;
const DAILYEXPORT = `${route}/report/daily/hours/export`;
const DAILYREPORT = `${route}/report/daily/analyse1`;
const DAILYREPORTEXPORT = `${route}/report/daily/analyse1/export`;
const CALLS = `${route}/report/daily/calls`;
const CALLSEXPORT = `${route}/report/daily/calls/export`;
const STATUSES = `${route}/report/daily/statuses`;
const STATUSESEXPORT = `${route}/report/daily/statuses/export`;
const DASHBOARD = `${route}/dashboard`;
const CALLER = `${route}/callerID/{callerID}/{type}/{Aid}`;
const DEL = `${route}/{dcID}`;
const PUT = `${route}`;

module.exports = (() =>
    [
            { method: 'POST', 	path: route, 	                config: configs.insert },
            { method: 'POST', 	path: FINDMISSED, 	            config: configs.getMissed },
            { method: 'PUT', 	path: PUT, 	                    config: configs.update },
            { method: 'POST', 	path: FIND, 	                config: configs.find },
            { method: 'POST', 	path: EXPORT, 	                config: configs.fileExport },
            { method: 'POST', 	path: EXPORTRECORDS, 	        config: configs.fileExportRecords },
            { method: 'POST', 	path: EXPORTRECORDSLIST,        config: configs.fileExportRecordsList },
            { method: 'DELETE', path: DELEXPORTRECORDS, 		config: configs.deleteExportRecords },
            { method: 'GET', 	path: SIP, 	                    config: configs.forSip },
            { method: 'GET', 	path: BILLING, 	                config: configs.billReport },
            { method: 'POST', 	path: DAILY, 	                config: configs.dailyHour },
            { method: 'POST', 	path: DAILYEXPORT,              config: configs.dailyHourExport },
            { method: 'POST', 	path: CALLS, 	                config: configs.dailyCalls },
            { method: 'POST', 	path: CALLSEXPORT,              config: configs.dailyCallsExport },
            { method: 'POST', 	path: STATUSES, 	            config: configs.dailyStatuses },
            { method: 'POST', 	path: STATUSESEXPORT, 	        config: configs.dailyStatusesExport },
            { method: 'POST', 	path: DAILYREPORT, 	            config: configs.dailyReport },
            { method: 'POST', 	path: DAILYREPORTEXPORT,        config: configs.dailyReportExport },
            { method: 'GET', 	path: DASHBOARD, 	            config: configs.getDashboard },
            { method: 'GET', 	path: CALLER, 	                config: configs.CallerManager },
            { method: 'DELETE', path: DEL, 		                config: configs.delete },
    ]
)();
