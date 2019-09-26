class BaseModel {
    constructor(p) {
        p = p ? p : {};
        this.p = p;
        this.isActive   = isBoolean(p.isActive)   ? Boolean(p.isActive)     : null ;
    }


    get(){
        let p = this.p;
        this.HIID       = p.HIID  !== undefined         ? p.HIID            : null ;
        this.Created    = p.Created                     ? p.Created         : null ;
        this.CreatedBy  = p.CreatedBy                   ? p.CreatedBy       : null ;
        this.Changed    = p.Changed                     ? p.Changed         : null ;
        this.ChangedBy  = p.ChangedBy                   ? p.ChangedBy       : null ;
        this.uID        = p.uID                         ? p.uID             : null ;

        //FOR filter
        if(this.Created) this.isToday = new Date().getDate() == new Date(this.Created).getDate() && new Date().getMonth() == new Date(this.Created).getMonth() && new Date().getFullYear() == new Date(this.Created).getFullYear()  ? true  : false ;
        if(!this.__proto__.hasOwnProperty('get')){ delete this.p;  return this; }
    }

    post(){
        let p = this.p;
        this.isActive   = isBoolean(p.isActive)   ? Boolean(p.isActive)     : true ;
        if(!this.__proto__.hasOwnProperty('post')){ delete this.p;  return this; }
    }

    put(){
        let p = this.p;
        this.HIID = p.HIID;
        this.isActive   = isBoolean(p.isActive)   ? Boolean(p.isActive)     : true ;
        if(!this.__proto__.hasOwnProperty('put')){ delete this.p;  return this; }
    }

    postFind(){       
        let p = this.p;
        this.offset     = p.offset  ? p.offset  : 0 ;
        this.limit      = p.limit   ? p.limit   : 100 ;
        this.sorting    = p.sorting ? p.sorting : `DESC`;
        this.field      = p.field   ? p.field   : null;
        if(!this.__proto__.hasOwnProperty('postFind')){ delete this.p;  return this; }
    }
}