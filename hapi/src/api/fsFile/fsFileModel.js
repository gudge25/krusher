/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const db = require('src/middleware/db');
const checkType = require('src/util/checkType');

class fsFileModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find: `fs_GetFile`,
            Insert: `fs_InsFile`,
            InsertForce: `fs_InsFileForce`,
            Update: `fs_UpdFile`,
            Delete: `fs_DelFile`,
            ClearDel: `fs_ClearDelFile`,
            GetDetail: `fs_GetFileDetail`,
            SqlTemplate: `fs_GetSqlTemplate`,
            FileExport: 'fs_GetFileExport',
            UpdStatus: 'fs_UpdFileStatus',
            FindByID: `fs_GetFileSummary`,
        };
        super(storedProc);

        this.FindPost = FindPost;
        this.FindOne = FindOne;
        this.Update = Update;
        this.GetDetail = GetDetail;
        this.FileExport = FileExport;
        this.ClearDel = ClearDel;
        this.InsertForce = InsertForce;
    }

    repoDetail(params, callback) {
        this.execute(this.StoredProc.GetDetail, params, callback);
    }
    repoFileExport(params, callback) {
        this.execute(this.StoredProc.FileExport, params, callback);
    }
    repoUpdStatus(params, callback) {
        this.execute(this.StoredProc.UpdStatus, params, callback);
    }
    repoInsertForce(params, callback) {
        this.execute(this.StoredProc.InsertForce, params, callback);
    }
    repoBulkDelete(params, callback) {
        this.execute(this.StoredProc.ClearDel, params, callback);
    }
    repoInsert(repoParams, callback) {
        const self = this;
        const fileParams = {
            params: {
                token: repoParams.token,
                ffID: repoParams.params.ffID,
                isRobocall : repoParams.isRobocall,
            },
            token: repoParams.token,
            loginName: repoParams.loginName
        };
        self.execute(self.StoredProc.SqlTemplate, repoParams, function(err, data) {
            if (err) return callback(err);
            const sql = data[0][0].Value;
            if (!sql) return callback(`Not valid sql query!`);
            db.query({
                sql: sql,
                callback: execSql
            });
            function execSql(err, data) {
                if (err) return callback(err);
                self.execute(self.StoredProc.Insert, fileParams, callback);
            }
        });
    }
}
class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.ffID = p.ffID;
        d.ffName = p.ffName;
        d.Priority = p.Priority;
        d.isActive = Boolean(p.isActive[0]);
        d.dbID = p.dbID;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID = p.HIID;
        d.token = p.token;
        d.ffID = p.ffID;
        d.ffName = p.ffName;
        d.Priority = p.Priority;
        d.dbID = p.dbID;
        d.isActive = p.isActive;
    }
}

class InsertForce extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.ffID = p.ffID;
        d.ffName = p.ffName;
        d.dbID = p.dbID;
        d.priority = p.priority;
        d.isActive = p.isActive;
    }
}
class GetDetail extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.cID = p.cID;
        d.rID = p.rID;
        d.Qty = p.Qty;
        d.isMobile                      = checkType(p.isMobile)                         ?   Boolean(p.isMobile)                     : null;
    }
}
class FileExport extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.Status = p.Status;
        d.TaxCode = p.TaxCode;
        d.FullName = p.FullName;
        d.ShortName = p.ShortName;
        d.KVED = p.KVED;
        d.KVEDName = p.KVEDName;
        d.Address = p.Address;
        d.PhoneCode = p.PhoneCode;
        d.PhonePrimary = p.PhonePrimary;
        d.Phones = p.Phones;
        d.WWW = p.WWW;
        d.Post = p.Post;
        d.FIO = p.FIO;
        d.FamIO = p.FamIO;
        d.IO = p.IO;
        d.Sex = p.Sex;
        d.Operator = p.Operator;
    }
}
class FindOne extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.FilterID = p.FilterID;
        d.Name = p.Name;
        d.Qty = p.Qty;
    }
}

class ClearDel extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.ffID = p.ffID;
        d.emIDEditor = p.emIDEditor;
        d.host = p.host;
    }
}


const model = new fsFileModel();
module.exports = model;
