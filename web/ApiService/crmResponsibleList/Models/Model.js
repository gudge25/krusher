class crmResponsibleListModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.emID       = p.emID    ? p.emID    : null ;
        this.clIDs      = p.clID    ? p.clID    : null ;
    }

    post(){
        super.post();
        delete this.p; delete this.isActive;
        return this;
    }
}