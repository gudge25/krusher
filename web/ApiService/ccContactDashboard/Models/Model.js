class ccContactDashboardModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.ID         = p.ID;
        this.Name       = p.Name;
        this.QtyCalls   = p.QtyCalls | 0;
        this.Percent    = (p.Percent*100).toFixed() | 0;
        this.data1	    = p.data1 ? p.data1 : null;
        this.data2      = p.data2 ? p.data2 : null;
        this.data3      = p.data3 ? p.data3 : null;
    }
}