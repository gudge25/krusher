class astConferenceModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.cfID                = p.cfID                             ?   parseInt(p.cfID)               : null;
        this.cfName              = p.cfName                           ?   p.cfName.toString()            : null;
        this.cfDesc              = p.cfDesc                           ?   p.cfDesc.toString()            : null;
        this.userPin             = p.userPin                          ?   parseInt(p.userPin)            : null;
        this.adminPin            = p.adminPin                         ?   parseInt(p.adminPin)           : null;
        this.langID              = p.langID                           ?   parseInt(p.langID)             : null;
        this.record_id           = p.record_id                        ?   parseInt(p.record_id)          : null;
        this.mohClass            = p.mohClass                         ?   parseInt(p.mohClass)           : null;
        this.maxParticipants     = p.maxParticipants                  ?   parseInt(p.maxParticipants)    : null;
        this.leaderWait          = isBoolean(p.leaderWait)            ?   Boolean(p.leaderWait)          : null;
        this.leaderLeave         = isBoolean(p.leaderLeave)           ?   Boolean(p.leaderLeave)         : null;
        this.talkerOptimization  = isBoolean(p.talkerOptimization)    ?   Boolean(p.talkerOptimization)  : null;
        this.talkerDetection     = isBoolean(p.talkerDetection)       ?   Boolean(p.talkerDetection)     : null;
        this.quiteMode           = isBoolean(p.quiteMode)             ?   Boolean(p.quiteMode)           : null;
        this.userCount           = isBoolean(p.userCount)             ?   Boolean(p.userCount)           : null;
        this.userJoinLeave       = isBoolean(p.userJoinLeave)         ?   Boolean(p.userJoinLeave)       : null;
        this.moh                 = isBoolean(p.moh)                   ?   Boolean(p.moh)                 : null;
        this.allowMenu           = isBoolean(p.allowMenu)             ?   Boolean(p.allowMenu)           : null;
        this.recordConference    = isBoolean(p.recordConference)      ?   Boolean(p.recordConference)    : null;
        this.muteOnJoin          = isBoolean(p.muteOnJoin)            ?   Boolean(p.muteOnJoin)          : null;
    }

    get(){
        super.get();
        let  p = this.p; delete this.p;
        return this;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.cfID               = p.cfID                ?   parseInt(p.cfID)            : lookUp(API.us.Sequence, 'cfID').seqValue;
        return this;
    }
}