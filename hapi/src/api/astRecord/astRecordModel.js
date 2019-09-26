/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class astRecordModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find:           'ast_GetRecord',
            Insert:         'ast_InsRecord',
            InsertForce:    'ast_InsFRecord',
            Update:         'ast_UpdRecord',
            Delete:         'ast_DelRecord'
        };
        super(storedProc);

        this.Insert         = Insert;
        this.InsertForce    = InsertForce;
        this.Update         = Update;
        this.FindPost       = FindPost;
    }

    repoInsertForce(params, callback) {
        this.execute(this.StoredProc.InsertForce, params, callback);
    }
}

class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID       = p.HIID   !== undefined       ?   p.HIID       : null;
        d.record_id                 = p.record_id             ?   p.record_id           : null;
        d.record_name               = p.record_name           ?   p.record_name         : null;
        d.record_source             = p.record_source         ?   p.record_source       : null;
        d.isActive = p.isActive ? checkType(p.isActive[0]) ? Boolean(p.isActive[0]) : false : null;
        d.Created                   = p.Created               ?   p.Created             : null;
        d.Updated                   = p.Updated               ?   p.Updated             : null;
        d.offset                    = p.offset                ?   p.offset              : null;
        d.limit                     = p.limit                 ?   p.limit               : null;
    }
}

class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.record_name               = p.record_name           ?   p.record_name         : null;
        d.record_source             = p.record_source         ?   p.record_source       : null;
        d.isActive = p.isActive ? checkType(p.isActive[0]) ? Boolean(p.isActive[0]) : false : null;
    }
}

class InsertForce extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.Aid                       = p.Aid                   ?   p.Aid                 : null;
        d.record_name               = p.record_name           ?   p.record_name         : null;
        d.record_source             = p.record_source         ?   p.record_source       : null;
     //   d.isActive                  = checkType(p.isActive)   ?   Boolean(p.isActive)   : false;
    }
}

class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID = p.HIID;
        d.record_id                 = p.record_id             ?   p.record_id           : null;
        d.record_name               = p.record_name           ?   p.record_name         : null;
        d.record_source             = p.record_source         ?   p.record_source       : null;
        d.isActive = p.isActive ? checkType(p.isActive[0]) ? Boolean(p.isActive[0]) : false : null;
    }
}

const model = new astRecordModel();
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