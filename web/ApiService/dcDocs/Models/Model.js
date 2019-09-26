class dcDocsClientModel extends BaseModelDC {
    constructor(p) {
        super(p);
        this.p = p;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.dcType         = p.dcType          ? p.dcType              :null;
        this.dcStatusName   = p.dcStatusName    ? p.dcStatusName        :null;
        this.dcID           = p.dcID            ? p.dcID                :null;
        this.dcNo           = p.dcNo            ? p.dcNo                :null;
        this.emID           = p.emID            ? p.emID                :null;
        this.clName         = p.clName          ? p.clName              :null;
        this.dcComment      = p.dcComment       ? p.dcComment           :null;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.dctID          = p.dctID           ? p.dctID               :null;
        this.dcNo           = p.dcNo            ? p.dcNo                :null;
        this.dateFrom       = p.dateFrom        ? p.dateFrom            :null;
        this.dateTo         = p.dateTo          ? p.dateTo              :null;
        this.emID           = p.emID            ? p.emID                :null;
        this.clName         = p.clName          ? p.clName              :null;
        this.dcComment      = p.dcComment       ? p.dcComment           :null;
        return this;
    }

}