class smsSingleModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        console.log(this);

        this.dcID               = p.dcID                ?   parseInt(p.dcID)                    : null;
        this.ccID               = p.ccID                ?   parseInt(p.ccID)                    : null;
        this.ffID               = p.ffID                ?   parseInt(p.ffID)                    : null;
        this.clID               = p.clID                ?   parseInt(p.clID)                    : null;
        this.originator         = p.originator          ?   p.originator.toString()             : null;
        this.ccName             = p.ccName              ?   p.ccName.toString()                 : null;
        this.text_sms           = p.text_sms            ?   p.text_sms.toString()               : null;
    }   
 
    post(){
        super.post();
        let p = this.p; delete this.p;
        this.dcID               = p.dcID                ? p.dcID             : lookUp(API.us.Sequence, 'dcID').seqValue;
        return this;
    }
}