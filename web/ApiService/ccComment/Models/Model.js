class ccCommentModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.cccID      = p.cccID   ? p.cccID   : null ;
        this.dcID       = p.dcID    ? p.dcID    : null ;
        this.comID      = p.comID   ? p.comID   : null ;
        this.comName    = p.comName ? p.comName : null ;
    }
}