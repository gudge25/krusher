class fmQuestionReportModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        console.log(p.tpID);
        this.tpID       = p.tpID                ? parseInt(p.tpID)        : null;
        console.log(this.tpID);
    }

    get(){
        super.get();
        let p = this.p;
        delete this.p;
        this.qID            = p.qID;
        this.qName          = p.qName;
        this.QtyAnswer      = p.QtyAnswer;
        this.QtyAvg         = p.QtyAvg;
        this.Period         = p.Period;
        return this;
    }

    postFind() {
        let p = this.p;
        delete this.p; delete this.isActive;
        //one day ago
        let a = new Date().setDate(new Date().getDate()-1);
        this.Step           = p.Step !== undefined  ? p.Step        : 4;
        this.DateFrom       = p.DateFrom            ? new Date(p.DateFrom).toString("yyyy-MM-ddTHH:mm:ss")      : new Date(a).toString("yyyy-MM-ddT00:00:00"); //null; //new Date(a).toString("yyyy-MM-ddT00:00:00");
        this.DateTo         = p.DateTo              ? new Date(p.DateTo).toString("yyyy-MM-ddTHH:mm:ss")        : new Date().toString("yyyy-MM-ddT23:59:59"); //null; // new Date().toString("yyyy-MM-ddT23:59:59");
        return this;
    }
}