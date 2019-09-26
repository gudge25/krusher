class hClientModel extends BaseModelHystory {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.clID           = parseInt(p.clID) !== undefined    ? parseInt(p.clID)      : null ;
        this.clName         = p.clName                          ? p.clName.toString()   : null ;
        this.ffID           = parseInt(p.ffID) !== undefined	? parseInt(p.ffID)      : null ;
        //var a = new BaseModelCl(p).extend();
        //console.log(a);
        this.IsPerson       = isBoolean(p.IsPerson)     ? Boolean(p.IsPerson)           : null;
        this.Sex            = parseInt(p.Sex)           ? parseInt(p.Sex)               : null;
        this.ParentID       = parseInt(p.ParentID)      ? parseInt(p.ParentID)          : null;
        this.CompanyID      = parseInt(p.CompanyID)     ? parseInt(p.CompanyID)         : null;
        this.uID            = p.uID                     ? p.uID                         : null;
        this.isActual       = isBoolean(p.isActual)     ? Boolean(p.isActual)           : null;
        this.ActualStatus   = parseInt(p.ActualStatus)  ? parseInt(p.ActualStatus)      : null;
        this.Position       = parseInt(p.Position)      ? parseInt(p.Position)          : null;
        this.responsibleID  = parseInt(p.responsibleID) ? parseInt(p.responsibleID)     : null;
    }

      get(){
        super.get();
        let p = this.p; delete this.p;
        return p;
    }
}