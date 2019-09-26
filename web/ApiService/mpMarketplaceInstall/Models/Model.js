class mpMarketplaceInstallModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.mpID               = p.mpID                    ? parseInt(p.mpID)                  : null ;
        this.mpiID              = p.mpiID                   ? parseInt(p.mpiID)                 : null ;
        this.login              = p.login                   ? p.login.toString()                : null ;
        this.pass               = p.pass                    ? p.pass.toString()                 : null ;
        this.tokenAccess        = p.tokenAccess             ? p.tokenAccess.toString()          : null ;
        this.link               = p.link                    ? p.link.toString()                 : null ;       
        this.data1              = p.data1                   ? p.data1.toString()                : null ; 
        this.data2              = p.data2                   ? p.data2.toString()                : null ;  
        this.data3              = p.data3                   ? p.data3.toString()                : null ;  
    }
    
    get(){
        super.get();
        let p = this.p; delete this.p;
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
        this.mpiID          = p.mpiID       ? p.mpiID               : lookUp(API.us.Sequence, 'mpiID').seqValue;
        return this;
    }

    postFind(){
        super.postFind();
        let p = this.p; delete this.p;
        return this;
    }
}