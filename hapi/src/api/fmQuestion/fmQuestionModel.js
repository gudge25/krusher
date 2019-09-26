/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class fmQuestionModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find: 'fm_GetQuestion',
            Insert: 'fm_InsQuestion',
            Update: 'fm_UpdQuestion',
            Delete: 'fm_DelQuestion',
            FindReport: 'fm_GetQuestionReport',
        };
        super(storedProc);

        this.FindPost       = FindPost;
        this.FindReport     = FindReport;
        this.Insert         = Insert;
        this.Update         = Update;
    }

    repoFindReport(params, callback) {
        this.execute(this.StoredProc.FindReport, params, callback);
    }
}
class FindReport extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.tpID = p.tpID;
        d.qID = p.qID;
        d.qName = p.qName;
        d.QtyAvg = p.QtyAvg;
        d.QtyAnswer = p.QtyAnswer;
        d.Period = p.Period;
        d.isActive                      = checkType(p.isActive[0])                         ?   Boolean(p.isActive[0])                     : null;
    }
}

class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID = p.HIID;
        d.qID = p.qID;
        d.qiID = p.qiID;
        d.qiAnswer = p.qiAnswer;
        d.isActive                      = checkType(p.isActive[0])                         ?   Boolean(p.isActive[0])                     : null;
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const data = this.Data;
        data.qID = p.qID;
        data.qiID = p.qiID;
        data.qiAnswer = p.qiAnswer;
        data.isActive = p.isActive;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const data = this.Data;
        data.qID = p.qID;
        data.qiID = p.qiID;
        data.qiAnswer = p.qiAnswer;
        data.isActive = p.isActive;
    }
}

const model = new fmQuestionModel();
module.exports = model;
