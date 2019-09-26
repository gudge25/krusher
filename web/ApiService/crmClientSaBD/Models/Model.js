class crmClientSaBDModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.clID           = p.clID;
        this.inn            = p.inn             ? p.inn             : 'null';
        this.nameFull       = p.nameFull;
        this.nameShort      = p.nameShort;
        this.adress         = p.adress;
        this.fio            = p.fio             ? p.fio             : null;
        this.io             = p.io;
        this.post           = p.post            ? p.post            : null;
        this.sex            = p.sex             ? p.sex             : null;
        this.famIO          = p.famIO;
        this.kvedCode       = p.kvedCode;
        this.kvedDescr      = p.kvedDescr;
        this.isNotice       = p.isNotice;
        this.email          = p.email           ? p.email           : null;
        this.actualStatus   = p.actualStatus    ? p.actualStatus    : null;
        this.phoneDialer    = p.phoneDialer     ? p.phoneDialer     : null;
        this.emComment      = p.emComment       ? p.emComment       : null;
        this.phoneComment   = p.phoneComment    ? p.phoneComment    : null;
    }

    get(){
        super.get();
        let p = this.p; delete this.p;
        let b = new Date(); b.setHours(b.getHours()+1);
		let a = new Date(p.callDate); let currentH = a.toString("yyyy-MM-ddTHH:mm");
        this.sex        = null; //p.sex;
        this.orgNote    = p.orgNote ? p.orgNote.split(",").map( a => { return {"id" : a }; }) : [] ;
        this.callDate   = p.callDate? currentH : b.toString("yyyy-MM-ddTHH:mm");
        this.phones     = p.phones;
        this.dbPrefix   = p.dbPrefix;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.HIID           = p.HIID;
        this.clID           = p.clID !== undefined  ? p.clID        : lookUp(API.us.Sequence, 'clID').seqValue;
        this.orgNote        = p.orgNote.join() 	? p.orgNote.join() : null;
 		this.callDate   	= p.callDate		? p.callDate.toString("yyyy-MM-ddTHH:mm") : null;
        this.phones         = []; for (var k in p.phones) {this.phones.push(new crmClientSaBDModel(p.phones[k]).phone());}
        return this;
    }

    phone( ){
        let p = this.p; delete this.p;
        let a = {};
        a.ccName     = p.ccName;
        a.ccID       = p.ccID;
        a.ccComment  = p.ccComment;
        return a;
    }
}