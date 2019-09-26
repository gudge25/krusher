class usRankModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.uID        = p.uID     ? p.uID                 : null;
        this.uRank      = p.uRank   ? p.uRank.toString()    : null;
        this.type       = p.type    ? parseInt(p.type)      : 103001; //start
    }


    get(){
        super.get();
        let p = this.p; delete this.p;
        this.uRank      = p.uRank   ? parseInt(p.uRank)    : null;
        return this;
    }


    put(){
        super.put();
        let p = this.p; delete this.p; //delete this.HIID;
        this.uRank      = p.uRank   ? p.uRank.toString()    : "0";
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.uRank      = p.uRank   ? p.uRank.toString()    : "0";
        return this;
    }
}