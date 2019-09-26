class astTTSFieldsModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.ttsfID         = p.ttsfID !== undefined    ?   p.ttsfID        : null;
        this.fields         = p.fields                  ?   p.fields        : null;
        this.fieldName      = p.fieldName               ?   p.fieldName     : null;
        this.langID         = p.langID                  ?   p.langID        : null;

    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.ttsfID          = p.ttsfID           ? p.ttsfID                   : lookUp(API.us.Sequence, 'ttsfID').seqValue;
        this.settings       = p.settings        ? p.settings                : {};
        this.ttsText        = p.ttsText         ? p.ttsText                 : null;
        return this;
    }

    postFind(){
        super.postFind();
        let p = this.p; delete this.p;
        return this;
    }
}