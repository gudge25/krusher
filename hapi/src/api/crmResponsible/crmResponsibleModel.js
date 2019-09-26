/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
//const checkType = require('src/util/checkType');
class crmResponsibleModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find : `crm_GetResponsible`,
            Insert: `crm_InsResponsible`,
            InsertArray: `crm_InsResponsibleArray`,
            InsList: `crm_InsResponsibleClient`,
            SetSabd: 'crm_SetSabdResponsible'
        };
        super(storedProc);

        this.Insert     = Insert;
        this.FindPost   = FindPost;
        this.InsList    = InsList;
    }

    repoSetSabd(obj, callback) {
        this.execute(this.StoredProc.SetSabd, obj, callback);
    }
    repoInsList(obj, callback) {
        this.execute(this.StoredProc.InsList, obj, callback);
    }
}
class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.clID                  = p.clID;
        d.emID         = p.emID;
        d.emName                = p.emName;
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.clID   = p.clID;
        d.emID  = p.emID;
    }
}
class InsList extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token  = p.token;
        d.emID   = p.emID;
        d.clIDs  = p.clIDs.join();
    }
}

const model = new crmResponsibleModel();
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