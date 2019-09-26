class hEmModel extends BaseModelHystory {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.emID           = p.emID                    ? parseInt(p.emID)              : null;
        this.emName         = p.emName                  ? p.emName.toString()           : null;
        this.LoginName      = p.LoginName               ? p.LoginName.toString()        : null;
        this.ManageID       = p.ManageID                ? parseInt(p.ManageID)          : null;
        this.roleID         = p.roleID                  ? parseInt(p.roleID)            : null;
        this.sipID          = p.sipID                   ? parseInt(p.sipID)             : null;
        this.sipName        = p.sipName                 ? p.sipName.toString()          : null;
        this.Queue          = p.Queue                   ? p.Queue.toString()            : null;
        this.CompanyID      = p.CompanyID               ? parseInt(p.CompanyID)         : null;
        this.onlineStatus   = p.onlineStatus            ? parseInt(p.onlineStatus)      : null;
    }

      get(){
        super.get();
        let p = this.p; delete this.p;
        return p;
    }
}