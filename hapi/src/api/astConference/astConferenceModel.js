/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');
class astConferenceModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find:   'ast_GetConference',
            Insert: 'ast_InsConference',
            Update: 'ast_UpdConference',
            Delete: 'ast_DelConference'
        };
        super(storedProc);

        this.Insert     = Insert;
        this.Update     = Update;
        this.FindPost   = FindPost;
        this.FindPostIn = FindPostIn;
    }
}
class FindPostIn extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token                  = p.token                                ?   p.token                                 : null;
        d.cfID                   = p.cfID                                 ?   p.cfID                           : null;
        d.cfName                 = p.cfName                               ?   p.cfName                         : null;
        d.cfDesc                 = p.cfDesc                               ?   p.cfDesc                              : null;
        d.userPin                = p.userPin                              ?   p.userPin                             : null;
        d.adminPin               = p.adminPin                             ?   p.adminPin                               : null;
        d.langID                 = p.langID                               ?   p.langID                              : null;
        d.record_id              = p.record_id                            ?   p.record_id                           : null;
        d.leaderWait             = checkType(p.leaderWait)                ?   Boolean(p.leaderWait)        : null;
        d.leaderLeave            = checkType(p.leaderLeave)               ?   Boolean(p.leaderLeave)        : null;
        d.talkerOptimization            = checkType(p.talkerOptimization)               ?   Boolean(p.talkerOptimization): null;
        d.talkerDetection        = checkType(p.talkerDetection)           ?   Boolean(p.talkerDetection)      : null;
        d.quiteMode              = checkType(p.quiteMode)                 ?   Boolean(p.quiteMode)      : null;
        d.userCount              = checkType(p.userCount)                 ?   Boolean(p.userCount)      : null;
        d.userJoinLeave          = checkType(p.userJoinLeave)             ?   Boolean(p.userJoinLeave)      : null;
        d.moh                    = checkType(p.moh)                       ?   Boolean(p.moh)      : null;
        d.mohClass               = p.mohClass                             ?   p.mohClass     : null;
        d.allowMenu              = checkType(p.allowMenu)                 ?   Boolean(p.allowMenu)      : null;
        d.recordConference       = checkType(p.recordConference)          ?   Boolean(p.recordConference)      : null;
        d.maxParticipants        = p.maxParticipants                      ?   p.maxParticipants                              : null;
        d.muteOnJoin             = checkType(p.muteOnJoin)                ?   Boolean(p.muteOnJoin)      : null;
        d.isActive               = checkType(p.isActive)                  ?   Boolean(p.isActive)                  : null;

    }
}
class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID                          = p.HIID     !== undefined                      ?   p.HIID                                  : null;
        d.cfID                   = p.cfID                                 ?   p.cfID                           : null;
        d.cfName                 = p.cfName                               ?   p.cfName                         : null;
        d.cfDesc                 = p.cfDesc                               ?   p.cfDesc                              : null;
        d.userPin                = p.userPin                              ?   p.userPin                             : null;
        d.adminPin               = p.adminPin                             ?   p.adminPin                               : null;
        d.langID                 = p.langID                               ?   p.langID                              : null;
        d.record_id              = p.record_id                            ?   p.record_id                           : null;

        d.leaderWait                        = p.leaderWait         ? checkType(p.leaderWait[0])    ?   Boolean(p.leaderWait[0]) : false : null;
        d.leaderLeave                        = p.leaderLeave         ? checkType(p.leaderLeave[0])    ?   Boolean(p.leaderLeave[0]) : false : null;
        d.talkerOptimization                        = p.talkerOptimization         ? checkType(p.talkerOptimization[0])    ?   Boolean(p.talkerOptimization[0]) : false : null;
        d.talkerDetection                        = p.talkerDetection         ? checkType(p.talkerDetection[0])    ?   Boolean(p.talkerDetection[0]) : false : null;
        d.quiteMode                        = p.quiteMode         ? checkType(p.quiteMode[0])    ?   Boolean(p.quiteMode[0]) : false : null;
        d.userCount                        = p.userCount         ? checkType(p.userCount[0])    ?   Boolean(p.userCount[0]) : false : null;
        d.userJoinLeave                        = p.userJoinLeave         ? checkType(p.userJoinLeave[0])    ?   Boolean(p.userJoinLeave[0]) : false : null;
        /*d.leaderWait             = checkType(p.leaderWait[0])                ?   Boolean(p.leaderWait[0])        : null;
        d.leaderLeave            = checkType(p.leaderLeave[0])               ?   Boolean(p.leaderLeave[0])        : null;
        d.talkerOptimization            = checkType(p.talkerOptimization[0])               ?   Boolean(p.talkerOptimization[0]): null;
        d.talkerDetection        = checkType(p.talkerDetection[0])           ?   Boolean(p.talkerDetection[0])      : null;
        d.quiteMode              = checkType(p.quiteMode[0])                 ?   Boolean(p.quiteMode[0])      : null;
        d.userCount              = checkType(p.userCount[0])                 ?   Boolean(p.userCount[0])      : null;
        d.userJoinLeave          = checkType(p.userJoinLeave[0])             ?   Boolean(p.userJoinLeave[0])      : null;*/
        //d.moh                    = checkType(p.moh[0])                       ?   Boolean(p.moh[0])      : null;
        d.moh                        = p.moh         ? checkType(p.moh[0])    ?   Boolean(p.moh[0]) : false : null;
        d.mohClass               = p.mohClass                             ?   p.mohClass     : null;
        d.allowMenu                        = p.allowMenu         ? checkType(p.allowMenu[0])    ?   Boolean(p.allowMenu[0]) : false : null;
        d.recordConference                        = p.recordConference         ? checkType(p.recordConference[0])    ?   Boolean(p.recordConference[0]) : false : null;
        /*d.allowMenu              = checkType(p.allowMenu[0])                 ?   Boolean(p.allowMenu[0])      : null;
        d.recordConference       = checkType(p.recordConference[0])          ?   Boolean(p.recordConference[0])      : null;*/
        d.maxParticipants        = p.maxParticipants                      ?   p.maxParticipants                              : null;
        d.muteOnJoin                        = p.muteOnJoin         ? checkType(p.muteOnJoin[0])    ?   Boolean(p.muteOnJoin[0]) : false : null;
        d.isActive                        = p.isActive         ? checkType(p.isActive[0])    ?   Boolean(p.isActive[0]) : false : null;
       /* d.muteOnJoin             = checkType(p.muteOnJoin[0])                ?   Boolean(p.muteOnJoin[0])      : null;
        d.isActive               = checkType(p.isActive[0])                  ?   Boolean(p.isActive[0])                  : null;*/
        d.Created               = p.Created                 ?   p.Created.toISOString().replace(/\..+/, '')                             : null;
        d.Changed               = p.Changed                 ?   p.Changed.toISOString().replace(/\..+/, '')                             : null;
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token                  = p.token                                ?   p.token                                 : null;
        d.cfID                   = p.cfID                                 ?   p.cfID                           : null;
        d.cfName                 = p.cfName                               ?   p.cfName                         : null;
        d.cfDesc                 = p.cfDesc                               ?   p.cfDesc                              : null;
        d.userPin                = p.userPin                              ?   p.userPin                             : null;
        d.adminPin               = p.adminPin                             ?   p.adminPin                               : null;
        d.langID                 = p.langID                               ?   p.langID                              : null;
        d.record_id              = p.record_id                            ?   p.record_id                           : null;
        d.leaderWait             = checkType(p.leaderWait)                ?   Boolean(p.leaderWait)        : null;
        d.leaderLeave            = checkType(p.leaderLeave)               ?   Boolean(p.leaderLeave)        : null;
        d.talkerOptimization     = checkType(p.talkerOptimization)        ?   Boolean(p.talkerOptimization): null;
        d.talkerDetection        = checkType(p.talkerDetection)           ?   Boolean(p.talkerDetection)      : null;
        d.quiteMode              = checkType(p.quiteMode)                 ?   Boolean(p.quiteMode)      : null;
        d.userCount              = checkType(p.userCount)                 ?   Boolean(p.userCount)      : null;
        d.userJoinLeave          = checkType(p.userJoinLeave)             ?   Boolean(p.userJoinLeave)      : null;
        d.moh                    = checkType(p.moh)                       ?   Boolean(p.moh)      : null;
        d.mohClass               = p.mohClass                             ?   p.mohClass     : null;
        d.allowMenu              = checkType(p.allowMenu)                 ?   Boolean(p.allowMenu)      : null;
        d.recordConference       = checkType(p.recordConference)          ?   Boolean(p.recordConference)      : null;
        d.maxParticipants        = p.maxParticipants                      ?   p.maxParticipants                              : null;
        d.muteOnJoin             = checkType(p.muteOnJoin)                ?   Boolean(p.muteOnJoin)      : null;
        d.isActive               = checkType(p.isActive)                  ?   Boolean(p.isActive)                  : null;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token                         = p.token                                       ?   p.token                                 : null;
        d.HIID = p.HIID;
        d.cfID                   = p.cfID                                 ?   p.cfID                           : null;
        d.cfName                 = p.cfName                               ?   p.cfName                         : null;
        d.cfDesc                 = p.cfDesc                               ?   p.cfDesc                              : null;
        d.userPin                = p.userPin                              ?   p.userPin                             : null;
        d.adminPin               = p.adminPin                             ?   p.adminPin                               : null;
        d.langID                 = p.langID                               ?   p.langID                              : null;
        d.record_id              = p.record_id                            ?   p.record_id                           : null;
        d.leaderWait             = checkType(p.leaderWait)                ?   Boolean(p.leaderWait)        : null;
        d.leaderLeave            = checkType(p.leaderLeave)               ?   Boolean(p.leaderLeave)        : null;
        d.talkerOptimization            = checkType(p.talkerOptimization)               ?   Boolean(p.talkerOptimization): null;
        d.talkerDetection        = checkType(p.talkerDetection)           ?   Boolean(p.talkerDetection)      : null;
        d.quiteMode              = checkType(p.quiteMode)                 ?   Boolean(p.quiteMode)      : null;
        d.userCount              = checkType(p.userCount)                 ?   Boolean(p.userCount)      : null;
        d.userJoinLeave          = checkType(p.userJoinLeave)             ?   Boolean(p.userJoinLeave)      : null;
        d.moh                    = checkType(p.moh)                       ?   Boolean(p.moh)      : null;
        d.mohClass               = p.mohClass                             ?   p.mohClass     : null;
        d.allowMenu              = checkType(p.allowMenu)                 ?   Boolean(p.allowMenu)      : null;
        d.recordConference       = checkType(p.recordConference)          ?   Boolean(p.recordConference)      : null;
        d.maxParticipants        = p.maxParticipants                      ?   p.maxParticipants                              : null;
        d.muteOnJoin             = checkType(p.muteOnJoin)                ?   Boolean(p.muteOnJoin)      : null;
        d.isActive               = checkType(p.isActive)                  ?   Boolean(p.isActive)                  : null;
    }
}

const model = new astConferenceModel();
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