/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class stProductModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find : `st_GetProduct`,
            Insert: `st_InsProduct`,
            Update: `st_UpdProduct`,
            Delete: `st_DelProduct`,
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
        d.psID = p.psID;
        d.psName = p.psName;
        d.psState = p.psState;
        d.psCode = p.psCode;
        d.msID = p.msID;
        d.msName = p.msName;
        d.pctID = p.pctID;
        d.pctName = p.pctName;
        d.ParentID = p.ParentID;
        d.bID = p.bID;
        d.uID = p.uID;
        d.isActive                      = checkType(p.isActive[0])         ?   Boolean(p.isActive[0])                     : null;
    }
}
class Insert extends Model.Post {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.psID = p.psID;
        d.psName = p.psName;
        d.psState = p.psState;
        d.psCode = p.psCode;
        d.msID = p.msID;
        d.pctID = p.pctID;
        d.ParentID = p.ParentID;
        d.bID = p.bID;
    }
}
class Update extends Model.Put {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.psID = p.psID;
        d.psName = p.psName;
        d.psState = p.psState;
        d.psCode = p.psCode;
        d.msID = p.msID;
        d.pctID = p.pctID;
        d.ParentID = p.ParentID;
        d.bID = p.bID;
    }
}

const model = new stProductModel();
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