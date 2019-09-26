class gaTravellistModel extends BaseModelDC {
    constructor(p) {
        super(p);
        this.p = p;
    }

    get(){
        super.get();
        var p = this.p; delete this.p;

        this.drvID       = p.drvID;
        this.drvName     = p.drvName;
        this.psID        = p.psID;
        this.psName      = p.psName;
        this.isConfirm   = p.isConfirm;
        this.ConfirmBy   = p.ConfirmBy;
        this.ConfirmAt   = p.ConfirmAt;
        this.carID       = p.carID;
        return this;
    }

    put(){
        super.put();
        var p = this.p; delete this.p;

        this.drvID       = p.drvID;
        this.drvName     = p.drvName;
        this.psID        = p.psID;
        this.psName      = p.psName;
        this.carID       = p.carID;
        delete this.dcSum;
        delete this.dcStatus;
        return this;
    }

    post(){
        super.post();
        var p = this.p; delete this.p;

        this.drvID       = p.drvID          ? p.drvID           : null ;
        this.drvName     = p.drvName        ? p.drvName         : null ;
        this.psID        = p.psID;
        this.psName      = p.psName         ? p.psName          : null ;
        this.carID       = p.carID          ? p.carID           : null ;
        this.dcLink      = p.dcLink          ? p.dcLink         : 0;
        delete this.dcSum;
        delete this.dcStatus;
        return this;
    };
}