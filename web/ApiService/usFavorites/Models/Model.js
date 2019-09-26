class FavoritesModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.uID            = p.uID         ? p.uID.toString()  : null;
        this.faComment      = p.faComment   ? p.faComment       : null;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.faID           = p.faID;
        this.faModel        = p.faModel;
        this.faInfo         = p.faInfo;
        return this;
    }
}