/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class crmAddressModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find : 'crm_GetAddress',
            Insert: 'crm_InsAddress',
            Update: 'crm_UpdAddress',
            Delete: 'crm_DelAddress'
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
        d.adsID = p.adsID;
        d.adsName = p.adsName;
        d.adtID = p.adtID;
        d.Postcode = p.Postcode;
        d.pntID = p.pntID;
        d.Region = p.Region;
        d.RegionDesc = p.RegionDesc;
        d.isActive                      = checkType(p.isActive[0])                         ?   Boolean(p.isActive[0])                     : null;
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.clID = p.clID;
        d.adsID = p.adsID;
        d.adsName = p.adsName;
        d.adtID = p.adtID;
        d.Postcode = p.Postcode;
        d.pntID = p.pntID;
        d.Region = p.Region;
        d.RegionDesc = p.RegionDesc;
        d.isActive                      = checkType(p.isActive)                         ?   Boolean(p.isActive)                     : null;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.clID = p.clID;
        d.adsID = p.adsID;
        d.adsName = p.adsName;
        d.adtID = p.adtID;
        d.Postcode = p.Postcode;
        d.pntID = p.pntID;
        d.Region = p.Region;
        d.RegionDesc = p.RegionDesc;
        d.isActive                      = checkType(p.isActive)                         ?   Boolean(p.isActive)                     : null;
    }
}

const model = new crmAddressModel();
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