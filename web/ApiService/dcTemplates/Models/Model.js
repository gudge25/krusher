class dcTemplatesModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.dtID          = p.dtID                 ? parseInt(p.dtID)          : null;
        this.dtName        = p.dtName               ? p.dtName.toString()       : null;
        this.dcTypeID      = p.dctID                ? parseInt(p.dctID)         : null;
        this.dtTemplate    = p.dtTemplate           ? p.dtTemplate.toString()   : null;
        this.isDefault     = isBoolean(p.isDefault) ? Boolean(p.isDefault)      : null;
     }

    get(){
        super.get();
        let p = this.p; delete this.p;
        this.dcTypeName    = p.dcTypeName;
        this.dcTypeID      = p.dcTypeID             ? parseInt(p.dcTypeID)      : null;
        return this;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        this.isDefault     = isBoolean(p.isDefault) ? Boolean(p.isDefault)      : false;
        this.dcTypeID      = p.dcTypeID             ? parseInt(p.dcTypeID)      : null;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.dtID          = p.dtID                 ? p.dtID                    : lookUp(API.us.Sequence, 'dtID').seqValue;
        this.isDefault     = isBoolean(p.isDefault) ? Boolean(p.isDefault)      : false;
        this.dcTypeID      = p.dcTypeID             ? parseInt(p.dcTypeID)      : null;
        return this;
    }

    postFind(){
        super.postFind();
        let p = this.p; delete this.p; 
        return this;
    }

}