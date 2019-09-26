class crmClientSearch2Model extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.clName        = p.clName ;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.Comment                 = p.Comment;
        this.Contacts                = p.Contacts;
        this.IsPerson                = p.IsPerson;
        this.Responsibles            = p.Responsibles;
        this.clID                    = p.clID;
        this.clName                  = p.clName;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.emID        = p.emID  ;
        this.ccName      = p.ccName ;
        this.ccType     = p.ccType ;
        return this;
    }
}