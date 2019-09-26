/*jshint node:true*/
'use strict';
const Joi = require('joi');
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class crmClientExModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find: 'crm_GetClientEx',
            Insert: 'crm_InsClientEx',
            Update: 'crm_UpdClientEx',
            Delete: 'crm_DelClientEx',
            InsList: 'crm_InsClientExList',
            SetDial: 'crm_SetDialClientEx',
        };
        super(storedProc);

        this.Insert     = Insert;
        this.SetDial    = SetDial;
        this.Update     = Update;
        this.FindPost   = FindPost;
    }

    repoInsList(params, callback) {
        this.execute(this.StoredProc.InsList, params, callback);
    }
    repoSetDial(params, callback) {
        this.execute(this.StoredProc.SetDial, params, callback);
    }
}
class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID       = p.HIID  !== undefined        ?   p.HIID       : null;
        d.clID = p.clID;
        d.CallDate = p.CallDate;
        d.ChangedBy = p.ChangedBy ;
        d.isNotice = p.adtID;
        d.isNotice                      = checkType(p.isNotice[0])                      ?   Boolean(p.isNotice[0])                  : null;
        d.isRobocall                    = checkType(p.isRobocall[0])                    ?   Boolean(p.isRobocall[0])                : null;
        d.ActDate = p.ActDate;
        d.timeZone = p.timeZone;
        d.isCallback                    = checkType(p.isCallback[0])                    ?   Boolean(p.isCallback[0])                : null;
        d.isDial                        = checkType(p.isDial[0])                        ?   Boolean(p.isDial[0])                    : null;
        d.curID = p.curID;
        d.langID = p.langID;
        d.sum = p.sum;
        d.isActive                      = checkType(p.isActive[0])                      ?   Boolean(p.isActive[0])                  : null;
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token = p.token;
        d.clID = p.clID;
        d.CallDate = p.CallDate;
        d.isNotice = p.isNotice;
        d.isRobocall = p.isRobocall;
        d.isCallback = p.isCallback;
        d.isDial = p.isDial;
        d.curID = p.curID;
        d.langID = p.langID;
        d.sum = p.sum;
        d.ttsText = p.ttsText;
        d.isActive = p.isActive;
    }
}
class SetDial extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.clID = p.clID;
        d.isdial = p.isdial;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID = p.HIID;
        d.clID = p.clID;
        d.CallDate = p.CallDate;
        d.isNotice = p.isNotice;
        d.curID = p.curID;
        d.langID = p.langID;
        d.sum = p.sum;
    }
}

const model = new crmClientExModel();
module.exports = model;

//JDI model from WEB
// class astRouteIncModel extends BaseModelNew {
//     constructor(p) {
//         p = p ? p : {};
//         super(p);
//         this.p = p;
//         this.rtID           = p.rtID        ? p.rtID    : null ;
//         this.Aid            = p.Aid         ? p.Aid     : null ;
//         this.trID           = p.trID        ? p.trID    : null ;
//         this.DID            = p.DID         ? p.DID     : null ;
//         this.exten          = p.exten       ? p.exten   : null ;
//         this.context        = p.context     ? p.context : null ;
//         this.Action         = p.Action      ? p.Action  : null ;
//         this.isActive       = p.isActive    ? p.isActive: null ;
//     }

//     get(){
//         super.get();
//         let p = this.p; delete this.p;
//         return this;
//     }

//     postFind(){
//         super.postFind();
//         let p = this.p; delete this.p;
//         return this;
//     }

//     put(){
//         super.put();
//         let p = this.p; delete this.p;
//         return this;
//     }

//     post(){
//         super.post();
//         let p = this.p; delete this.p;
//         delete this.rtID;
//         this.context        = p.context     ? p.context : `office` ;
//         this.isActive       = p.isActive    ? p.isActive: true ;
//         return this;
//     }
// }