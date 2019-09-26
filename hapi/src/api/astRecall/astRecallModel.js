/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');
class astRecallModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find:   'ast_GetRecall',
            Insert: 'ast_InsRecall',
            Update: 'ast_UpdRecall',
            Delete: 'ast_DelRecall',
            Recall: 'cc_RecallByScenario'
        };
        super(storedProc);

        this.Insert         = Insert;
        this.Update         = Update;
        this.FindPost       = FindPost;
        this.FindPostIn     = FindPostIn;
        this.Recall         = Recall;
    }

    repoRecall(params, callback) {
        this.execute(this.StoredProc.Recall, params, callback);
    }
}
class FindPostIn extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token                         = p.token                                       ?   p.token                                 : null;
        d.rcID                          = p.rcID                                        ?   p.rcID                                  : null;
        d.rcName                        = p.rcName                               ?   p.rcName                         : null;
        d.callerID                      = p.callerID                                    ?   p.callerID                              : null;
        d.TimeBegin                     = p.TimeBegin                                   ?   p.TimeBegin                             : null;
        d.TimeEnd                       = p.TimeEnd                                     ?   p.TimeEnd                               : null;
        d.DaysCall                      = p.DaysCall                                    ?   p.DaysCall                              : null;
        d.RecallCount                   = p.RecallCount  !== undefined                  ?   p.RecallCount                           : 0;
        d.RecallAfterMin                = p.RecallAfterMin !== undefined                              ?   p.RecallAfterMin                        : 0;
        d.RecallCountPerDay             = p.RecallCountPerDay !== undefined                           ?   p.RecallCountPerDay                     : 0;
        d.RecallDaysCount               = p.RecallDaysCount    !== undefined                          ?   p.RecallDaysCount                       : 0;
        d.RecallAfterPeriod             = p.RecallAfterPeriod  !== undefined                          ?   p.RecallAfterPeriod                     : 0;
        d.AutoDial                      = p.AutoDial                                    ?   p.AutoDial                              : null;
        d.IsCallToOtherClientNumbers    = checkType(p.IsCallToOtherClientNumbers)    ?   Boolean(p.IsCallToOtherClientNumbers): null;
        d.IsCheckCallFromOther          = checkType(p.IsCheckCallFromOther)          ?   Boolean(p.IsCheckCallFromOther)      : null;
        d.AllowPrefix                   = p.AllowPrefix                                 ?   p.AllowPrefix.filter(x => x).join()     : null;
        d.destination                   = p.destination                                 ?   p.destination                           : null;
        d.destdata                      = p.destdata                                    ?   p.destdata                              : null;
        d.destdata2                     = p.destdata2                                   ?   p.destdata2                             : null;
        d.target                        = p.target                                      ?   p.target                                : null;
        d.roIDs                          = p.roIDs                                        ?   p.roIDs.filter(x => x).join()            : null;
        d.isFirstClient                 = checkType(p.isFirstClient)                 ?   Boolean(p.isFirstClient)             : null;
        d.isResponsible                 = checkType(p.isResponsible)                 ?   Boolean(p.isResponsible)             : null;
        d.type                          = p.type                                        ?   p.type                                  : null;
        d.isActive                      = checkType(p.isActive)                      ?   Boolean(p.isActive)                  : null;
    }
}
class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID                          = p.HIID     !== undefined                      ?   p.HIID                                  : null;
        d.rcID                          = p.rcID                                        ?   p.rcID                                  : null;
        d.rcName                 = p.rcName                               ?   p.rcName                         : null;
        d.callerID                      = p.callerID                                    ?   p.callerID                              : null;
        d.TimeBegin                     = p.TimeBegin                                   ?   p.TimeBegin                             : null;
        d.TimeEnd                       = p.TimeEnd                                     ?   p.TimeEnd                               : null;
        d.DaysCall                      = p.DaysCall                                    ?   p.DaysCall                              : null;
        d.RecallCount                   = p.RecallCount  !== undefined                  ?   p.RecallCount                           : 0;
        d.RecallAfterMin                = p.RecallAfterMin !== undefined                ?   p.RecallAfterMin                        : 0;
        d.RecallCountPerDay             = p.RecallCountPerDay !== undefined             ?   p.RecallCountPerDay                     : 0;
        d.RecallDaysCount               = p.RecallDaysCount    !== undefined            ?   p.RecallDaysCount                       : 0;
        d.RecallAfterPeriod             = p.RecallAfterPeriod  !== undefined            ?   p.RecallAfterPeriod                     : 0;
        d.AutoDial                      = p.AutoDial                                    ?   p.AutoDial                              : null;
        d.IsCallToOtherClientNumbers    = checkType(p.IsCallToOtherClientNumbers[0])    ?   Boolean(p.IsCallToOtherClientNumbers[0]): null;
        d.IsCheckCallFromOther          = checkType(p.IsCheckCallFromOther[0])          ?   Boolean(p.IsCheckCallFromOther[0])      : null;
        d.AllowPrefix                   = p.AllowPrefix                                 ?   p.AllowPrefix                           : null;
        d.destination                   = p.destination                                 ?   p.destination                           : null;
        d.destinationName               = p.destinationName                             ?   p.destinationName                       : null;
        d.destdata                      = p.destdata                                    ?   p.destdata                              : null;
        d.destdataName                  = p.destdataName                                ?   p.destdataName                          : null;
        d.destdata2                     = p.destdata2                                   ?   p.destdata2                             : null;
        d.target                        = p.target                                      ?   p.target                                : null;
        d.roIDs                         = p.roIDs                                       ?   p.roIDs                                 : null;
        d.isFirstClient                 = checkType(p.isFirstClient[0])                 ?   Boolean(p.isFirstClient[0])             : null;
        d.isResponsible                 = checkType(p.isResponsible[0])                 ?   Boolean(p.isResponsible[0])             : null;
        d.statusMessage                 = p.statusMessage                               ?   p.statusMessage                          : null;
        d.type                          = p.type                                        ?   p.type                                  : null;
        d.isActive                      = checkType(p.isActive[0])                      ?   Boolean(p.isActive[0])                  : null;
        d.Created                       = p.Created                 ?   p.Created.toISOString().replace(/\..+/, '')                             : null;
        d.Changed                       = p.Changed                 ?   p.Changed.toISOString().replace(/\..+/, '')                             : null;
    }
}
class Recall extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        /*if (p.length > 0) {
            if (p.clID != null) {*/
                d.clID              = p.clID            ?   p.clID              : null;
                d.clName            = p.clName          ?   p.clName            : null;
                d.ccID              = p.ccID            ?   p.ccID              : null;
                d.phone             = p.ccName          ?   p.ccName            : null;
                d.callerID          = p.callerID        ?   p.callerID          : null;
                d.SleepTime         = p.SleepTime       ?   p.SleepTime         : null;
                d.RecallAfterMin    = p.RecallAfterMin  ?   p.RecallAfterMin    : null;
                d.destination       = p.destination     ?   p.destination       : null;
                d.destdata          = p.destdata        ?   p.destdata          : null;
                d.destdataName          = p.destdataName        ?   p.destdataName          : null;
                d.target            = p.target          ?   p.target            : null;
                d.AutoDial          = p.AutoDial        ?   p.AutoDial          : null;
                d.ffID              = p.ffID            ?   p.ffID              : null;
                d.curID             = p.curID           ?   p.curID             : null;
                d.curName           = p.curName         ?   p.curName           : null;
                d.langID            = p.langID          ?   p.langID            : null;
                d.langName          = p.langName        ?   p.langName          : null;
                d.sum               = p.sum             ?   p.sum               : null;
                d.ShortName = p.ShortName ? p.ShortName : null;
                d.CompanyID = p.CompanyID ? p.CompanyID : null;
                d.CallDate = p.CallDate ? p.CallDate : null;
                d.KVEDName = p.KVEDName ? p.KVEDName : null;
                d.KVED = p.KVED ? p.KVED : null;
                d.Sex = p.Sex ? p.Sex : null;
                d.IsPerson = p.IsPerson ? checkType(p.IsPerson[0]) ? Boolean(p.IsPerson[0]) : false : null;
                d.Comment = p.Comment ? p.Comment : null;
                d.ParentName = p.ParentName ? p.ParentName : null;
                d.ffName = p.ffName ? p.ffName : null;
                d.ActualStatus = p.ActualStatus ? p.ActualStatus : null;
                d.PositionName = p.PositionName ? p.PositionName : null;
                d.emID = p.emID ? p.emID : null;
                d.emName = p.emName ? p.emName : null;
                d.sipID = p.sipID ? p.sipID : null;
                d.sipName = p.sipName ? p.sipName : null;
                d.ActDate = p.ActDate ? p.ActDate : null;
                d.cusID = p.cusID ? p.cusID : null;
                d.Account = p.Account ? p.Account : null;
                d.Bank = p.Bank ? p.Bank : null;
                d.TaxCode = p.TaxCode ? p.TaxCode : null;
                d.RegCode = p.RegCode ? p.RegCode : null;
                d.CertNumber = p.CertNumber ? p.CertNumber : null;
                d.SortCode = p.SortCode ? p.SortCode : null;
                d.OrgType = p.OrgType ? p.OrgType : null;
                d.Aid = p.Aid ? p.Aid : null;
                d.coID = p.coID ? p.coID : null;
                d.uID = p.uID ? p.uID : null;
                d.dcID = p.dcID ? p.dcID : null;
           /* }
        }*/
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token                         = p.token                                       ?   p.token                                 : null;
        d.rcID                   = p.rcID                                 ?   p.rcID                           : null;
        d.rcName                 = p.rcName                               ?   p.rcName                         : null;
        d.callerID                      = p.callerID                                    ?   p.callerID                              : null;
        d.TimeBegin                     = p.TimeBegin                                   ?   p.TimeBegin                             : null;
        d.TimeEnd                       = p.TimeEnd                                     ?   p.TimeEnd                               : null;
        d.DaysCall                      = p.DaysCall                                    ?   p.DaysCall                              : null;
        d.RecallCount                   = p.RecallCount  !== undefined                  ?   p.RecallCount                           : 0;
        d.RecallAfterMin                = p.RecallAfterMin !== undefined                              ?   p.RecallAfterMin                        : 0;
        d.RecallCountPerDay             = p.RecallCountPerDay !== undefined                           ?   p.RecallCountPerDay                     : 0;
        d.RecallDaysCount               = p.RecallDaysCount    !== undefined                          ?   p.RecallDaysCount                       : 0;
        d.RecallAfterPeriod             = p.RecallAfterPeriod  !== undefined                          ?   p.RecallAfterPeriod                     : 0;
        d.AutoDial                      = p.AutoDial                                    ?   p.AutoDial                              : null;
        d.IsCallToOtherClientNumbers    = checkType(p.IsCallToOtherClientNumbers)       ?   Boolean(p.IsCallToOtherClientNumbers)   : false;
        d.IsCheckCallFromOther          = checkType(p.IsCheckCallFromOther)             ?   Boolean(p.IsCheckCallFromOther)         : false;
        d.AllowPrefix                   = p.AllowPrefix                                 ?   p.AllowPrefix.filter(x => x).join()     : null;
        d.destination                   = p.destination                                 ?   p.destination                           : null;
        d.destdata                      = p.destdata                                    ?   p.destdata                              : null;
        d.destdata2                     = p.destdata2                                   ?   p.destdata2                             : null;
        d.target                        = p.target                                      ?   p.target                                : null;
        d.roIDs                          = p.roIDs                                        ?   p.roIDs.filter(x => x).join()            : null;
        d.isFirstClient                 = checkType(p.isFirstClient)                    ?   Boolean(p.isFirstClient)                : false;
        d.isResponsible                 = checkType(p.isResponsible)                    ?   Boolean(p.isResponsible)                : false;
        d.statusMessage                 = p.statusMessage                               ?   p.statusMessage                          : null;
        d.type                          = p.type                                        ?   p.type                                  : null;
        d.isActive                      = checkType(p.isActive)                         ?   Boolean(p.isActive)                     : false;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token                         = p.token                                       ?   p.token                                 : null;
        d.HIID = p.HIID;
        d.rcID                   = p.rcID                                 ?   p.rcID                           : null;
        d.rcName                 = p.rcName                               ?   p.rcName                         : null;
        d.callerID                      = p.callerID                                    ?   p.callerID                              : null;
        d.TimeBegin                     = p.TimeBegin                                   ?   p.TimeBegin                             : null;
        d.TimeEnd                       = p.TimeEnd                                     ?   p.TimeEnd                               : null;
        d.DaysCall                      = p.DaysCall                                    ?   p.DaysCall                              : null;
        d.RecallCount                   = p.RecallCount  !== undefined                  ?   p.RecallCount                           : 0;
        d.RecallAfterMin                = p.RecallAfterMin !== undefined                              ?   p.RecallAfterMin                        : 0;
        d.RecallCountPerDay             = p.RecallCountPerDay !== undefined                           ?   p.RecallCountPerDay                     : 0;
        d.RecallDaysCount               = p.RecallDaysCount    !== undefined                          ?   p.RecallDaysCount                       : 0;
        d.RecallAfterPeriod             = p.RecallAfterPeriod  !== undefined                          ?   p.RecallAfterPeriod                     : 0;
        d.AutoDial                      = p.AutoDial                                    ?   p.AutoDial                              : null;
        d.IsCallToOtherClientNumbers    = checkType(p.IsCallToOtherClientNumbers)       ?   Boolean(p.IsCallToOtherClientNumbers)   : false;
        d.IsCheckCallFromOther          = checkType(p.IsCheckCallFromOther)             ?   Boolean(p.IsCheckCallFromOther)         : false;
        d.AllowPrefix                   = p.AllowPrefix                                 ?   p.AllowPrefix.filter(x => x).join()     : null;
        d.destination                   = p.destination                                 ?   p.destination                           : null;
        d.destdata                      = p.destdata                                    ?   p.destdata                              : null;
        d.destdata2                     = p.destdata2                                   ?   p.destdata2                             : null;
        d.target                        = p.target                                      ?   p.target                                : null;
        d.roIDs                         = p.roIDs                                       ?   p.roIDs.filter(x => x).join()           : null;
        d.isFirstClient                 = checkType(p.isFirstClient)                    ?   Boolean(p.isFirstClient)                : false;
        d.isResponsible                 = checkType(p.isResponsible)                    ?   Boolean(p.isResponsible)                : false;
        d.statusMessage                 = p.statusMessage                               ?   p.statusMessage                         : null;
        d.type                          = p.type                                        ?   p.type                                  : null;
        d.isActive                      = checkType(p.isActive)                         ?   Boolean(p.isActive)                     : false;
    }
}

