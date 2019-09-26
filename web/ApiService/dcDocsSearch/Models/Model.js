class dcDocsSearchModel extends BaseModelDC {
  constructor(p) {
    p = p ? p : {};
    super(p);
    this.p = p;
    this.dctID              = p.dctID !== undefined   ? parseInt(p.dctID)       : 4;
    this.dcNo               = p.dcNo                  ? p.dcNo.toString()       : null;
    this.emID               = p.emID  !== undefined   ? parseInt(p.emID)        : null;
    this.clName             = p.clName                ? p.clName.toString()     : null;
    this.dcComment          = p.dcComment             ? p.dcComment.toString()  : null;
    //console.log(p);  
 
  }

  get(){
    super.get();
    let p = this.p; delete this.p;
    this.CreatedName        = p.CreatedName;
    this.EditedName         = p.EditedName;
    this.clID               = p.clID;
    this.dcID               = p.dcID;
    this.dcLink             = p.dcLink;
    this.dcStatus           = p.dcStatus;
    this.dcStatusName       = p.dcStatusName;
    this.dcSum              = p.dcSum;
    this.emName             = p.emName;
    this.dctID              = p.dctID;
    this.dctName            = p.dctName;
    this.dcType             = p.dcType;
    this.dcDate             = p.dcDate                ? p.dcDate.toString()  : null;

    return this;
  }

  put(){
    super.put();
    let p = this.p; delete this.p; 
    this.dateFrom           = p.dateFrom              ? p.dateFrom    : null;
    return this;
  }

  post(){
    super.post();
    let p = this.p; delete this.p; 
    this.dateFrom           = p.dateFrom              ? p.dateFrom    : null;
    //this.dateTo             = p.dcDate                ? p.dateTo      : null;
    return this;
  }


  postFind(){
      super.postFind();
      let p = this.p; delete this.p; delete this.dcDate; 
      this.dcID = null; 
      this.dateFrom           = p.dateFrom              ? p.dateFrom.toString()  : null;
      //this.dateTo             = p.dcDate                ? p.dateTo.toString()  : null;
      return this;
  }
}