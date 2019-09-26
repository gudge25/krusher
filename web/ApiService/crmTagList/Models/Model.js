class crmTagListModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.clID           = p.clID !== undefined ? parseInt(p.clID) : null;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.ctgID          = p.ctgID;
        this.tagID          = p.tagID;
        this.tagName        = p.tagName;
        return this;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        this.ctgID          = p.ctgID;
        this.tagID          = p.tagID;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.tags           = p.tags;
        return this;
    }
}