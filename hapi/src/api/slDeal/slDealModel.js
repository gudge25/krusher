/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class slDealModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find: 'sl_GetDeal',
            Insert: 'sl_InsDeal',
            Update: 'sl_UpdDeal',
            Delete: 'sl_DelDeal',
            Chart: 'sl_GetDealChart',
            InsByStatus: "sl_InsDealByStatus"
        };
        super(storedProc);

        this.FindPost = FindPost;
        this.Update = Update;
        this.Insert = Insert;
        this.Chart = Chart;
        this.InsByStatus = InsByStatus;
    }

    repoFindChart(params, callback) {
        this.execute(this.StoredProc.Chart, params, callback);
    }
    repoInsByStatus(params, callback) {
        this.execute(this.StoredProc.InsByStatus, params, callback);
    }
}
class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID = p.HIID;
        d.dcID = p.dcID;
        d.dcNo = p.dcNo;
        d.dcDate = p.dcDate;
        d.dcLink = p.dcLink;
        d.dcComment = p.dcComment;
        d.dcSum = p.dcSum;
        d.dcStatus = p.dcStatus;
        d.clID = p.clID;
        d.clName = p.clName;
        d.emID = p.emID;
        d.emName = p.emName;
        d.Created = p.Created;
        d.CreatedBy = p.CreatedBy;
        d.CreatedName = p.CreatedName;
        d.Changed = p.Changed;
        d.ChangedBy = p.ChangedBy;
        d.EditedName = p.EditedName;
        d.isHasDoc                      = checkType(p.isHasDoc[0])                         ?   Boolean(p.isHasDoc[0])                     : null;
        d.HasDocNo = p.HasDocNo;
        d.uID = p.uID;
        d.ccName = p.ccName;
        d.LinkFile = p.LinkFile;
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const data = this.Data;
        data.HasDocNo = p.HasDocNo;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token = p.token;
        d.HIID = p.HIID;
        d.dcID = p.dcID;
        d.dcNo = p.dcNo;
        d.dcDate = p.dcDate;
        d.dcLink = p.dcLink;
        d.dcComment = p.dcComment;
        d.dcSum = p.dcSum;
        d.dcStatus = p.dcStatus;
        d.clID = p.clID;
        d.emID = p.emID;
        d.isActive                      = checkType(p.isActive)                         ?   Boolean(p.isActive)                     : null;
        d.HasDocNo = p.HasDocNo;
    }
}
class Chart extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.psID = p.psID;
        d.psName = p.psName;
        d.qty = p.qty;
        d.Percent = p.Percent;
    }
}
class InsByStatus extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token = p.token;
        d.comID = p.comID;
        d.phone = p.phone;
        d.sipNum = p.sipNum;
        d.isActive                      = checkType(p.isActive[0])                         ?   Boolean(p.isActive[0])                     : null;
    }
}

const model = new slDealModel();
module.exports = model;
