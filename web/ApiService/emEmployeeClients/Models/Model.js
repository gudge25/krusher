class emEmployeeClientsModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
          this.LoginName    = p.LoginName               ? p.LoginName           : null;
          this.Pass         = p.Pass                    ? p.Pass                : null;
          this.Domain       = p.Domain                  ? p.Domain              : null;
          this.IP           = p.IP                      ? p.IP                  : `0.0.0.0`;
          this.Port         = p.Port                    ? p.Port                : `3000`;
          this.Phone        = p.Phone                   ? p.Phone               : undefined;
          this.mPhone       = p.mPhone                  ? p.mPhone              : null;
          this.Email        = p.Email                   ? p.Email               : null;
          this.EmailTech    = p.EmailTech               ? p.EmailTech           : null;
          this.EmailFinance = p.EmailFinance            ? p.EmailFinance        : null;
          this.htID         = p.htID                    ? p.htID                : 101705;
          this.aName        = p.aName                   ? p.aName               : null;
          this.curID        = p.curID                   ? p.curID               : 101801;
          this.exDomain     = p.exDomain                ? p.exDomain        : null;
     }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.Domain       = p.Domain                  ? `${p.Domain}${p.exDomain}` : null;
        delete this.exDomain;
        return this;
    }
}