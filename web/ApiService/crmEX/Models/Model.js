class crmClientExModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.clID           = p.clID   !== undefined    ? p.clID                : null ;
        this.CallDate       = p.CallDate                ? p.CallDate            : null ;
        this.isNotice       = isBoolean(p.isNotice)     ? Boolean(p.isNotice)   : null ;
        this.isRobocall     = isBoolean(p.isRobocall)   ? Boolean(p.isRobocall) : null ;
        this.isCallback     = isBoolean(p.isActive)     ? Boolean(p.isActive)   : null ;
        this.isDial         = isBoolean(p.isDial)       ? Boolean(p.isDial)     : null ;
        this.curID          = p.curID                   ? p.curID               : null ;
        this.langID         = p.langID                  ? p.langID              : null;
        this.sum            = p.sum                     ? p.sum                 : null ;
        this.ttsText        = p.ttsText                 ? p.ttsText             : null;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        this.isNotice       = isBoolean(p.isNotice)     ? Boolean(p.isNotice)   : false ;
        this.isRobocall     = isBoolean(p.isRobocall)   ? Boolean(p.isRobocall) : false ;
        this.isCallback     = isBoolean(p.isActive)     ? Boolean(p.isActive)   : false ;
        this.isDial         = isBoolean(p.isDial)       ? Boolean(p.isDial)     : false ;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.isNotice       = isBoolean(p.isNotice)     ? Boolean(p.isNotice)   : false ;
        this.isRobocall     = isBoolean(p.isRobocall)   ? Boolean(p.isRobocall) : false ;
        this.isCallback     = isBoolean(p.isActive)     ? Boolean(p.isActive)   : false ;
        this.isDial         = isBoolean(p.isDial)       ? Boolean(p.isDial)     : false ;
        return this;
    }
}