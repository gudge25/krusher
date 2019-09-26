/*jshint node:true, esnext:true*/
'use strict';
const db = require('src/middleware/db');
const SqlString = require('src/util/SqlString');
class BaseDAO {
    constructor(storedProc) {
        this.StoredProc = storedProc;
        this.execute = (spName, params, callback) => {
            const user  = params.loginName;
            const token = params.token;
            const sql   = SqlString.toExec(spName, params.params);
            const query = { sql, callback, user, token };
            return db.query(query);
        };
    }
    repoFindByID(params, callback) {
        this.execute(this.StoredProc.FindByID, params, callback);
    }
    repoFind(params, callback) {
        this.execute(this.StoredProc.Find, params, callback);
    }
    repoFindPost(params, callback) {
        this.execute(this.StoredProc.FindPost, params, callback);
    }
    repoInsert(params, callback) {
        this.execute(this.StoredProc.Insert, params, callback);
    }
    repoUpdate(params, callback) {
        this.execute(this.StoredProc.Update, params, callback);
    }
    repoDelete(params, callback) {
        this.execute(this.StoredProc.Delete, params, callback);
    }
    repoLookup(params, callback) {
        this.execute(this.StoredProc.Lookup, params, callback);
    }
}
module.exports = BaseDAO;