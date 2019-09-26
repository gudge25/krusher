class crmClientStreamModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
    }

    get() {
        super.get();
        let p = this.p; delete this.p;
        this.uID            = p.uID         ;
        this.dup_action     = p.dup_action  ;
        this.clID           = p.clID        ;
        this.clName         = p.clName      ;
        this.isPerson       = p.isPerson    ;
        this.Comment        = p.Comment     ;
        this.ffID           = p.ffID        ;
        this.ParentID       = p.ParentID    ;
        this.OLD_clName     = p.OLD_clName  ;
        this.OLD_isPerson   = p.OLD_isPerson;
        this.OLD_isActive   = p.OLD_isActive;
        this.OLD_Comment    = p.OLD_Comment ;
        this.OLD_ffID       = p.OLD_ffID    ;
        this.OLD_ParentID   = p.OLD_ParentID;
        return this;
    }
}