const model = new astRecallModel();
module.exports = model;

//JDI model from WEB
// class astRouteIncModel extends BaseModelNew {
//     constructor(p) {
//         p = p ? p : {};
//         super(p);
//         this.p = p;
//         this.rtID           = p.rtID        ? p.rtID    : null ;
//         this.Aid            = p.Aid         ? p.Aid     : null ;
//         this.trID           = p.trID        ? p.trID    : null ;
//         this.DID            = p.DID         ? p.DID     : null ;
//         this.exten          = p.exten       ? p.exten   : null ;
//         this.context        = p.context     ? p.context : null ;
//         this.Action         = p.Action      ? p.Action  : null ;
//         this.isActive       = p.isActive    ? p.isActive: null ;
//     }

//     get(){
//         super.get();
//         let p = this.p; delete this.p;
//         return this;
//     }

//     postFind(){
//         super.postFind();
//         let p = this.p; delete this.p;
//         return this;
//     }

//     put(){
//         super.put();
//         let p = this.p; delete this.p;
//         return this;
//     }

//     post(){
//         super.post();
//         let p = this.p; delete this.p;
//         delete this.rtID;
//         this.context        = p.context     ? p.context : `office` ;
//         this.isActive       = p.isActive    ? p.isActive: true ;
//         return this;
//     }
// }