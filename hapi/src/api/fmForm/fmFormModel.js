/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class fmFormModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find : 'fm_GetForm',
            Insert: 'fm_InsForm',
            Update: 'fm_UpdForm',
            Delete: 'fm_DelForm',
            FormExport: 'fm_GetFormExport'
        };
        super(storedProc);

        this.FindPost       = FindPost;
        this.Insert         = Insert;
        this.Update         = Update;
    }

    repoFormExport(params, callback) {
        this.execute(this.StoredProc.FormExport, params, callback);
    }
}
class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.dcSum = p.dcSum;
        d.dcState = p.dcState;
        d.dcNo = p.dcNo;
        d.dcDate = p.dcDate;
        d.dcLink = p.dcLink;
        d.dcComment = p.dcComment;
        d.dcStatus = p.dcStatus;
        d.emID = p.emID;
        d.isActive                      = checkType(p.isActive)                         ?   Boolean(p.isActive)                     : null;
        d.clID = p.clID;
        d.tpID = p.tpID;
    }
}

class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        delete d.dcSum;
        delete d.dcState;
        d.tpID = p.tpID;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        delete d.dcSum;
        delete d.dcState;
        d.tpID = p.tpID;
    }
}

const model = new fmFormModel();
module.exports = model;
