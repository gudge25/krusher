/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');
class astIVREntriesModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find:   'ast_GetIVREntries',
            Insert: 'ast_InsIVREntries',
            Update: 'ast_UpdIVREntries',
            Delete: 'ast_DelIVREntries'
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
        d.entry_id      = p.entry_id   !== undefined             ?   p.entry_id              : null;
        d.id_ivr_config = p.id_ivr_config           ?   p.id_ivr_config         : null;
        d.extension     = p.extension               ?   p.extension             : null;
        d.destination   = p.destination             ?   p.destination           : null;
        d.destdata      = p.destdata                ?   p.destdata              : null;
        d.destdata2      = p.destdata2                ?   p.destdata2              : null;
        d.return        = p.return       ?   Boolean(p.return[0])       : false;
        d.isActive      = checkType(p.isActive[0])     ?   Boolean(p.isActive[0])     : false;
        d.offset        = p.offset                  ?   p.offset                : null;
        d.limit         = p.limit                   ?   p.limit                 : null;
    }
}

class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.entry_id      = p.entry_id                ?   p.entry_id              : null;
        d.id_ivr_config = p.id_ivr_config           ?   p.id_ivr_config         : null;
        d.extension     = p.extension               ?   p.extension             : null;
        d.destination   = p.destination             ?   p.destination           : null;
        d.destdata      = p.destdata                ?   p.destdata              : null;
        d.destdata2      = p.destdata2                ?   p.destdata2              : null;
        d.return        = checkType(p.return)       ?   Boolean(p.return)       : false;
        d.isActive      = checkType(p.isActive)     ?   Boolean(p.isActive)     : false;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID = p.HIID;
        d.entry_id      = p.entry_id                ?   p.entry_id              : null;
        d.id_ivr_config = p.id_ivr_config           ?   p.id_ivr_config         : null;
        d.extension     = p.extension               ?   p.extension             : null;
        d.destination   = p.destination             ?   p.destination           : null;
        d.destdata      = p.destdata                ?   p.destdata              : null;
        d.destdata2      = p.destdata2                ?   p.destdata2              : null;
        d.return        = checkType(p.return)       ?   Boolean(p.return)       : false;
        d.isActive      = checkType(p.isActive)     ?   Boolean(p.isActive)     : false;
    }
}
const model = new astIVREntriesModel();
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