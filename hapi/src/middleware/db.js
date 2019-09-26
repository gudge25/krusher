/*jshint node:true*/
'use strict';
const mysql = require('mysql');
const _ = require('lodash');
const constants = require('src/config/constants.js');

module.exports = (() => {
    const conn = [];
    const internals = {};
    const externals = {};
    const options = {
        multipleStatements: true,
        connectionLimit : 650,
        queueLimit : 250,
        connectTimeout: 60000 * 0,
        debug: false,
        supportBigNumbers: true,
        timezone: '+00:00'
    };
    _.extend(options, constants.database);
    let pool = mysql.createPool(options);
    internals.pool = pool;
    internals.conn = conn;
    externals.conn = conn;
    internals.connect = function(connectHandler) {
        pool.getConnection((err, connection) => {
            if (err)return connectHandler(err, null);
            return connectHandler(null, connection);
        });
    };
    externals.setConn = function() {
        const opt = _.clone(options);
        conn['krusher_connector'] = opt;
    };
    externals.query = params => {
        const options = conn['krusher_connector'];
        if (!options) return externals.queryRoot(params);
        const sql = params.sql;
        const queryHandler = params.callback;
        const connection = mysql.createConnection(options);
        connection.connect();
        connection.query(sql, (err, rows, fields) => {
            //queryHandler(err, rows);

            if (err) queryHandler(err, null); else queryHandler(null, rows);
            if (err) connection.destroy(); else connection.end();
           

            //console.log('-----------------------------------------------------------------------------------------------query');
            //connection.end();
            // if(err)connection.end();
            // else 
            //    connection.destroy();
        });
    };
    externals.queryRoot = params => {
        const sql = params.sql;
        const queryHandler = params.callback;
        internals.connect((err, connection) => {
            if (err)
            {
                //console.log('-----------------------------------------------------------------------------------------------queryRoot error');
                return queryHandler(err, null);
            }
            connection.query(sql, (err, rows, fields) => {
                queryHandler(err, rows);
                //console.log('-----------------------------------------------------------------------------------------------queryRoot');
                connection.release();
            });
        });
    };

    return externals;
})();
