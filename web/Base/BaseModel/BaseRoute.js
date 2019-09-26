//BaseModel for Client
class BaseModelRoute extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.destdata           = p.destdata                                                            ? parseInt(p.destdata)              : null ;
        this.destdata2          = p.destdata2 && (p.destination == 101403 || p.destination == 101409)   ? p.destdata2.toString()            : null ;
        this.destination        = p.destination                                                         ? parseInt(p.destination)           : null ;
    }

    extend(){
        return this;
    }
}