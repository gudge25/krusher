class fmExportModel extends BaseModel {
    constructor(p) {
        super(p);
        this.p = p;
    }

    postFind(){
        //super.postFind();
        let  p = this.p; delete this.p; delete this.isActive;
        this.DateFrom       = p.DateFrom                ? new Date(p.DateFrom).toString("yyyy-MM-ddTHH:mm:ss")      : null; 
        this.DateTo         = p.DateTo                  ? new Date(p.DateTo).toString("yyyy-MM-ddTHH:mm:ss")        : null;
        this.ffID           = p.ffID !== undefined      ? parseInt(p.ffID)                                          : null ;
        this.tpID           = p.tpID !== undefined      ? parseInt(p.tpID)                                          : null ;
        return this;
    }
}