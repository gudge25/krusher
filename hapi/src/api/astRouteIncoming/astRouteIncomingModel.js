/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');
class astRouteIncomingModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find:   'ast_GetRouteIncoming',
            Insert: 'ast_InsRouteIncoming',
            Update: 'ast_UpdRouteIncoming',
            Delete: 'ast_DelRouteIncoming'
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
        d.HIID          = p.HIID   !== undefined        ?   p.HIID                      : null;
        d.rtID          = p.rtID                        ?   p.rtID                      : null;
        d.trID          = p.trID                        ?   p.trID                      : null;
        d.DID           = p.DID                         ?   p.DID                       : null;
        d.callerID      = p.callerID                    ?   p.callerID                  : null;
        d.exten         = p.exten                       ?   p.exten                     : null;
        d.isActive      = checkType(p.isActive[0])      ?   Boolean(p.isActive[0])      : null;
        d.context       = p.context                     ?   p.context                   : null;
        d.destination   = p.destination                 ?   p.destination               : null;
        d.destdata      = p.destdata                    ?   p.destdata                  : null;
        d.destdata2     = p.destdata2                   ?   p.destdata2                 : null;
        d.stick_destination     = p.stick_destination                   ?   p.stick_destination                 : null;
        d.isCallback    = checkType(p.isCallback[0])    ?   Boolean(p.isCallback[0])    : null;
        d.isFirstClient = checkType(p.isFirstClient[0]) ?   Boolean(p.isFirstClient[0]) : null;
    }
}

class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.rtID          = p.rtID ?                      p.rtID                      : null;
        d.trID          = p.trID ?                      p.trID                      : null;
        d.DID           = p.DID ?                       p.DID                       : null;
        d.callerID      = p.callerID ?                  p.callerID                  : null;
        d.exten         = p.exten ?                     p.exten                     : null;
        d.isActive      = checkType(p.isActive)     ?           Boolean(p.isActive) : null;
        d.context       = p.context ?                   p.context                   : null;
        d.destination   = p.destination ?               p.destination               : null;
        d.destdata      = p.destdata ?                  p.destdata                  : null;
        d.destdata2     = p.destdata2                ?                  p.destdata2   : null;
        d.stick_destination     = p.stick_destination                   ?   p.stick_destination                 : null;
        d.isCallback      = checkType(p.isCallback)     ?           Boolean(p.isCallback) : null;
        d.isFirstClient      = checkType(p.isFirstClient)     ?           Boolean(p.isFirstClient) : null;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID = p.HIID;
        d.rtID          = p.rtID ?                      p.rtID                      : null;
        d.trID          = p.trID ?                      p.trID                      : null;
        d.DID           = p.DID ?                       p.DID                       : null;
        d.callerID      = p.callerID ?                  p.callerID                  : null;
        d.exten         = p.exten ?                     p.exten                     : null;
        d.isActive      = checkType(p.isActive)     ?           Boolean(p.isActive) : null;
        d.context       = p.context ?                   p.context                   : null;
        d.destination   = p.destination ?               p.destination               : null;
        d.destdata      = p.destdata ?                  p.destdata                  : null;
        d.destdata2     = p.destdata2                ?                  p.destdata2   : null;
        d.stick_destination     = p.stick_destination                   ?   p.stick_destination                 : null;
        d.isCallback      = checkType(p.isCallback)     ?           Boolean(p.isCallback) : null;
        d.isFirstClient      = checkType(p.isFirstClient)     ?           Boolean(p.isFirstClient) : null;
    }
}
const model = new astRouteIncomingModel();
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