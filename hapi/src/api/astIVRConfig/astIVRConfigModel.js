/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');
class astIVRConfigModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find:   'ast_GetIVRConfig',
            Insert: 'ast_InsIVRConfig',
            Update: 'ast_UpdIVRConfig',
            Delete: 'ast_DelIVRConfig'
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
        d.id_ivr_config = p.id_ivr_config !== undefined ? p.id_ivr_config : null;
        d.ivr_name = p.ivr_name ? p.ivr_name : null;
        d.ivr_description = p.ivr_description ? p.ivr_description : null;
        d.record_id = p.record_id ? p.record_id.toString() : null;
        //d.enable_direct_dial            = p.enable_direct_dial                ? checkType(p.enable_direct_dial[0])    ?   Boolean(p.enable_direct_dial[0]) : false : null;
        d.enable_direct_dial = p.enable_direct_dial === 'null' ? false : p.enable_direct_dial;
        d.timeout = p.timeout !== undefined ? p.timeout : null;
        d.alert_info = p.alert_info ? p.alert_info : null;
        d.volume = p.volume ? p.volume : null;
        d.invalid_retries = p.invalid_retries !== undefined ? p.invalid_retries : null;
        d.retry_record_id = p.retry_record_id ? p.retry_record_id.toString() : null;
        //d.append_record_to_invalid      = p.append_record_to_invalid                ? checkType(p.append_record_to_invalid[0])    ?   Boolean(p.append_record_to_invalid[0]) : false : null;
        //d.return_on_invalid             = p.return_on_invalid                ? checkType(p.return_on_invalid[0])    ?   Boolean(p.return_on_invalid[0]) : false : null;
        d.append_record_to_invalid = p.append_record_to_invalid === 'null' ? false : p.append_record_to_invalid;
        d.return_on_invalid = p.return_on_invalid === 'null' ? false : p.return_on_invalid;
        d.invalid_record_id = p.invalid_record_id ? p.invalid_record_id.toString() : null;
        d.invalid_destination = p.invalid_destination ? p.invalid_destination : null;
        d.invalid_destdata = p.invalid_destdata ? p.invalid_destdata : null;
        d.invalid_destdata2 = p.invalid_destdata2 ? p.invalid_destdata2 : null;
        d.timeout_retries = p.timeout_retries !== undefined ? p.timeout_retries : null;
        d.timeout_retry_record_id = p.timeout_retry_record_id ? p.timeout_retry_record_id.toString() : null;
        //d.append_record_on_timeout      = p.append_record_on_timeout                ? checkType(p.append_record_on_timeout[0])    ?   Boolean(p.append_record_on_timeout[0]) : false : null;
        //d.return_on_timeout             = p.return_on_timeout                       ? checkType(p.return_on_timeout[0])    ?   Boolean(p.return_on_timeout[0]) : false : null;
        d.append_record_on_timeout = p.append_record_on_timeout === 'null' ? false : p.append_record_on_timeout;
        d.return_on_timeout = p.return_on_timeout === 'null' ? false : p.return_on_timeout;
        d.timeout_record_id = p.timeout_record_id ? p.timeout_record_id.toString() : null;
        d.timeout_destination = p.timeout_destination ? p.timeout_destination : null;
        d.timeout_destdata = p.timeout_destdata ? p.timeout_destdata : null;
        d.timeout_destdata2 = p.timeout_destdata2 ? p.timeout_destdata2 : null;
        //d.return_to_ivr_after_vm        = p.return_to_ivr_after_vm                  ? checkType(p.return_to_ivr_after_vm[0])    ?   Boolean(p.return_to_ivr_after_vm[0]) : false : null;
        d.return_to_ivr_after_vm = p.return_to_ivr_after_vm === 'null' ? false : p.return_to_ivr_after_vm;
        d.ttsID = p.ttsID ? p.ttsID.filter(x => x).join() : null;
        //d.isActive                      = p.isActive                                ? checkType(p.isActive[0])    ?   Boolean(p.isActive[0]) : false : null;
        d.isActive = p.isActive === 'null' ? false : p.isActive;
        d.offset = p.offset ? p.offset : null;
        d.limit = p.limit ? p.limit : null;
    }
}

