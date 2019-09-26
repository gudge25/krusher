class PrivateModel extends BaseModel {
    constructor(p) {
        super(p);
        this.p = p;
    }

    get(){
        super.get();
        var p = this.p; delete this.p;
        this.emID           = p.emID            ? parseInt(p.emID)          : null ;
        this.emName         = p.emName          ? p.emName.toString()       : null ;
        this.LoginName      = p.LoginName       ? p.LoginName.toString()    : null ;
        this.ManageID       = p.ManageID        ? parseInt(p.ManageID)      : null ;
        this.roleID         = p.roleID          ? parseInt(p.roleID)        : null ;
        this.roleName       = p.roleName        ? p.roleName.toString()     : null ;
        this.Permission     = p.Permission      ? parseInt(p.Permission)    : null ;
        this.sipID          = p.sipID           ? parseInt(p.sipID)         : null ;
        this.sipName        = p.sipName         ? p.sipName.toString()      : null ;
        this.Queue          = p.Queue           ? p.Queue.toString()        : null ;
        this.url            = p.url             ? p.url.toString()          : null ;
        this.phone          = p.phone           ? p.phone.toString()        : null ;
        this.email_info     = p.email_info      ? p.email_info.toString()   : null ;
        this.hosting_type   = p.hosting_type    ? parseInt(p.hosting_type)  : null ;
        this.id_currency    = p.id_currency     ? parseInt(p.id_currency)   : null ;
        this.date_fee       = p.date_fee        ? parseInt(p.date_fee)      : null ;
        this.balance_amount = p.balance_amount  ? p.balance_amount          : null ;
        this.count_of_calls = p.count_of_calls  ? parseInt(p.count_of_calls): null ;
        this.logo_url       = p.logo_url        ? p.logo_url.toString()     : null ;
        this.client_name    = p.client_name     ? p.client_name.toString()  : null ;
        this.vTigerID       = p.vTigerID        ? parseInt(p.vTigerID)      : null ;
        this.fop2_secret    = p.fop2_secret     ? p.fop2_secret.toString()  : null ;
        this.client_contact = p.client_contact  ? p.client_contact.toString()   : null ;
        this.onlineStatus   = p.onlineStatus    ? parseInt(p.onlineStatus)  : null;
        this.coIDs          = p.coIDs           ? p.coIDs.split(",").map( a => { return { "coID" : parseInt(a) }; } )    : [];

        return this;
    }
}