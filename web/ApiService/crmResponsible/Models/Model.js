class crmResponsibleModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.crID       = p.crID;
        this.emID       = p.emID;
        this.emName     = p.emName;
        this.clID           = parseInt(p.clID) !== undefined    ? parseInt(p.clID)      : null ;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.crID       = p.crID    ? p.crID    : lookUp(API.us.Sequence, 'crID').seqValue;
        this.emName     = lookUp(API.em.Employee.All, p.emID).emName;
        return this;
    }
}