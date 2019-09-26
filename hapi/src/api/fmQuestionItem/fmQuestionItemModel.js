/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class fmQuestionItemModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find : 'fm_GetQuestionItem',
            Insert: 'fm_InsQuestionItem',
            Update: 'fm_UpdQuestionItem',
            Delete: 'fm_DelQuestionItem',
            FindReport : 'fm_GetQuestionItemReport',
        };
        super(storedProc);

        this.FindPost       = FindPost;
        this.FindPostIn     = FindPostIn;
        this.FindReport     = FindReport;
        this.Insert         = Insert;
        this.Update         = Update;
        this.FindReportIn   = FindReportIn;
    }

    repoFindReport(params, callback) {
        this.execute(this.StoredProc.FindReport, params, callback);
    }
}
class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.qID = p.qID;
        d.qName = p.qName;
        d.ParentID = p.ParentID;
        d.tpID = p.tpID;
        d.isActive              = p.isActive                ?   checkType(p.isActive[0])    ?   Boolean(p.isActive[0]) : false : null;
    }
}
class FindPostIn extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.qiID = p.qiID;
        d.qIDs          = p.qIDs       ?   p.qIDs.filter(x => x).join()              : '';
        d.qiAnswer = p.qiAnswer;
        d.isActive              = p.isActive                ?   checkType(p.isActive)    ?   Boolean(p.isActive) : false : null;
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.qID = p.qID;
        d.qName = p.qName;
        d.ParentID = p.ParentID;
        d.tpID = p.tpID;
        d.isActive                      = checkType(p.isActive)                         ?   Boolean(p.isActive)                     : null;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.qID = p.qID;
        d.qName = p.qName;
        d.ParentID = p.ParentID;
        d.isActive                      = checkType(p.isActive)                         ?   Boolean(p.isActive)                     : null;
    }
}
class FindReport extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.tpID = p.tpID;
        d.qID = p.qID;
        d.qName = p.qName;
        d.QtyAnswer = p.QtyAnswer;
        d.QtyAvg = p.QtyAvg;
        d.Period = p.Period;
    }
}
class FindReportIn extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token = p.token;
        d.tpID = p.tpID;
        d.DateFrom = p.DateFrom;
        d.DateTo = p.DateTo;
        d.Step = p.Step;
    }
}

const model = new fmQuestionItemModel();
module.exports = model;
