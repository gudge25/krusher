/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');
class astQueueModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find:   'ast_GetQueue',
            Insert: 'ast_InsQueue',
            Update: 'ast_UpdQueue',
            Delete: 'ast_DelQueue'
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
        d.queID                             = p.queID                           ?   p.queID                         : null;
        d.name                              = p.name                            ?   p.name                          : null;
        d.musiconhold                       = p.musiconhold                     ?   p.musiconhold                   : null;
        d.announce                          = p.announce                        ?   p.announce                      : null;
        d.context                           = p.context                         ?   p.context                       : null;
        d.timeout                           = p.timeout                         ?   p.timeout                       : null;
        d.monitor_join                      = p.monitor_join                    ?   p.monitor_join                  : null;
        d.monitor_format                    = p.monitor_format                  ?   p.monitor_format                : null;
        d.queue_youarenext                  = p.queue_youarenext                ?   p.queue_youarenext              : null;
        d.queue_thereare                    = p.queue_thereare                  ?   p.queue_thereare                : null;
        d.queue_callswaiting                = p.queue_callswaiting              ?   p.queue_callswaiting            : null;
        d.$queue_holdtime                   = p.queue_holdtime                  ?   p.queue_holdtime                : null;
        d.queue_minutes                     = p.queue_minutes                   ?   p.queue_minutes                 : null;
        d.queue_seconds                     = p.queue_seconds                   ?   p.queue_seconds                 : null;
        d.queue_lessthan                    = p.queue_lessthan                  ?   p.queue_lessthan                : null;
        d.queue_thankyou                    = p.queue_thankyou                  ?   p.queue_thankyou                : null;
        d.queue_reporthold                  = p.queue_reporthold                ?   p.queue_reporthold              : null;
        d.announce_frequency                = p.announce_frequency              ?   p.announce_frequency            : null;
        d.announce_round_seconds            = p.announce_round_seconds          ?   p.announce_round_seconds        : null;
        d.announce_holdtime                 = p.announce_holdtime               ?   p.announce_holdtime             : null;
        d.retry                             = p.retry                           ?   p.retry                         : null;
        d.wrapuptime                        = p.wrapuptime                      ?   p.wrapuptime                    : null;
        d.maxlen                            = p.maxlen                          ?   p.maxlen                        : null;
        d.servicelevel                      = p.servicelevel                    ?   p.servicelevel                  : null;
        d.strategy                          = p.strategy                        ?   p.strategy                      : null;
        d.joinempty                         = p.joinempty                       ?   p.joinempty                     : null;
        d.leavewhenempty                    = p.leavewhenempty                  ?   p.leavewhenempty                : null;
        d.eventmemberstatus                 = p.eventmemberstatus               ?   p.eventmemberstatus             : null;
        d.eventwhencalled                   = p.eventwhencalled                 ?   p.eventwhencalled               : null;
        d.reportholdtime                    = p.reportholdtime                  ?   p.reportholdtime                : null;
        d.memberdelay                       = p.memberdelay                     ?   p.memberdelay                   : null;
        d.weight                            = p.weight                          ?   p.weight                        : null;
        d.timeoutrestart                    = p.timeoutrestart                  ?   p.timeoutrestart                : null;
        d.periodic_announce                 = p.periodic_announce               ?   p.periodic_announce             : null;
        d.periodic_announce_frequency       = p.periodic_announce_frequency     ?   p.periodic_announce_frequency   : null;
        d.ringinuse                         = p.ringinuse                       ?   p.ringinuse                     : null;
        d.setinterfacevar                   = p.setinterfacevar                 ?   p.setinterfacevar               : null;
        d.max_wait_time                     = p.max_wait_time                   ?   p.max_wait_time                 : null;
        d.fail_destination                  = p.fail_destination                ?   p.fail_destination              : null;
        d.fail_destdata                     = p.fail_destdata                   ?   p.fail_destdata                 : null;
        d.fail_destdata2                    = p.fail_destdata2                  ?   p.fail_destdata2                : null;
        d.isActive = p.isActive ? checkType(p.isActive[0]) ? Boolean(p.isActive[0]) : false : null;
        d.offset                            = p.offset                          ?   p.offset                        : null;
        d.limit                             = p.limit                           ?   p.limit                         : null;
    }
}