class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID                          = p.HIID  !== undefined                     ?   p.HIID                                      : null;
        d.id_ivr_config                 = p.id_ivr_config    !== undefined          ?   p.id_ivr_config                             : null;
        d.ivr_name                      = p.ivr_name                                ?   p.ivr_name                                  : null;
        d.ivr_description               = p.ivr_description                         ?   p.ivr_description                           : null;
        d.record_id                     = p.record_id                               ?   p.record_id.toString()                      : null;
        d.enable_direct_dial            = checkType(p.enable_direct_dial[0])        ?   Boolean(p.enable_direct_dial[0])            : false;
        d.timeout                       = p.timeout          !== undefined          ?   p.timeout                                   : null;
        d.alert_info                    = p.alert_info                              ?   p.alert_info                                : null;
        d.volume                        = p.volume                                  ?   p.volume                                    : null;
        d.invalid_retries               = p.invalid_retries     !== undefined       ?   p.invalid_retries                           : null;
        d.retry_record_id               = p.retry_record_id                         ?   p.retry_record_id.toString()                : null;
        d.append_record_to_invalid      = checkType(p.append_record_to_invalid[0])  ?   Boolean(p.append_record_to_invalid[0])      : false;
        d.return_on_invalid             = checkType(p.return_on_invalid[0])         ?   Boolean(p.return_on_invalid[0])             : false;
        d.invalid_record_id             = p.invalid_record_id                       ?   p.invalid_record_id.toString()              : 0;
        d.invalid_destination           = p.invalid_destination                     ?   p.invalid_destination                       : null;
        d.invalid_destdata              = p.invalid_destdata                        ?   p.invalid_destdata                          : null;
        d.invalid_destdata2             = p.invalid_destdata2                       ?   p.invalid_destdata2                         : null;
        d.timeout_retries               = p.timeout_retries       !== undefined     ?   p.timeout_retries                           : null;
        d.timeout_retry_record_id       = p.timeout_retry_record_id                 ?   p.timeout_retry_record_id.toString()        : 0;
        d.append_record_on_timeout      = checkType(p.append_record_on_timeout[0])  ?   Boolean(p.append_record_on_timeout[0])      : false;
        d.return_on_timeout             = checkType(p.return_on_timeout[0])         ?   Boolean(p.return_on_timeout[0])             : false;
        d.timeout_record_id             = p.timeout_record_id                       ?   p.timeout_record_id.toString()              : 0;
        d.timeout_destination           = p.timeout_destination                     ?   p.timeout_destination                       : null;
        d.timeout_destdata              = p.timeout_destdata                        ?   p.timeout_destdata                          : null;
        d.timeout_destdata2             = p.timeout_destdata2                       ?   p.timeout_destdata2                         : null;
        d.return_to_ivr_after_vm        = checkType(p.return_to_ivr_after_vm[0])    ?   Boolean(p.return_to_ivr_after_vm[0])        : false;
        d.ttsID                         = p.ttsID                                   ?   p.ttsID                                     : null;
        d.isActive                      = checkType(p.isActive[0])                  ?   Boolean(p.isActive[0])                      : false;
        d.offset                        = p.offset                                  ?   p.offset                                    : null;
        d.limit                         = p.limit                                   ?   p.limit                                     : null;
    }
}

