class ccCommentListModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.dcID       = p.dcID;
        this.comID      = p.comID;
        this.comName    = p.comName;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.cccID      = p.cccID;
        this.CreatedName= p.CreatedName;
        return this;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        this.cccID      = p.cccID;
        this.CreatedName= p.CreatedName;
        return this;
    }
}