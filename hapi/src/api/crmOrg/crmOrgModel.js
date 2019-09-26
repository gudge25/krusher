/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');
class crmOrgModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find : `crm_GetOrg`,
            Insert: `crm_InsOrg`,
            Update: `crm_UpdOrg`,
            Delete: `crm_DelOrg`,
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
        d.clID = p.clID;
        d.Account = p.Account ? p.Account : null;
        d.Bank = p.Bank ? p.Bank : null;
        d.TaxCode = p.TaxCode ? p.TaxCode : null;
        d.SortCode = p.SortCode ? p.SortCode : null;
        d.RegCode = p.RegCode ? p.RegCode : null;
        d.CertNumber = p.CertNumber ? p.CertNumber : null;
        d.OrgType = p.OrgType ? p.OrgType : null;
        d.ShortName = p.ShortName ? p.ShortName : null;
        d.KVED = p.KVED ? p.KVED : null;
        d.KVEDName = p.KVEDName ? p.KVEDName : null;
        d.headPost = p.headPost ? p.headPost : null;
        d.headFIO = p.headFIO ? p.headFIO : null;
        d.headFam = p.headFam ? p.headFam : null;
        d.headIO = p.headIO ? p.headIO : null;
        d.headSex = p.headSex ? p.headSex : null;
        d.orgNote = p.orgNote ? p.orgNote : null;
        d.isActive                      = checkType(p.isActive[0])                         ?   Boolean(p.isActive[0])                     : null;
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.clID = p.clID;
        d.Account = p.Account ? p.Account : null;
        d.Bank = p.Bank ? p.Bank : null;
        d.TaxCode = p.TaxCode ? p.TaxCode : null;
        d.SortCode = p.SortCode ? p.SortCode : null;
        d.RegCode = p.RegCode ? p.RegCode : null;
        d.CertNumber = p.CertNumber ? p.CertNumber : null;
        d.OrgType = p.OrgType ? p.OrgType : null;
        d.ShortName = p.ShortName ? p.ShortName : null;
        d.KVED = p.KVED ? p.KVED : null;
        d.KVEDName = p.KVEDName ? p.KVEDName : null;
        d.headPost = p.headPost ? p.headPost : null;
        d.headFIO = p.headFIO ? p.headFIO : null;
        d.headFam = p.headFam ? p.headFam : null;
        d.headIO = p.headIO ? p.headIO : null;
        d.headSex = p.headSex ? p.headSex : null;
        d.orgNote = p.orgNote ? p.orgNote : null;

    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.clID = p.clID;
        d.Account = p.Account ? p.Account : null;
        d.Bank = p.Bank ? p.Bank : null;
        d.TaxCode = p.TaxCode ? p.TaxCode : null;
        d.SortCode = p.SortCode ? p.SortCode : null;
        d.RegCode = p.RegCode ? p.RegCode : null;
        d.CertNumber = p.CertNumber ? p.CertNumber : null;
        d.OrgType = p.OrgType ? p.OrgType : null;
        d.ShortName = p.ShortName ? p.ShortName : null;
        d.KVED = p.KVED ? p.KVED : null;
        d.KVEDName = p.KVEDName ? p.KVEDName : null;
        d.headPost = p.headPost ? p.headPost : null;
        d.headFIO = p.headFIO ? p.headFIO : null;
        d.headFam = p.headFam ? p.headFam : null;
        d.headIO = p.headIO ? p.headIO : null;
        d.headSex = p.headSex ? p.headSex : null;
        d.orgNote = p.orgNote ? p.orgNote : null;
    }
}

const model = new crmOrgModel();
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