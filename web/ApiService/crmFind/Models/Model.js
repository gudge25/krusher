class crmClientFindModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.clName         = p.clName                          ? p.clName              : null ;
        this.emID           = p.emID !== undefined              ? p.emID                : null ;
        this.ccStatus       = parseInt(p.ccStatus)              ? parseInt(p.ccStatus)  : null ;
        this.ffID           = p.ffID !== undefined              ? p.ffID                : null ;
        this.CallDate       = p.CallDate                        ? p.CallDate            : null ;
        this.CallDateTo     = p.CallDateTo                      ? p.CallDateTo          : null ;
        this.clStatus       = parseInt(p.clStatus)              ? parseInt(p.clStatus)  : null ;
        this.clID           = parseInt(p.clID) !== undefined    ? parseInt(p.clID)      : null ;
        //this.responsibleID  = parseInt(p.responsibleID) !== undefined    ? parseInt(p.responsibleID)      : null ;
        //this.ActualStatus   = p.ActualStatus                    ? p.ActualStatus        : null;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.IsPerson       = p.IsPerson;
        this.IsActive       = p.IsActive;
        this.Comment        = p.Comment;
        this.emName         = p.emName;
        this.tagName        = p.tagName;
        this.col1           = p.col1;
        this.isFixed        = p.isFixed;
        this.Phone          = p.Phone;
        this.ccName         = p.Phone                      ? p.Phone          : null ;

        this.Email          = p.Email;
        this.regName        = p.regName;
        this.rpID           = p.rpID;
        this.GMT            = p.GMT;
        this.ccQty          = p.ccQty;
        this.uID            = p.uID;
        //TTS
        this.curID          = p.curID;
        this.langID         = p.langID;
        this.sum            = p.sum;
        this.ttsText        = p.ttsText;
        this.ParentID       = parseInt(p.ParentID)          ? parseInt(p.ParentID)  : null ;
        this.ParentName     = p.ParentName;
        this.Position       = p.Position                    ? p.Position            : null ;
        this.ActualStatus   = p.ActualStatus                ? p.ActualStatus        : null;
        this.CompanyID      = p.CompanyID                   ? p.CompanyID           : null ;
        this.responsibleID  = p.emID !== undefined          ? p.emID                : null ;
        this.Sex            = p.Sex                         ? p.Sex                 : null ;
        this.isDial         = isBoolean(p.isDial)           ? Boolean(p.isDial)  : null ;

        return this;
    }

    postFind(){
        super.postFind();
        let p = this.p; delete this.p;
        this.CompanyIDs = p.CompanyIDs          ? p.CompanyIDs          : [] ;
        // this.ccName     = p.ccName  ? p.ccName  : null ;
        // this.ccType     = p.ccType  ? p.ccType  : null ;
        // this.regID      = p.regID   ? p.regID   : null ;
        this.tagID      = p.tagID   ? p.tagID   : null ;
        this.cID       = p.cID    ? p.cID    : null ;
      return this;
    }
}