class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.queID                             = p.queID                           ?   p.queID                         : null;
        d.name                              = p.name                            ?   p.name                          : null;
        d.musiconhold                       = p.musiconhold                     ?   p.musiconhold                   : null;
        d.announce                          = p.announce                        ?   p.announce                      : null;
        d.context                           = p.context                         ?   p.context                       : null;
        d.timeout                           = p.timeout                         ?   p.timeout                       : null;
        d.monitor_join                      = p.monitor_join                    ?   p.monitor_join                  : null;
        d.monitor_format                    = p.monitor_format                  ?   p.monitor_format                : null;
        d.queue_youarenext                  = p.queue_youarenext                ?   p.queue_youarenext              : null;
        d.queue_thereare                    = p.queue_thereare                  ?   p.queue_thereare                : null;
        d.queue_callswaiting                = p.queue_callswaiting              ?   p.queue_callswaiting            : null;
        d.$queue_holdtime                   = p.queue_holdtime                  ?   p.queue_holdtime                : null;
        d.queue_minutes                     = p.queue_minutes                   ?   p.queue_minutes                 : null;
        d.queue_seconds                     = p.queue_seconds                   ?   p.queue_seconds                 : null;
        d.queue_lessthan                    = p.queue_lessthan                  ?   p.queue_lessthan                : null;
        d.queue_thankyou                    = p.queue_thankyou                  ?   p.queue_thankyou                : null;
        d.queue_reporthold                  = p.queue_reporthold                ?   p.queue_reporthold              : null;
        d.announce_frequency                = p.announce_frequency              ?   p.announce_frequency            : null;
        d.announce_round_seconds            = p.announce_round_seconds          ?   p.announce_round_seconds        : null;
        d.announce_holdtime                 = p.announce_holdtime               ?   p.announce_holdtime             : null;
        d.retry                             = p.retry                           ?   p.retry                         : null;
        d.wrapuptime                        = p.wrapuptime                      ?   p.wrapuptime                    : null;
        d.maxlen                            = p.maxlen                          ?   p.maxlen                        : null;
        d.servicelevel                      = p.servicelevel                    ?   p.servicelevel                  : null;
        d.strategy                          = p.strategy                        ?   p.strategy                      : null;
        d.joinempty                         = p.joinempty                       ?   p.joinempty                     : null;
        d.leavewhenempty                    = p.leavewhenempty                  ?   p.leavewhenempty                : null;
        d.eventmemberstatus                 = p.eventmemberstatus               ?   p.eventmemberstatus             : null;
        d.eventwhencalled                   = p.eventwhencalled                 ?   p.eventwhencalled               : null;
        d.reportholdtime                    = p.reportholdtime                  ?   p.reportholdtime                : null;
        d.memberdelay                       = p.memberdelay                     ?   p.memberdelay                   : null;
        d.weight                            = p.weight                          ?   p.weight                        : null;
        d.timeoutrestart                    = p.timeoutrestart                  ?   p.timeoutrestart                : null;
        d.periodic_announce                 = p.periodic_announce               ?   p.periodic_announce             : null;
        d.periodic_announce_frequency       = p.periodic_announce_frequency     ?   p.periodic_announce_frequency   : null;
        d.ringinuse                         = p.ringinuse                       ?   p.ringinuse                     : null;
        d.setinterfacevar                   = p.setinterfacevar                 ?   p.setinterfacevar               : null;
        d.max_wait_time                     = p.max_wait_time                   ?   p.max_wait_time                 : null;
        d.fail_destination                  = p.fail_destination                ?   p.fail_destination              : null;
        d.fail_destdata                     = p.fail_destdata                   ?   p.fail_destdata                 : null;
        d.fail_destdata2                    = p.fail_destdata2                  ?   p.fail_destdata2                : null;
        d.isActive                          = checkType(p.isActive)             ?   Boolean(p.isActive)             : false;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID = p.HIID;
        d.queID                             = p.queID                           ?   p.queID                         : null;
        d.name                              = p.name                            ?   p.name                          : null;
        d.musiconhold                       = p.musiconhold                     ?   p.musiconhold                   : null;
        d.announce                          = p.announce                        ?   p.announce                      : null;
        d.context                           = p.context                         ?   p.context                       : null;
        d.timeout                           = p.timeout                         ?   p.timeout                       : null;
        d.monitor_join                      = p.monitor_join                    ?   p.monitor_join                  : null;
        d.monitor_format                    = p.monitor_format                  ?   p.monitor_format                : null;
        d.queue_youarenext                  = p.queue_youarenext                ?   p.queue_youarenext              : null;
        d.queue_thereare                    = p.queue_thereare                  ?   p.queue_thereare                : null;
        d.queue_callswaiting                = p.queue_callswaiting              ?   p.queue_callswaiting            : null;
        d.$queue_holdtime                   = p.queue_holdtime                  ?   p.queue_holdtime                : null;
        d.queue_minutes                     = p.queue_minutes                   ?   p.queue_minutes                 : null;
        d.queue_seconds                     = p.queue_seconds                   ?   p.queue_seconds                 : null;
        d.queue_lessthan                    = p.queue_lessthan                  ?   p.queue_lessthan                : null;
        d.queue_thankyou                    = p.queue_thankyou                  ?   p.queue_thankyou                : null;
        d.queue_reporthold                  = p.queue_reporthold                ?   p.queue_reporthold              : null;
        d.announce_frequency                = p.announce_frequency              ?   p.announce_frequency            : null;
        d.announce_round_seconds            = p.announce_round_seconds          ?   p.announce_round_seconds        : null;
        d.announce_holdtime                 = p.announce_holdtime               ?   p.announce_holdtime             : null;
        d.retry                             = p.retry                           ?   p.retry                         : null;
        d.wrapuptime                        = p.wrapuptime                      ?   p.wrapuptime                    : null;
        d.maxlen                            = p.maxlen                          ?   p.maxlen                        : null;
        d.servicelevel                      = p.servicelevel                    ?   p.servicelevel                  : null;
        d.strategy                          = p.strategy                        ?   p.strategy                      : null;
        d.joinempty                         = p.joinempty                       ?   p.joinempty                     : null;
        d.leavewhenempty                    = p.leavewhenempty                  ?   p.leavewhenempty                : null;
        d.eventmemberstatus                 = p.eventmemberstatus               ?   p.eventmemberstatus             : null;
        d.eventwhencalled                   = p.eventwhencalled                 ?   p.eventwhencalled               : null;
        d.reportholdtime                    = p.reportholdtime                  ?   p.reportholdtime                : null;
        d.memberdelay                       = p.memberdelay                     ?   p.memberdelay                   : null;
        d.weight                            = p.weight                          ?   p.weight                        : null;
        d.timeoutrestart                    = p.timeoutrestart                  ?   p.timeoutrestart                : null;
        d.periodic_announce                 = p.periodic_announce               ?   p.periodic_announce             : null;
        d.periodic_announce_frequency       = p.periodic_announce_frequency     ?   p.periodic_announce_frequency   : null;
        d.ringinuse                         = p.ringinuse                       ?   p.ringinuse                     : null;
        d.setinterfacevar                   = p.setinterfacevar                 ?   p.setinterfacevar               : null;
        d.max_wait_time                     = p.max_wait_time                   ?   p.max_wait_time                 : null;
        d.fail_destination                  = p.fail_destination                ?   p.fail_destination              : null;
        d.fail_destdata                     = p.fail_destdata                   ?   p.fail_destdata                 : null;
        d.fail_destdata2                    = p.fail_destdata2                  ?   p.fail_destdata2                : null;
        d.isActive                          = checkType(p.isActive)             ?   Boolean(p.isActive)             : false;
    }
}
const model = new astQueueModel();
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