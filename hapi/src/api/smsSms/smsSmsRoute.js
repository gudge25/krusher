/*jshint node:true*/
'use strict';
const configs = require('./smsSmsConfig');
const route = require('src/middleware/route').smsSms;

//const FIND = `${route}/find`;
const OUTGOINGSINGLE = `${route}/outgoing/single`;
const OUTGOINGBULK = `${route}/outgoing/bulk`;
const OUTGOINGBULKDEL = `${route}/outgoing/bulk/{bulkID}`;
const OUTGOINGBULKFIND = `${route}/outgoing/bulk/find`;
/*const INCOMING = `${route}/incoming`;*/
const INCOMINGGOIP = `${route}/goip/incoming`;

module.exports = (() =>
    [
  //      { method: 'POST', 	path: FIND, 	            config: configs.findPostCtrl },
        { method: 'POST', 	path: OUTGOINGSINGLE, 	    config: configs.insert },
        { method: 'POST', 	path: OUTGOINGBULK, 	    config: configs.insertBulk },
        { method: 'PUT', 	path: OUTGOINGBULK, 	    config: configs.updateBulk },
        { method: 'POST',   path: OUTGOINGBULKFIND,     config: configs.findBulk },
        { method: 'DELETE', path: OUTGOINGBULKDEL,      config: configs.deleteBulk },
        /*{ method: 'POST', 	path: INCOMING, 	    config: configs.incoming },*/
        { method: 'POST',   path: INCOMINGGOIP, 		config: configs.incomingGoip },
    ]
)();