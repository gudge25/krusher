//BaseModel for Documents DC
class BaseModelDC extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.dcComment      = p.dcComment                   ? p.dcComment.toString()   : null ;
        this.dcSum          = p.dcSum                       ? parseInt(p.dcSum)       : null ;
        this.dcStatus       = p.dcStatus                    ? parseInt(p.dcStatus)    : null ;
        this.clID           = parseInt(p.clID) !== undefined? parseInt(p.clID)      : null ;
        this.emID           = p.emID !== undefined          ? parseInt(p.emID)        : null ;
        this.dcNo           = p.dcNo                        ? p.dcNo.toString()        : null ;
        this.dcID           = parseInt(p.dcID) !== undefined ? parseInt(p.dcID)        : null ;
    }

    get(){
        super.get();
        let p = this.p;
        p = this.p ? this.p : {};
        this.dcType         = p.dcType                      ? p.dcType                                      : null ;
        this.dcStatusName   = p.dcStatusName                ? p.dcStatusName.toString()                     : null ;
        this.clName         = p.clName                      ? p.clName.toString()                           : null ;
        this.emName         = p.emName                      ? p.emName.toString()                           : null ;
        this.tpName         = p.tpName                      ? p.tpName.toString()                           : null ;
        this.dcLinkDate     = p.dcLinkDate                  ? p.dcLinkDate                                  : null ;

        this.dcLinkType     = p.dcLinkType                  ? p.dcLinkType                                  : null ;
        this.dcLinkNo       = p.dcLinkNo                    ? p.dcLinkNo                                    : null ;
        this.uID            = p.uID                         ? p.uID.toString()                              : null ;
        this.dctID          = p.dctID                       ? p.dctID                                       : null ;
        this.dctName        = p.dctName                     ? p.dctName.toString()                          : null ;
        this.dcDate         = p.dcDate                      ? new Date(p.dcDate).toString("yyyy-MM-dd")     : null;
        this.dcSum          = p.dcSum                       ? p.dcSum                                       : 0 ;
        this.dctType        = p.dctType                     ? parseInt(p.dctType)                           : null ;
        this.dcLink         = p.dcLink                      ? parseInt(p.dcLink)      : null ;
        this.dcDate         = p.dcDate                      ? p.dcDate.toString()      : null ; //new Date().toString("yyyy-MM-dd");


        return this;
    }
    put(){
        super.put();
        let p = this.p;
        this.dcDate         = p.dcDate                      ? new Date(p.dcDate).toString("yyyy-MM-dd")            : new Date().toString("yyyy-MM-dd");
        return this;
    }

    post(){
        super.post();
        let p   = this.p;
        this.HIID           = p.HIID;
        this.dcID           = p.dcID        ? parseInt(p.dcID)                              : lookUp(API.us.Sequence, 'dcID').seqValue;
        this.dcDate         = p.dcDate      ? new Date(p.dcDate).toString("yyyy-MM-dd")     : new Date().toString("yyyy-MM-dd");
        return this;
    }
}