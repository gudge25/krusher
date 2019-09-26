class dcDocsHistoryModel extends BaseModel {
    constructor(p) {
        super(p);
        this.p = p;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.dcID                        = p.dcID;
        this.dcNo                        = p.dcNo;
        this.dcState                     = p.dcState;
        this.dcDate                      = p.dcDate;
        this.dcLink                      = p.dcLink;
        this.dcComment                   = p.dcComment;
        this.dcSum                       = p.dcSum;
        this.dcStatus                    = p.dcStatus;
        this.crID                        = p.crID;
        this.dcRate                      = p.dcRate;
        this.clID                        = p.clID;
        this.clName                      = p.clName;
        this.emID                        = p.emID;
        this.pcID                        = p.pcID;
        this.uID                         = p.uID;
        this.dup_InsTime                 = p.dup_InsTime;
        this.dup_action                  = p.dup_action;
        this.dup_UserName                = p.dup_UserName;
        this.dup_HostName                = p.dup_HostName;
        this.dup_AppName                 = p.dup_AppName;
        return this;
    }
}