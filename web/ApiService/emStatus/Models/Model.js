class emStatusModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.emID           = p.emID                    ? parseInt(p.emID)          : null;
        this.onlineStatus   = p.onlineStatus            ? parseInt(p.onlineStatus)  : null;    
    } 
 
    put(){
        let p = this.p; delete this.p;  delete this.isActive;
        this.emID           = p.emID                    ? parseInt(p.emID)          : null;
        this.onlineStatus   = p.onlineStatus            ? parseInt(p.onlineStatus)  : 103507; 
        return this;
    }    
}