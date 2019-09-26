//BaseModel for Client
class BaseModelHystory extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.RowID          = parseInt(p.RowID)         ? parseInt(p.RowID)             : null;
        this.DateChangeFrom = p.DateChangeFrom          ? p.DateChangeFrom              : null;
        this.DateChangeTo   = p.DateChangeTo            ? p.DateChangeTo                : null;
        this.host           = p.host                    ? p.host.toString()             : null;
        this.AppName        = parseInt(p.AppName)       ? parseInt(p.AppName)           : null;
    }
}