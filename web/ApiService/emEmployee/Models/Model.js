class emEmployeeModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.emID           = parseInt(p.emID);
        this.emName         = p.emName                  ? p.emName                  : null;
        this.LoginName      = p.LoginName               ? p.LoginName               : null;
        this.ManageID       = p.ManageID                ? p.ManageID                : null;
        this.roleID         = p.roleID                  ? p.roleID                  : null;
        this.sipName        = p.sipName                 ? p.sipName.toString()      : null;
        this.sipID          = p.sipID                   ? p.sipID                   : null;
        this.Queue          = (p.Queue && p.Queue.indexOf('-')  === -1) ? p.Queue   : null;
        this.onlineStatus   = p.onlineStatus            ? parseInt(p.onlineStatus)  : null;
        this.CompanyID      = p.CompanyID               ? parseInt(p.CompanyID)     : null;
        this.coIDs          = p.coIDs                   ? p.coIDs                   : null;
        this.pauseDelay     = p.pauseDelay              ? parseInt(p.pauseDelay)    : null;
     } 

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.roleName   = p.roleName;
        this.sipData    = this.sipID    = p.sipID       ? p.sipID                                       : null ;
        this.coIDs      = p.coIDs                       ? p.coIDs.split(",").map( a => { return { "coID" : parseInt(a) }; } )    : [];

        if(this.LoginName != `superadmin`) return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.emID       = p.emID                    ? parseInt(p.emID)                      : lookUp(API.us.Sequence, 'emID').seqValue;
        this.roleID     = p.roleID                  ? p.roleID                              : 3;
        this.Password   = p.Password                ? p.Password                            : null;
        this.coIDs      = p.coIDs                   ? p.coIDs.map( x =>  parseInt(x.coID) ) : [] ;
        return this;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        this.emID       = p.emID                    ? parseInt(p.emID)                      : null;
        this.roleID     = p.roleID                  ? p.roleID                              : 3;
        this.Password   = p.Password                ? p.Password                            : null;
        this.coIDs      = p.coIDs                   ? p.coIDs.map( x =>  parseInt(x.coID) ) : [] ;
        return this;
    }

    postFind(){
        super.postFind();
        let p = this.p; delete this.p;
        this.coIDs      = p.coIDs                   ? p.coIDs.map( x =>  parseInt(x.coID) ) : [] ;
        return this;
    }


    postFindNotMap(){
        let p = this.p;  delete this.p;  
        this.coIDs      = p.coIDs                   ? p.coIDs                               : [] ;
        return this;
    }
}