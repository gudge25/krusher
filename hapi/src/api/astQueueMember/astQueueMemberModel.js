/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');
class astQueueMemberModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find:   'ast_GetQueueMembers',
            Insert: 'ast_InsQueueMembers',
            Update: 'ast_UpdQueueMembers',
            Delete: 'ast_DelQueueMembers'
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
        d.quemID            = p.quemID   !== undefined           ?   p.quemID            : null;
        d.emID              = p.emID                ?   p.emID              : null;
        d.queID             = p.queID               ?   p.queID             : null;
        d.membername        = p.membername          ?   p.membername        : null;
        d.queue_name        = p.queue_name          ?   p.queue_name        : null;
        d.interface         = p.interface           ?   p.interface         : null;
        d.penalty           = p.penalty             ?   p.penalty           : null;
        d.paused            = p.paused              ?   p.paused            : null;
        d.isActive          = checkType(p.isActive[0]) ?   Boolean(p.isActive[0]) : false;
        d.offset            = p.offset              ?   p.offset            : null;
        d.limit             = p.limit               ?   p.limit             : null;
    }
}

class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.quemID            = p.quemID              ?   p.quemID            : null;
        d.emID              = p.emID                ?   p.emID              : null;
        d.queID             = p.queID               ?   p.queID             : null;
        d.membername        = p.membername          ?   p.membername        : null;
        d.queue_name        = p.queue_name          ?   p.queue_name        : null;
        d.interface         = p.interface           ?   p.interface         : null;
        d.penalty           = p.penalty             ?   p.penalty           : 0;
        d.paused            = p.paused              ?   p.paused            : 0;
        d.isActive          = checkType(p.isActive) ?   Boolean(p.isActive) : false;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID = p.HIID;
        d.quemID            = p.quemID              ?   p.quemID            : null;
        d.emID              = p.emID                ?   p.emID              : null;
        d.queID             = p.queID               ?   p.queID             : null;
        d.membername        = p.membername          ?   p.membername        : null;
        d.queue_name        = p.queue_name          ?   p.queue_name        : null;
        d.interface         = p.interface           ?   p.interface         : null;
        d.penalty           = p.penalty             ?   p.penalty           : null;
        d.paused            = p.paused              ?   p.paused            : null;
        d.isActive          = checkType(p.isActive) ?   Boolean(p.isActive) : false;
    }
}
const model = new astQueueMemberModel();
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