class astAutoProcessModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.id_autodial        = p.id_autodial         ?   parseInt(p.id_autodial)             : null;
        this.process            = p.process             ?   parseInt(p.process)                 : null;
        this.ffID               = p.ffID                ?   parseInt(p.ffID)                    : null;
        this.id_scenario        = p.id_scenario         ?   parseInt(p.id_scenario)             : null;
        this.emID               = p.emID                ?   parseInt(p.emID)                    : null;
        this.factor             = p.factor              ?   parseInt(p.factor)                  : null;
        this.called             = p.called              ?   parseInt(p.called)                  : null;
        this.targetCalls        = p.targetCalls         ?   parseInt(p.targetCalls)             : null;
        this.errorDescription   = p.errorDescription    ?   p.errorDescription.toString()       : null;
        this.description        = p.description         ?   p.description.toString()            : null;
        this.planDateBegin      = p.planDateBegin       ?   p.planDateBegin.toString()          : null;
    }

    get(){
        super.get();
        let  p = this.p; delete this.p;
        this.planDateBegin      = p.planDateBegin       ?   new Date(p.planDateBegin ).toString("yyyy-MM-dd HH:mm:ss")            : null;
        this.errorDescription   = p.errorDescription    ?   p.errorDescription.substring(p.errorDescription.lastIndexOf(":") + 1, p.errorDescription.length).trim() : null;
        return this;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        this.planDateBegin      = p.planDateBegin       ?   p.planDateBegin.toString()            : new Date().toString("yyyy-MM-ddTHH:mm:ss");
        this.factor             = p.factor              ?   parseInt(p.factor)                    : 1;
        this.process            = p.process             ?   parseInt(p.process)                   : null;
        this.errorDescription   = `User edit` ;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.id_autodial        = p.id_autodial         ?   parseInt(p.id_autodial)         : lookUp(API.us.Sequence, 'id_autodial').seqValue;
        this.emID               = p.emID                ?   parseInt(p.emID)                : EMID;
        this.planDateBegin      = p.planDateBegin       ?   p.planDateBegin.toString()      : new Date().toString("yyyy-MM-ddTHH:mm:ss") ;
        this.factor             = p.factor              ?   parseInt(p.factor)              : 1;
        this.process            = p.process             ?   parseInt(p.process)             : 101602;
        this.errorDescription   = null;
        return this;
    }
}