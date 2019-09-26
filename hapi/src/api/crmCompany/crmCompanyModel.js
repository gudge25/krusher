/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class crmCompanyModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find : `crm_GetCompany`,
            Insert: `crm_InsCompany`,
            Update: `crm_UpdCompany`,
            Delete: `crm_DelCompany`,
        };
        super(storedProc);

        this.Insert     = Insert;
        this.Update     = Update;
        this.FindPost   = FindPost;
    }
}
class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID       = p.HIID   !== undefined       ?   p.HIID       : null;
        d.coID = p.coID;
        d.coName = p.coName;
        d.coDescription = p.coDescription;
        d.pauseDelay = p.pauseDelay;
        d.isActivePOPup = p.isActivePOPup ? checkType(p.isActivePOPup[0]) ? Boolean(p.isActivePOPup[0]) : false : null;
        d.isRingingPOPup = p.isRingingPOPup ? checkType(p.isRingingPOPup[0]) ? Boolean(p.isRingingPOPup[0]) : false : null;
        d.isUpPOPup = p.isUpPOPup ? checkType(p.isUpPOPup[0]) ? Boolean(p.isUpPOPup[0]) : false : null;
        d.isCCPOPup = p.isCCPOPup ? checkType(p.isCCPOPup[0]) ? Boolean(p.isCCPOPup[0]) : false : null;
        d.isClosePOPup = p.isClosePOPup ? checkType(p.isClosePOPup[0]) ? Boolean(p.isClosePOPup[0]) : false : null;
        d.isActive = p.isActive ? checkType(p.isActive[0]) ? Boolean(p.isActive[0]) : false : null;
        d.Created = p.Created;
        d.Changed = p.Changed;
    }
}

class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token                         = p.token;
        d.coID = p.coID;
        d.coName = p.coName;
        d.coDescription = p.coDescription;
        d.inMessage = p.inMessage;
        d.outMessage = p.outMessage;
        d.pauseDelay = p.pauseDelay;
        d.isActivePOPup = p.isActivePOPup ? checkType(p.isActivePOPup) ? Boolean(p.isActivePOPup) : false : null;
        d.isRingingPOPup = p.isRingingPOPup ? checkType(p.isRingingPOPup) ? Boolean(p.isRingingPOPup) : false : null;
        d.isUpPOPup = p.isUpPOPup ? checkType(p.isUpPOPup) ? Boolean(p.isUpPOPup) : false : null;
        d.isCCPOPup = p.isCCPOPup ? checkType(p.isCCPOPup) ? Boolean(p.isCCPOPup) : false : null;
        d.isClosePOPup = p.isClosePOPup ? checkType(p.isClosePOPup) ? Boolean(p.isClosePOPup) : false : null;
        d.isActive                      = checkType(p.isActive)                         ?   Boolean(p.isActive)                     : null;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token                         = p.token;
        d.HIID = p.HIID;
        d.coID = p.coID;
        d.coName = p.coName;
        d.coDescription = p.coDescription;
        d.inMessage = p.inMessage;
        d.outMessage = p.outMessage;
        d.pauseDelay = p.pauseDelay;
        d.isActivePOPup = p.isActivePOPup ? checkType(p.isActivePOPup) ? Boolean(p.isActivePOPup) : false : null;
        d.isRingingPOPup = p.isRingingPOPup ? checkType(p.isRingingPOPup) ? Boolean(p.isRingingPOPup) : false : null;
        d.isUpPOPup = p.isUpPOPup ? checkType(p.isUpPOPup) ? Boolean(p.isUpPOPup) : false : null;
        d.isCCPOPup = p.isCCPOPup ? checkType(p.isCCPOPup) ? Boolean(p.isCCPOPup) : false : null;
        d.isClosePOPup = p.isClosePOPup ? checkType(p.isClosePOPup) ? Boolean(p.isClosePOPup) : false : null;
        d.isActive                      = checkType(p.isActive)                         ?   Boolean(p.isActive)                     : null;
    }
}

const model = new crmCompanyModel();
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