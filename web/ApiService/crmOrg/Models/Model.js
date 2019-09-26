class orgModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.clID           = parseInt(p.clID) !== undefined    ? parseInt(p.clID)      : null ;
        this.Account    = p.Account     ? p.Account     : null ;
        this.Bank       = p.Bank        ? p.Bank        : null ;
        this.SortCode   = p.SortCode    ? p.SortCode    : null ;
        this.RegCode    = p.RegCode     ? p.RegCode     : null ;
        this.CertNumber = p.CertNumber  ? p.CertNumber  : null ;
        this.OrgType    = p.OrgType     ? p.OrgType     : null ;
        this.KVED       = p.KVED        ? p.KVED        : null ;
        this.KVEDName   = p.KVEDName    ? p.KVEDName    : null ;
        this.ShortName  = p.ShortName   ? p.ShortName   : null ;
        this.headPost   = p.headPost    ? p.headPost    : null ;
        this.headFIO    = p.headFIO     ? p.headFIO     : null ;
        this.headFam    = p.headFam     ? p.headFam     : null ;
        this.headIO     = p.headIO      ? p.headIO      : null ;
        this.headSex    = p.headSex     ? p.headSex     : null ;
        this.TaxCode    = p.TaxCode     ? p.TaxCode.toString()     : null ;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.AccountName= p.AccountName ? p.AccountName : null;
        this.orgNote    = p.orgNote ? p.orgNote.split(",").map( a => { return {"id" : a }; }) : [] ;
        return this;
    }

    put(){
        super.put();
        delete this.p;
        this.orgNote    = null;//p.orgNote     ? p.orgNote.join()     : null ;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.orgNote    = p.orgNote     ? p.orgNote.join()     : null ;
        return this;
    }
}