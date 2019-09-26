class astIVRModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.id_ivr_config             = p.id_ivr_config                        ? p.id_ivr_config                     : null ;
        this.ivr_name                  = p.ivr_name                             ? p.ivr_name                          : null ;
        this.ivr_description           = p.ivr_description                      ? p.ivr_description.toString()        : null ;
        this.enable_direct_dial        = isBoolean(p.enable_direct_dial)        ? Boolean(p.enable_direct_dial)       : null ;
        this.timeout                   = p.timeout !== undefined                ? p.timeout                           : null ;
        this.alert_info                = p.alert_info !== undefined             ? p.alert_info                        : null ;
        this.volume                    = p.volume  !== undefined                ? p.volume                            : null ;
        this.invalid_retries           = p.invalid_retries  !== undefined       ? p.invalid_retries                   : null ;
        this.record_id                 = p.record_id                            ? p.record_id                         : null ;
        this.invalid_record_id         = p.invalid_record_id                    ? p.invalid_record_id                 : null ;
        this.timeout_retry_record_id   = p.timeout_retry_record_id              ? p.timeout_retry_record_id           : null ;
        this.timeout_record_id         = p.timeout_record_id                    ? p.timeout_record_id                 : null ;
        this.retry_record_id           = p.retry_record_id                      ? p.retry_record_id                   : null ;
        this.append_record_to_invalid  = isBoolean(p.append_record_to_invalid)  ? Boolean(p.append_record_to_invalid) : null ;
        this.return_on_invalid         = isBoolean(p.return_on_invalid)         ? Boolean(p.return_on_invalid)        : null ;
        this.invalid_destination       = p.invalid_destination                  ? parseInt(p.invalid_destination)     : null ;
        this.invalid_destdata          = p.invalid_destdata                     ? parseInt(p.invalid_destdata)        : null ;
        this.invalid_destdata2         = p.invalid_destdata2                    ? p.invalid_destdata2.toString()      : null ;
        this.timeout_retries           = p.timeout_retries !== undefined        ? p.timeout_retries                   : null ;
        this.append_record_on_timeout  = isBoolean(p.append_record_on_timeout)  ? Boolean(p.append_record_on_timeout) : null ;
        this.return_on_timeout         = isBoolean(p.return_on_timeout)         ? Boolean(p.return_on_timeout)        : null ;
        this.timeout_destination       = p.timeout_destination                  ? parseInt(p.timeout_destination)     : null ;
        this.timeout_destdata          = p.timeout_destdata                     ? parseInt(p.timeout_destdata)        : null ;
        this.timeout_destdata2         = p.timeout_destdata2                    ? p.timeout_destdata2.toString()      : null ;
        this.return_to_ivr_after_vm    = isBoolean(p.return_to_ivr_after_vm)    ? Boolean(p.return_to_ivr_after_vm)   : null ;
        this.ttsID                     = p.ttsID                                ? p.ttsID                             : null ;
    }

    postFind(){
        super.postFind();
        let p = this.p; delete this.p;
        return this;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.record_id                 = p.record_id                            ? p.record_id.split(",").map( a => parseInt(a) )                    : null ;
        this.invalid_record_id         = p.invalid_record_id                    ? p.invalid_record_id.split(",").map( a => parseInt(a) )            : null ;
        this.timeout_retry_record_id   = p.timeout_retry_record_id              ? p.timeout_retry_record_id.split(",").map( a => parseInt(a) )      : null ;
        this.timeout_record_id         = p.timeout_record_id                    ? p.timeout_record_id.split(",").map( a => parseInt(a) )            : null ;
        this.retry_record_id           = p.retry_record_id                      ? p.retry_record_id.split(",").map( a => parseInt(a) )              : null ;
        this.ttsID                     = p.ttsID                                ? p.ttsID.toString().split(",").map( a => parseInt(a) )             : null ;
        return this;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        this.enable_direct_dial        = isBoolean(p.enable_direct_dial)        ? Boolean(p.enable_direct_dial)       : false ;
        this.append_record_to_invalid  = isBoolean(p.append_record_to_invalid)  ? Boolean(p.append_record_to_invalid) : false ;
        this.return_on_invalid         = isBoolean(p.return_on_invalid)         ? Boolean(p.return_on_invalid)        : false ;
        this.append_record_on_timeout  = isBoolean(p.append_record_on_timeout)  ? Boolean(p.append_record_on_timeout) : false ;
        this.return_on_timeout         = isBoolean(p.return_on_timeout)         ? Boolean(p.return_on_timeout)        : false ;
        this.return_to_ivr_after_vm    = isBoolean(p.return_to_ivr_after_vm)    ? Boolean(p.return_to_ivr_after_vm)   : false ;
        this.isActive                  = isBoolean(p.isActive)                  ? Boolean(p.isActive)                 : true ;
        this.alert_info                = p.alert_info                           ? p.alert_info.toString()             : null ;
        this.record_id                 = p.record_id                            ? p.record_id                         : [] ;
        this.invalid_record_id         = p.invalid_record_id                    ? p.invalid_record_id                 : [] ;
        this.timeout_retry_record_id   = p.timeout_retry_record_id              ? p.timeout_retry_record_id           : [] ;
        this.timeout_record_id         = p.timeout_record_id                    ? p.timeout_record_id                 : [] ;
        this.retry_record_id           = p.retry_record_id                      ? p.retry_record_id                   : [] ;
        this.ttsID                     = p.ttsID                                ? p.ttsID                             : [] ;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.id_ivr_config             = p.id_ivr_config                        ? p.id_ivr_config                     : lookUp(API.us.Sequence, 'id_ivr_config').seqValue;
        this.enable_direct_dial        = isBoolean(p.enable_direct_dial)        ? Boolean(p.enable_direct_dial)       : false ;
        this.append_record_to_invalid  = isBoolean(p.append_record_to_invalid)  ? Boolean(p.append_record_to_invalid) : false ;
        this.return_on_invalid         = isBoolean(p.return_on_invalid)         ? Boolean(p.return_on_invalid)        : false ;
        this.append_record_on_timeout  = isBoolean(p.append_record_on_timeout)  ? Boolean(p.append_record_on_timeout) : false ;
        this.return_on_timeout         = isBoolean(p.return_on_timeout)         ? Boolean(p.return_on_timeout)        : false ;
        this.return_to_ivr_after_vm    = isBoolean(p.return_to_ivr_after_vm)    ? Boolean(p.return_to_ivr_after_vm)   : false ;
        this.isActive                  = isBoolean(p.isActive)                  ? Boolean(p.isActive)                 : true ;
        this.alert_info                = p.alert_info                           ? p.alert_info.toString()             : null ;
        this.record_id                 = p.record_id                            ? p.record_id                         : [] ;
        this.invalid_record_id         = p.invalid_record_id                    ? p.invalid_record_id                 : [] ;
        this.timeout_retry_record_id   = p.timeout_retry_record_id              ? p.timeout_retry_record_id           : [] ;
        this.timeout_record_id         = p.timeout_record_id                    ? p.timeout_record_id                 : [] ;
        this.retry_record_id           = p.retry_record_id                      ? p.retry_record_id                   : [] ;
        this.ttsID                     = p.ttsID                                ? p.ttsID                             : [] ;
        return this;
    }
}