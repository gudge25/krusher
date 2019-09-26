/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class HClientModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find: 'h_GetHistoryByClient',
        };
        super(storedProc);

        this.FindPost = FindPost;
        this.FindPostIn = FindPostIn;
    }
}

class FindPostIn extends Model.Get {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.RowID = p.RowID;
        d.DateChangeFrom = p.DateChangeFrom;
        d.DateChangeTo = p.DateChangeTo;
        d.host = p.host;
        d.AppName = p.AppName;
        d.clID = p.clID;
        d.clName = p.clName;
        d.IsPerson = p.IsPerson;
        d.Sex = p.Sex;
        d.ParentID = p.ParentID;
        d.ffID = p.ffID;
        d.CompanyID = p.CompanyID;
        d.uID = p.uID;
        d.isActual = p.isActual;
        d.Position = p.Position;
        d.responsibleID = p.responsibleID;
        d.CreatedBy = p.CreatedBy;
        d.ChangedBy = p.ChangedBy;
        d.isActive = p.isActive;
        d.sorting = p.sorting;
        d.field = p.field;
        d.offset = p.offset;
        d.limit = p.limit;
    }
}

class FindPost extends Model.Get {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.RowID = p.RowID;
        d.DUP_InsTime = p.DUP_InsTime.toISOString().replace(/\..+/, '');
        d.DUP_action = p.DUP_action;
        d.DUP_HostName = p.DUP_HostName;
        d.DUP_AppName = p.DUP_AppName;
        d.HIID = p.HIID;
        d.clID = p.clID;
        d.clName = p.clName;
        d.IsPerson = p.IsPerson ? checkType(p.IsPerson[0]) ? Boolean(p.IsPerson[0]) : false : null;
        d.Sex = p.Sex ? checkType(p.Sex[0]) ? Boolean(p.Sex[0]) : false : null;
        d.Comment = p.Comment;
        d.ParentID = p.ParentID;
        d.ffID = p.ffID;
        d.CompanyID = p.CompanyID;
        d.uID = p.uID;
        d.isActual = p.isActual ? checkType(p.isActual[0]) ? Boolean(p.isActual[0]) : false : null;
        d.ActualStatus = p.ActualStatus;
        d.Position = p.Position;
        d.responsibleID = p.responsibleID;
        d.CreatedBy = p.CreatedBy;
        d.ChangedBy = p.ChangedBy;
        d.isActive = p.isActive ? checkType(p.isActive[0]) ? Boolean(p.isActive[0]) : false : null;
        d.Created = p.Created.toISOString().replace(/\..+/, '');
        d.Changed = p.Changed.toISOString().replace(/\..+/, '');
        d.OLD_HIID = p.OLD_HIID;
        d.OLD_clID = p.OLD_clID;
        d.OLD_clName = p.OLD_clName;
        d.OLD_IsPerson = p.OLD_IsPerson ? checkType(p.OLD_IsPerson[0]) ? Boolean(p.OLD_IsPerson[0]) : false : null;
        d.OLD_Sex = p.OLD_Sex ? checkType(p.OLD_Sex[0]) ? Boolean(p.OLD_Sex[0]) : false : null;
        d.OLD_Comment = p.OLD_Comment;
        d.OLD_ParentID = p.OLD_ParentID;
        d.OLD_ffID = p.OLD_ffID;
        d.OLD_CompanyID = p.OLD_CompanyID;
        d.OLD_uID = p.OLD_uID;
        d.OLD_isActual = p.OLD_isActual ? checkType(p.OLD_isActual[0]) ? Boolean(p.OLD_isActual[0]) : false : null;
        d.OLD_ActualStatus = p.OLD_ActualStatus;
        d.OLD_Position = p.OLD_Position;
        d.OLD_responsibleID = p.OLD_responsibleID;
        d.OLD_CreatedBy = p.OLD_CreatedBy;
        d.OLD_ChangedBy = p.OLD_ChangedBy;
        d.OLD_isActive = p.OLD_isActive ? checkType(p.OLD_isActive[0]) ? Boolean(p.OLD_isActive[0]) : false : null;
        d.OLD_Created = p.OLD_Created ? p.OLD_Created.toISOString().replace(/\..+/, '') : null;
        d.OLD_Changed = p.OLD_Changed ? p.OLD_Changed.toISOString().replace(/\..+/, '') : null;
    }
}

const model = new HClientModel();
module.exports = model;
