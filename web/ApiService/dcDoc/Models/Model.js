class dcDocClientModel extends BaseModelDC {
    constructor(p) {
        super(p);
        this.p = p;
    }

    postFind(){
        super.postFind();
        let p = this.p; delete this.p;
        //delete this.limit;
        delete this.dcLink; //delete this.dcDate;
        return this;
    }
}