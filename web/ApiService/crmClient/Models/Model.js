class crmClientModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.clID           = p.clID        !== undefined   ? parseInt(p.clID)      : null ;
        this.clName         = p.clName                      ? p.clName              : null ;
        this.IsPerson       = isBoolean(p.IsPerson)         ? Boolean(p.IsPerson)   : false ;
        this.Comment        = p.Comment                     ? p.Comment             : null ;
        this.ParentID       = p.ParentID                    ? p.ParentID            : null ;
        this.CompanyID      = p.CompanyID                   ? p.CompanyID           : null ;
        this.Position       = p.Position                    ? p.Position            : null ;
        this.ffID           = p.ffID        !== undefined   ? p.ffID                : null ;
        this.ActualStatus   = p.ActualStatus                ? p.ActualStatus        : null;
        this.emID           = p.emID !== undefined          ? parseInt(p.emID)      : null ;
        this.clStatus       = parseInt(p.clStatus)          ? parseInt(p.clStatus)  : null ;
        this.ccStatus       = parseInt(p.ccStatus)          ? parseInt(p.ccStatus)  : null ;

    }

    get(){
        super.get();
        let p = this.p; delete this.p;

        this.emName     = p.emName;
        this.regName    = p.regName;
        this.col1       = p.col1;
        this.Email      = p.Email;
        this.Phone      = p.Phone;
        this.ccName     = p.Phone                      ? p.Phone          : null ;
        this.ccQty      = p.ccQty;
        this.isFixed    = p.isFixed;
        this.CallDate   = p.CallDate;
        this.GMT        = p.GMT + 3;
        this.uID        = p.uID;
        this.ffName     = p.ffName;
        //TTS
        this.curID      = p.curID;
        this.langID     = p.langID;
        this.sum        = p.sum;
        this.ttsText    = p.ttsText;
        this.ParentID   = parseInt(p.ParentID)  ? parseInt(p.ParentID)  : null ;
        this.ParentName = p.ParentName;

        this.Comment    = p.Comment;
        this.IsPerson   = p.IsPerson;
        this.tagName    = p.tagName;
        this.responsibleID  = parseInt(p.responsibleID) !== undefined    ? parseInt(p.responsibleID)      : null ;
        this.Sex            = parseInt(p.Sex)               ? parseInt(p.Sex)       : null ;
        return this;
    }

    put(){
        super.put();
        let p = this.p; delete this.p; delete this.emID; delete this.clStatus; delete this.ccStatus;
        this.responsibleID  = parseInt(p.responsibleID) !== undefined    ? parseInt(p.responsibleID)      : null ;
        this.Sex            = parseInt(p.Sex)               ? parseInt(p.Sex)       : null ;
        //delete this.ActualStatus;
        //this.clID       = p.clID !== undefined  ? p.clID        : lookUp(API.us.Sequence, 'clID').seqValue;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;  delete this.emID; delete this.clStatus;   delete this.ccStatus;
        this.responsibleID  = parseInt(p.responsibleID) !== undefined    ? parseInt(p.responsibleID)      : null ;
        this.Sex            = parseInt(p.Sex)               ? parseInt(p.Sex)       : null ;
        //delete this.ActualStatus;
        this.clID       = p.clID !== undefined  ? p.clID        : lookUp(API.us.Sequence, 'clID').seqValue;
        return this;
    }

    postFind(){
        super.postFind();
        let p = this.p; delete this.p; delete this.IsPerson; delete this.Comment; delete this.ParentID; delete this.CompanyID;  delete this.Position;  delete this.ActualStatus;
        this.CompanyIDs = p.CompanyIDs          ? p.CompanyIDs          : [] ;
        this.CallDate   = p.CallDate            ? p.CallDate            : null ;
        this.CallDateTo = p.CallDateTo          ? p.CallDateTo          : null ;
        this.tagID      = p.tagID               ? p.tagID               : null ;
        this.cID        = p.cID                 ? p.cID                 : null ;
      return this;
    }

    postDel(){
        let p = this.p;
        let m = {};
        m.clIDs          = p.clIDs      ? p.clIDs      : [] ;
        return m;
    }
}