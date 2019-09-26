class astQueueModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.name                        = p.name                           ? p.name                    : null;
        this.timeout                     = p.timeout                        ? p.timeout                 : null;
        this.retry                       = p.retry                          ? p.retry                   : null;
        this.wrapuptime                  = p.wrapuptime                     ? p.wrapuptime              : null;
        this.servicelevel                = p.servicelevel                   ? p.servicelevel            : null;
        this.strategy                    = p.strategy                       ? p.strategy                : null;
        this.joinempty                   = p.joinempty                      ? p.joinempty               : null;
        this.leavewhenempty              = p.leavewhenempty                 ? p.leavewhenempty          : null;
        this.memberdelay                 = p.memberdelay     !== undefined  ? p.memberdelay             : null;
        this.timeoutrestart              = p.timeoutrestart  !== undefined  ? p.timeoutrestart          : null;
        this.ringinuse                   = p.ringinuse       !== undefined  ? p.ringinuse               : null;
        this.announce                    = p.announce                       ? p.announce                : null;
        this.musiconhold                 = p.musiconhold                    ? p.musiconhold             : null;
        this.queue_youarenext            = p.queue_youarenext               ? p.queue_youarenext        : null;
        this.queue_thereare              = p.queue_thereare                 ? p.queue_thereare          : null;
        this.queue_callswaiting          = p.queue_callswaiting             ? p.queue_callswaiting      : null;
        this.queue_holdtime              = p.queue_holdtime                 ? p.queue_holdtime          : null;
        this.queue_minutes               = p.queue_minutes                  ? p.queue_minutes           : null;
        this.queue_seconds               = p.queue_seconds                  ? p.queue_seconds           : null;
        this.queue_lessthan              = p.queue_lessthan                 ? p.queue_lessthan          : null;
        this.queue_thankyou              = p.queue_thankyou                 ? p.queue_thankyou          : null;
        this.queue_reporthold            = p.queue_reporthold               ? p.queue_reporthold        : null;
        this.announce_frequency          = p.announce_frequency             ? p.announce_frequency      : null;
        this.announce_round_seconds      = p.announce_round_seconds         ? p.announce_round_seconds  : null;
        this.announce_holdtime           = p.announce_holdtime              ? p.announce_holdtime       : null;
        this.maxlen                      = p.maxlen                         ? p.maxlen                  : null;
        this.eventmemberstatus           = p.eventmemberstatus              ? p.eventmemberstatus       : null;
        this.eventwhencalled             = p.eventwhencalled                ? p.eventwhencalled         : null;
        this.reportholdtime              = p.reportholdtime                 ? p.reportholdtime          : null;
        this.weight                      = p.weight                         ? p.weight                  : null;
        this.periodic_announce           = p.periodic_announce              ? p.periodic_announce       : null;
        this.periodic_announce_frequency = p.periodic_announce_frequency    ? p.periodic_announce_frequency : null;
        this.setinterfacevar             = p.setinterfacevar                ? p.setinterfacevar         : null;
        this.queID                       = p.queID                          ? parseInt(p.queID)         : null;
        this.context                     = p.context                        ? p.context                 : null;
        this.monitor_format              = p.monitor_format                 ? p.monitor_format          : null;
        this.monitor_join                = p.monitor_join                   ? p.monitor_join            : null;
        this.fail_destination            = p.fail_destination               ? parseInt(p.fail_destination)      : null;
        this.fail_destdata               = p.fail_destdata                  ? parseInt(p.fail_destdata)         : null;
        this.fail_destdata2              = p.fail_destdata2                 ? p.fail_destdata2.toString()       : null ;
        this.max_wait_time               = p.max_wait_time                  ? parseInt(p.max_wait_time)         : null;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        //this.new_name       = p.new_name        ? p.new_name        : p.name ;
        this.name                        = p.name                           ? p.name                    : null;
        this.timeout                     = p.timeout                        ? p.timeout                 : 0 ;
        this.retry                       = p.retry                          ? p.retry                   : 0 ;
        this.wrapuptime                  = p.wrapuptime                     ? p.wrapuptime              : 0 ;
        this.servicelevel                = p.servicelevel                   ? p.servicelevel            : 0 ;
        this.strategy                    = p.strategy                       ? p.strategy                : "ringall";
        this.joinempty                   = p.joinempty                      ? p.joinempty               : null ;
        this.leavewhenempty              = p.leavewhenempty                 ? p.leavewhenempty          : null ;
        this.memberdelay                 = p.memberdelay     !== undefined  ? p.memberdelay             : 0 ;
        this.timeoutrestart              = p.timeoutrestart  !== undefined  ? p.timeoutrestart          : 0 ;
        this.ringinuse                   = p.ringinuse       !== undefined  ? p.ringinuse               : 0 ;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        //this.name           = p.name            ? p.name            : "" ;
        this.name                        = p.name                           ? p.name                    : null;
        this.timeout                     = p.timeout                        ? p.timeout                 : 0 ;
        this.retry                       = p.retry                          ? p.retry                   : 0 ;
        this.wrapuptime                  = p.wrapuptime                     ? p.wrapuptime              : 0 ;
        this.servicelevel                = p.servicelevel                   ? p.servicelevel            : 0 ;
        this.strategy                    = p.strategy                       ? p.strategy                : "ringall";
        this.joinempty                   = p.joinempty                      ? p.joinempty               : null ;
        this.leavewhenempty              = p.leavewhenempty                 ? p.leavewhenempty          : null ;
        this.memberdelay                 = p.memberdelay     !== undefined  ? p.memberdelay             : 0 ;
        this.timeoutrestart              = p.timeoutrestart  !== undefined  ? p.timeoutrestart          : 0 ;
        this.ringinuse                   = p.ringinuse       !== undefined  ? p.ringinuse               : 0 ;
        this.queID                       = p.queID                          ? p.queID                   : lookUp(API.us.Sequence, 'queID').seqValue;
        this.isActive                    = isBoolean(p.isActive)            ? Boolean(p.isActive)       : true ;
        return this;
    }
}