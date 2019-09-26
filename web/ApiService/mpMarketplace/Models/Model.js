class mpMarketplaceModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.mpID               = p.mpID                    ? parseInt(p.mpID)              : null ;
        this.mpName             = p.mpName                  ? p.mpName.toString()           : null ;
        this.mpDescription      = p.mpDescription           ? p.mpDescription.toString()    : null ;
        this.mpLinkProvider     = p.mpLinkProvider          ? p.mpLinkProvider.toString()   : null ;
        this.mpCategory         = p.mpCategory              ? parseInt(p.mpCategory)        : null ;
        this.mpLogo             = p.mpLogo                  ? p.mpLogo.toString()           : null ;
        this.mpPrice            = p.mpPrice                 ? parseInt(p.mpPrice)           : null ;
        this.order              = p.order                   ? parseInt(p.order)             : null ;
     }
    
    get(){
        super.get();
        let p = this.p; delete this.p;
        this.countInstalls              = p.countInstalls                   ? parseInt(p.countInstalls)             : null ;
        return this;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        return this;
    }

    post(){
        super.put();
        let p = this.p; delete this.p;
        this.mpID          = p.mpID       ? p.mpID               : lookUp(API.us.Sequence, 'mpID').seqValue;
        return this;
    }

    postFind(){
        super.postFind();
        let p = this.p; delete this.p;
        return this;
    }
}