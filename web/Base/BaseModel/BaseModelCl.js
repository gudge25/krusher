//BaseModel for Client
class BaseModelCl extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
		this.clID           = parseInt(p.clID) !== undefined    ? parseInt(p.clID)      : null ;
        this.clName         = p.clName                          ? p.clName.toString()   : null ;
        this.ffID           = parseInt(p.ffID) !== undefined	? parseInt(p.ffID)      : null ;
    }

    extend(){
        return this;
    }
}