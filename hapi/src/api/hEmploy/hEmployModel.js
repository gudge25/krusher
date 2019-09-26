/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class HEmployModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find: 'h_GetHistoryByEmploy',
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
        d.emID = p.emID;
        /*d.SipAccount = p.SipAccount;*/
        d.emName = p.emName;
        d.LoginName = p.LoginName;
        /*d.Password = p.Password;*/
       /* d.Token = p.Token;
        d.TokenExpiredDate = p.TokenExpiredDate;*/
        d.url = p.url;
        d.ManageID = p.ManageID;
        d.roleID = p.roleID;
        d.sipID = p.sipID;
        d.sipName = p.sipName;
        d.Queue = p.Queue;
        d.CompanyID = p.CompanyID;
        d.onlineStatus = p.onlineStatus;
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
        d.emID = p.emID;
        d.emName = p.emName;
        d.LoginName = p.LoginName;
        d.url = p.url;
        d.ManageID = p.ManageID;
        d.roleID = p.roleID;
        d.sipID = p.sipID;
        d.sipName = p.sipName;
        d.Queue = p.Queue;
        d.CompanyID = p.CompanyID;
        d.onlineStatus = p.onlineStatus;
        d.isActive = p.isActive ? checkType(p.isActive[0]) ? Boolean(p.isActive[0]) : false : null;
        d.Created = p.Created.toISOString().replace(/\..+/, '');
        d.Changed = p.Changed.toISOString().replace(/\..+/, '');
        d.OLD_HIID = p.OLD_HIID;
        d.OLD_emID = p.OLD_emID;
        d.OLD_emName = p.OLD_emName;
        d.OLD_LoginName = p.OLD_LoginName;
        d.OLD_url = p.OLD_url;
        d.OLD_ManageID = p.OLD_ManageID;
        d.OLD_roleID = p.OLD_roleID;
        d.OLD_sipID = p.OLD_sipID;
        d.OLD_sipName = p.OLD_sipName;
        d.OLD_Queue = p.OLD_Queue;
        d.OLD_CompanyID = p.OLD_CompanyID;
        d.OLD_onlineStatus = p.OLD_onlineStatus;
        //d.OLD_isActive = checkType(p.OLD_isActive) ? Boolean(p.OLD_isActive) : null;
        d.OLD_isActive = p.OLD_isActive !==null ?  checkType(p.OLD_isActive[0]) ? Boolean(p.OLD_isActive[0]) : false : null;
        d.OLD_Created = p.OLD_Created ? p.OLD_Created.toISOString().replace(/\..+/, '') : null;
        d.OLD_Changed = p.OLD_Changed ? p.OLD_Changed.toISOString().replace(/\..+/, '') : null;
    }
}

const model = new HEmployModel();
module.exports = model;
