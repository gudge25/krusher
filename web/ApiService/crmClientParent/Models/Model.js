class crmClientParentModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.clID           = p.clID;
        this.clName         = p.clName;
        this.IsPerson       = p.IsPerson;
        this.IsActive       = p.IsActive;
        this.Comment        = p.Comment;
        this.Contacts       = p.Contacts;
        this.Addresses      = p.Addresses;
        this.Responsibles   = p.Responsibles;
        this.Position       = p.Position;
    }
}