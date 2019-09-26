class fmQuestionItemsReportModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.qID            = p.qID                 ? p.qID             : null;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.qiAnswer       = p.qiAnswer;
        this.Percent        = p.Percent;
        this.QtyAvg         = p.QtyAvg;
        this.tpHint         = p.tpHint;
        this.Period         = p.Period;
        return this;
    }

    postFind(){
        let p = this.p; delete this.p;
         //one day ago
        let a = new Date().setDate(new Date().getDate()-1);
        this.Step           = p.Step !== undefined          ? p.Step                    : 4;
        this.DateFrom       = p.DateFrom                    ? p.DateFrom                : new Date(a).toString("yyyy-MM-dd");
        this.DateTo         = p.DateTo                      ? p.DateTo                  : new Date().toString("yyyy-MM-dd");
        this.isStepPercent  = isBoolean(p.isStepPercent)    ? Boolean(p.isStepPercent)  : false;
        return this;
    }
}