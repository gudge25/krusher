class emEmployeeStatusStatModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
    }

    get(){
        super.get();
        let  p = this.p; delete this.p;
        this.dateSpent      = p.dateSpent               ? p.dateSpent                         : null;
        this.Available      = p.Available               ? (new Date()).clearTime().addSeconds(parseInt(p.Available)).toString('hh:mm:ss')                   : null;
        this.Unvailable     = p.Unvailable              ? (new Date()).clearTime().addSeconds(parseInt(p.Unvailable)).toString('hh:mm:ss')                  : null;
        this.Pause          = p.Pause                   ? (new Date()).clearTime().addSeconds(parseInt(p.Pause)).toString('hh:mm:ss')                       : null;
        this.Dinner         = p.Dinner                  ? (new Date()).clearTime().addSeconds(parseInt(p.Dinner)).toString('hh:mm:ss')                      : null;
        this.Meeting        = p.Meeting                 ? (new Date()).clearTime().addSeconds(parseInt(p.Meeting)).toString('hh:mm:ss')                     : null;
        this.Other          = p.Other                   ? (new Date()).clearTime().addSeconds(parseInt(p.Other)).toString('hh:mm:ss')                       : null;
        this.emID           = p.emID                    ? parseInt(p.emID)                    : null;
        this.All_State      = p.All_State               ? (new Date()).clearTime().addSeconds(parseInt(p.All_State)).toString('hh:mm:ss')                   : null;
        this.Logout         = p.Logout                  ? (new Date()).clearTime().addSeconds(parseInt(p.Logout)).toString('hh:mm:ss')                      : null;
        this.Post_Processing= p.Post_Processing         ? (new Date()).clearTime().addSeconds(parseInt(p.Post_Processing)).toString('hh:mm:ss')             : null;
        return this;
    }
 
    postFind(){
        let p = this.p; 
        super.postFind(p); delete this.p; delete this.isActive;
        //one day ago
        let a = new Date().setDate(new Date().getDate()-1);
        this.DateFrom       = p.DateFrom                                    ?  new Date(p.DateFrom).toString("yyyy-MM-ddT00:00:00")     : new Date(a).toString("yyyy-MM-ddT00:00:00");
        this.DateTo         = p.DateTo                                      ?  new Date(p.DateTo).toString("yyyy-MM-ddT23:59:59")       : new Date().toString("yyyy-MM-ddT23:59:59");
        //this.DateFrom       = p.DateFrom                ? new Date(p.DateFrom).toString("yyyy-MM-ddTHH:mm:ss")  : null;
        //this.DateTo         = p.DateTo                  ? new Date(p.DateTo).toString("yyyy-MM-ddTHH:mm:ss")    : null;
        this.onlineStatus   = p.onlineStatus            ? parseInt(p.onlineStatus)                              : null;
        this.emIDs          = p.emIDs !== undefined     ? p.emIDs.map( x =>  x.emID )                           : [];
        return this;
    }

    postFindNotMap(){
        //super.postFind();
        let p = this.p; delete this.p; delete this.isActive;
        //one day ago
        let a = new Date().setDate(new Date().getDate()-1);
        this.DateFrom       = p.DateFrom                                    ?  new Date(p.DateFrom).toString("yyyy-MM-ddT00:00:00")     : new Date(a).toString("yyyy-MM-ddT00:00:00");
        this.DateTo         = p.DateTo                                      ?  new Date(p.DateTo).toString("yyyy-MM-ddT23:59:59")       : new Date().toString("yyyy-MM-ddT23:59:59");
        this.onlineStatus   = p.onlineStatus                                ? parseInt(p.onlineStatus)                              : null;
        this.emIDs          = p.emIDs !== undefined                         ? p.emIDs                           : [];                             
        return this;
    }
}