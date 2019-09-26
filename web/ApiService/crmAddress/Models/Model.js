class crmAddressModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.adsID      = p.adsID       ? parseInt(p.adsID)     : null ;
        this.clID       = p.clID        ? parseInt(p.clID)      : null ;
        this.adsName    = p.adsName     ? p.adsName.toString()  : null ;
        this.adtID      = p.adtID       ? parseInt(p.adtID)     : null ;
        this.Postcode   = p.Postcode    ? p.Postcode.toString() : null ;
        this.pntID      = p.pntID       ? parseInt(p.pntID)     : null ;
        this.Region     = p.Region      ? p.Region              : null ;
        this.RegionDesc = p.RegionDesc  ? p.RegionDesc          : null ;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.adsID      = p.adsID       ? parseInt(p.adsID)      : lookUp(API.us.Sequence, 'adsID').seqValue;
        return this;
    }
}