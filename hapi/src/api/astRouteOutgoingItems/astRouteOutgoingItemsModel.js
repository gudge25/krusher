/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class astRouteOutgoingItemsModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find : `ast_GetRouteOutgoingItems`,
            Insert: `ast_InsRouteOutgoingItems`,
            Update: `ast_UpdRouteOutgoingItems`,
            Delete: `ast_DelRouteOutgoingItems`,
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
        d.HIID       = p.HIID  !== undefined        ?   p.HIID       : null;
        d.roiID = p.roiID;
        d.roID = p.roID;
        d.pattern = p.pattern;
        d.callerID                        = p.callerID;
        d.prepend                        = p.prepend;
        d.prefix                        = p.prefix;
        d.priority                        = p.priority;
        d.isActive                      = checkType(p.isActive[0])                         ?   Boolean(p.isActive[0])                     : null;
    }
}

class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token = p.token;
        d.roiID = p.roiID;
        d.roID = p.roID;
        d.pattern = p.pattern.join();
        d.callerID                        = p.callerID;
        d.prepend                        = p.prepend;
        d.prefix                        = p.prefix;
        d.priority                        = p.priority;
        d.isActive                      = checkType(p.isActive)                         ?   Boolean(p.isActive)                     : null;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token = p.token;
        d.HIID = p.HIID;
        d.roiID = p.roiID;
        d.roID = p.roID;
        d.pattern = p.pattern;
        d.callerID                        = p.callerID;
        d.prepend                        = p.prepend;
        d.prefix                        = p.prefix;
        d.priority                        = p.priority;
        d.isActive                      = checkType(p.isActive)                         ?   Boolean(p.isActive)                     : null;
    }
}

const model = new astRouteOutgoingItemsModel();
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