class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token                         = p.token;
        d.id_ivr_config                 = p.id_ivr_config                           ?   p.id_ivr_config                                 : null;
        d.ivr_name                      = p.ivr_name                                ?   p.ivr_name                                      : null;
        d.ivr_description               = p.ivr_description                         ?   p.ivr_description                               : null;
        d.record_id                     = p.record_id   !== undefined               ?   p.record_id.filter(x => x).join()               : null;
        d.enable_direct_dial            = checkType(p.enable_direct_dial)           ?   Boolean(p.enable_direct_dial)                   : false;
        d.timeout                       = p.timeout        !== undefined            ?   p.timeout                                       : null;
        d.alert_info                    = p.alert_info                              ?   p.alert_info                                    : null;
        d.volume                        = p.volume                                  ?   p.volume                                        : null;
        d.invalid_retries               = p.invalid_retries   !== undefined         ?   p.invalid_retries                               : null;
        d.retry_record_id               = p.retry_record_id  !== undefined          ?   p.retry_record_id.filter(x => x).join()         : null;
        d.append_record_to_invalid      = checkType(p.append_record_to_invalid)     ?   Boolean(p.append_record_to_invalid)             : false;
        d.return_on_invalid             = checkType(p.return_on_invalid)            ?   Boolean(p.return_on_invalid)                    : false;
        d.invalid_record_id             = p.invalid_record_id   !== undefined       ?   p.invalid_record_id.filter(x => x).join()       : 0;
        d.invalid_destination           = p.invalid_destination                     ?   p.invalid_destination                           : null;
        d.invalid_destdata              = p.invalid_destdata                        ?   p.invalid_destdata                              : null;
        d.invalid_destdata2             = p.invalid_destdata2                       ?   p.invalid_destdata2                             : null;
        d.timeout_retries               = p.timeout_retries     !== undefined       ?   p.timeout_retries                               : null;
        d.timeout_retry_record_id       = p.timeout_retry_record_id  !== undefined  ?   p.timeout_retry_record_id.filter(x => x).join() : 0;
        d.append_record_on_timeout      = checkType(p.append_record_on_timeout)     ?   Boolean(p.append_record_on_timeout)             : false;
        d.return_on_timeout             = checkType(p.return_on_timeout)            ?   Boolean(p.return_on_timeout)                    : false;
        d.timeout_record_id             = p.timeout_record_id        !== undefined  ?   p.timeout_record_id.filter(x => x).join()       : 0;
        d.timeout_destination           = p.timeout_destination                     ?   p.timeout_destination                           : null;
        d.timeout_destdata              = p.timeout_destdata                        ?   p.timeout_destdata                              : null;
        d.timeout_destdata2             = p.timeout_destdata2                       ?   p.timeout_destdata2                             : null;
        d.return_to_ivr_after_vm        = checkType(p.return_to_ivr_after_vm)       ?   Boolean(p.return_to_ivr_after_vm)               : false;
        d.ttsID = p.ttsID ? p.ttsID.filter(x => x).join() : null;
        d.isActive                      = checkType(p.isActive)                     ?   Boolean(p.isActive)                             : false;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token                         = p.token;
        d.HIID                          = p.HIID  !== undefined                     ?   p.HIID                                          : null;
        d.id_ivr_config                 = p.id_ivr_config   !== undefined           ?   p.id_ivr_config                                 : null;
        d.ivr_name                      = p.ivr_name                                ?   p.ivr_name                                      : null;
        d.ivr_description               = p.ivr_description                         ?   p.ivr_description                               : null;
        d.record_id                     = p.record_id      !== undefined            ?   p.record_id.filter(x => x).join()               : null;
        d.enable_direct_dial            = checkType(p.enable_direct_dial)           ?   Boolean(p.enable_direct_dial)                   : false;
        d.timeout                       = p.timeout           !== undefined         ?   p.timeout                                       : null;
        d.alert_info                    = p.alert_info                              ?   p.alert_info                                    : null;
        d.volume                        = p.volume                                  ?   p.volume                                        : null;
        d.invalid_retries               = p.invalid_retries    !== undefined        ?   p.invalid_retries                               : null;
        d.retry_record_id               = p.retry_record_id    !== undefined        ?   p.retry_record_id.filter(x => x).join()         : null;
        d.append_record_to_invalid      = checkType(p.append_record_to_invalid)     ?   Boolean(p.append_record_to_invalid)             : false;
        d.return_on_invalid             = checkType(p.return_on_invalid)            ?   Boolean(p.return_on_invalid)                    : false;
        d.invalid_record_id             = p.invalid_record_id     !== undefined     ?   p.invalid_record_id.filter(x => x).join()       : 0;
        d.invalid_destination           = p.invalid_destination                     ?   p.invalid_destination                           : null;
        d.invalid_destdata              = p.invalid_destdata                        ?   p.invalid_destdata                              : null;
        d.invalid_destdata2             = p.invalid_destdata2                       ?   p.invalid_destdata2                             : null;
        d.timeout_retries               = p.timeout_retries        !== undefined    ?   p.timeout_retries                               : null;
        d.timeout_retry_record_id       = p.timeout_retry_record_id  !== undefined  ?   p.timeout_retry_record_id.filter(x => x).join() : 0;
        d.append_record_on_timeout      = checkType(p.append_record_on_timeout)     ?   Boolean(p.append_record_on_timeout)             : false;
        d.return_on_timeout             = checkType(p.return_on_timeout)            ?   Boolean(p.return_on_timeout)                    : false;
        d.timeout_record_id             = p.timeout_record_id    !== undefined      ?   p.timeout_record_id.filter(x => x).join()       : 0;
        d.timeout_destination           = p.timeout_destination                     ?   p.timeout_destination                           : null;
        d.timeout_destdata              = p.timeout_destdata                        ?   p.timeout_destdata                              : null;
        d.timeout_destdata2             = p.timeout_destdata2                       ?   p.timeout_destdata2                             : null;
        d.return_to_ivr_after_vm        = checkType(p.return_to_ivr_after_vm)       ?   Boolean(p.return_to_ivr_after_vm)               : false;
        d.ttsID = p.ttsID ? p.ttsID.filter(x => x).join() : null;
        d.isActive                      = checkType(p.isActive)                     ?   Boolean(p.isActive)                             : false;
    }
}
const model = new astIVRConfigModel();
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