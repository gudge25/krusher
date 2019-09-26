/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class emEmployModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find: 'em_GetEmploy',
            Insert: 'em_InsEmploy',
            Update: 'em_UpdEmploy',
            UpdateStatus: 'em_UpdEmployStatus',
            Delete: 'em_DelEmploy',
            GetStat: "em_GetStatEmploy",
            GetStatExport: "em_GetStatEmployExport",
            GetCounter: "em_GetEmployCallCounter",
            GetPrivate: "em_GetPrivateEmploy",
            ReportCalls: "em_GetEmployReportCalls",
            ReportStatus: "em_GetEmployReportStatus"
        };
        super(storedProc);

        this.Insert         = Insert;
        this.Update         = Update;
        this.UpdateStatus   = UpdateStatus;
        this.FindPost       = FindPost;
        this.FindPostIn     = FindPostIn;
        this.Stat           = Stat;
        this.StatIn         = StatIn;
        this.Private        = Private;
        this.ReportCalls    = ReportCalls;
        this.ReportStatus   = ReportStatus;
        this.FileExport     = FileExport;
        this.FileExportIn   = FileExportIn;
        this.Counter        = Counter;
        this.CounterIn      = CounterIn;
    }

    repoStat(params, callback) {
        this.execute(this.StoredProc.GetStat, params, callback);
    }
    repoReportCalls(params, callback) {
        this.execute(this.StoredProc.ReportCalls, params, callback);
    }
    repoReportStatus(params, callback) {
        this.execute(this.StoredProc.ReportStatus, params, callback);
    }
    repoInsert(params, callback) {
        this.execute(this.StoredProc.Insert, params, callback);
    }
    repoPrivate(params, callback) {
        this.execute(this.StoredProc.GetPrivate, params, callback);
    }
    repoFileExport(params, callback) {
        this.execute(this.StoredProc.GetStatExport, params, callback);
    }
    repoCounter(params, callback) {
        this.execute(this.StoredProc.GetCounter, params, callback);
    }
    repoUpdateStatus(params, callback) {
        this.execute(this.StoredProc.UpdateStatus, params, callback);
    }
}

class FindPostIn extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token                  = p.token                    ?   p.token                  : null;
        d.emID                  = p.emID    !== undefined                    ?   p.emID                          : null;
        d.emName                = p.emName                      ?   p.emName                        : null;
        d.LoginName             = p.LoginName                   ?   p.LoginName                     : null;
        d.ManageID              = p.ManageID                    ?   p.ManageID                      : null;
        d.roleID                = p.roleID                      ?   p.roleID                        : null;
        d.sipName               = p.sipName                     ?   p.sipName                       : null;
        d.Queue                 = p.Queue                       ?   p.Queue                         : null;
        d.sipID                 = p.sipID                       ?   p.sipID                         : null;
        d.CompanyID             = p.CompanyID                   ?   p.CompanyID                         : null;
        d.onlineStatus          = p.onlineStatus                ?   p.onlineStatus                         : null;
        d.coIDs                  = p.coIDs                        ?   p.coIDs.filter(x => x).join()                         : null;
        d.pauseDelay                  = p.pauseDelay                        ?   p.pauseDelay                         : null;
        d.isActive              = checkType(p.isActive)         ?   Boolean(p.isActive)          : null;
        d.sorting               = p.sorting                     ?   p.sorting                       : null;
        d.field                 = p.field                       ?   p.field                         : null;
        d.offset                = p.offset                      ?   p.offset                        : null;
        d.limit                 = p.limit                       ?   p.limit                         : null;
    }
}
class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.emID                  = p.emID    !== undefined                    ?   p.emID                          : null;
        d.emName                = p.emName                      ?   p.emName                        : null;
        d.LoginName             = p.LoginName                   ?   p.LoginName                     : null;
        d.ManageID              = p.ManageID                    ?   p.ManageID                      : null;
        d.roleID                = p.roleID                      ?   p.roleID                        : null;
        d.roleName              = p.roleName                    ?   p.roleName                      : null;
        d.sipName               = p.sipName                     ?   p.sipName                       : null;
        d.Queue                 = p.Queue                       ?   p.Queue                         : null;
        d.sipID                 = p.sipID                       ?   p.sipID                         : null;
        d.CompanyID             = p.CompanyID                   ?   p.CompanyID                         : null;
        d.onlineStatus          = p.onlineStatus                ?   p.onlineStatus                         : null;
        d.coIDs                  = p.coIDs                        ?   p.coIDs                         : null;
        d.pauseDelay                  = p.pauseDelay                        ?   p.pauseDelay                         : null;
        d.isActive              = checkType(p.isActive[0])      ?   Boolean(p.isActive[0])          : false;
        d.Created               = p.Created                  ?   p.Created.toISOString()./*replace(/T/, ' ').*/replace(/\..+/, '')                : null;
        d.Changed               = p.Changed                  ?   p.Changed.toISOString()./*replace(/T/, ' ').*/replace(/\..+/, '')                : null;
        d.TokenExpiredDate      = p.TokenExpiredDate                  ?   p.TokenExpiredDate.toISOString()./*replace(/T/, ' ').*/replace(/\..+/, '')                : null;
    }
}

class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token                  = p.token                    ?   p.token                  : null;
        d.emID                  = p.emID                    ?   p.emID                  : null;
        d.emName                = p.emName                  ?   p.emName                : null;
        d.LoginName             = p.LoginName               ?   p.LoginName             : null;
        d.Password              = p.Password                ?   p.Password              : null;
        d.ManageID              = p.ManageID                ?   p.ManageID              : null;
        d.roleID                = p.roleID                  ?   p.roleID                : null;
        d.sipName               = p.sipName                    ?   p.sipName                        : null;
        d.Queue                 = p.Queue                       ?   p.Queue                         : null;
        d.sipID                 = p.sipID                       ?   p.sipID                         : null;
        d.CompanyID                 = p.CompanyID                       ?   p.CompanyID                         : null;
        d.onlineStatus                 = p.onlineStatus                       ?   p.onlineStatus                         : null;
        d.coIDs                  = p.coIDs                        ?   p.coIDs.filter(x => x).join()                         : null;
        d.pauseDelay                  = p.pauseDelay                        ?   p.pauseDelay                         : null;
        d.isActive              = checkType(p.isActive)      ?   Boolean(p.isActive)          : false;
        d.url                   = p.url                     ?   p.url                   : null;
        d.emIDEditor = p.emIDEditor;
        d.host = p.host;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token                  = p.token                    ?   p.token                  : null;
        d.HIID                  = p.HIID  !== undefined                   ?   p.HIID                  : null;
        d.emID                  = p.emID                    ?   p.emID                  : null;
        d.emName                = p.emName                  ?   p.emName                : null;
        d.LoginName             = p.LoginName               ?   p.LoginName             : null;
        d.Password              = p.Password                ?   p.Password              : null;
        d.ManageID              = p.ManageID                ?   p.ManageID              : null;
        d.roleID                = p.roleID                  ?   p.roleID                : null;
        d.sipName               = p.sipName                    ?   p.sipName                        : null;
        d.Queue                 = p.Queue                       ?   p.Queue                         : null;
        d.sipID                 = p.sipID                       ?   p.sipID                         : null;
        d.CompanyID                 = p.CompanyID                       ?   p.CompanyID                         : null;
        d.onlineStatus                 = p.onlineStatus                       ?   p.onlineStatus                         : null;
        d.coIDs                  = p.coIDs                        ?   p.coIDs.filter(x => x).join()                         : null;
        d.pauseDelay                  = p.pauseDelay                        ?   p.pauseDelay                         : null;
        d.isActive              = checkType(p.isActive)      ?   Boolean(p.isActive)          : false;
        d.emIDEditor = p.emIDEditor;
        d.host = p.host;
    }
}
class UpdateStatus extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token                  = p.token                    ?   p.token                  : null;
        d.emID                  = p.emID                    ?   p.emID                  : null;
        d.onlineStatus                 = p.onlineStatus                       ?   p.onlineStatus                         : null;
        d.emIDEditor = p.emIDEditor;
        d.host = p.host;
    }
}
class Stat extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.emID                      = p.emID   !== undefined             ?   p.emID              : '';
        d.emName                = p.emName                  ?   p.emName                : null;
        d.disposition           = p.disposition             ?   p.disposition           : null;
        d.IsOut                 = p.IsOut                   ? checkType(p.IsOut[0])    ?   Boolean(p.IsOut[0]) : false : null;
        d.QtyCall               = p.QtyCall                 ?   p.QtyCall               : null;
        if(typeof d.Period === 'number')
            d.Period                = p.Period                  ?   p.Period                : null;
        else
        {
            if(p.Period.length < 11)
                d.Period                = p.Period                  ?   p.Period.substr(0, 10)                : null;
            else
                d.Period                = p.Period                  ?   p.Period.toISOString()./*replace(/T/, ' ').*/replace(/\..+/, '')                : null;
        }
        d.MonthPeriod                = p.MonthPeriod                  ?   p.MonthPeriod                : null;
        d.YearPeriod                = p.YearPeriod                  ?   p.YearPeriod                : null;
        d.qtyVoiceMin           = p.qtyVoiceMin             ?   p.qtyVoiceMin           : null;
        d.avgVoiceMin           = p.avgVoiceMin             ?   p.avgVoiceMin           : null;
        d.avgWaitMin            = p.avgWaitMin              ?   p.avgWaitMin            : null;
        d.avgBillMin            = p.avgBillMin              ?   p.avgBillMin            : null;
    }
}
class StatIn extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.DateFrom                = p.DateFrom                  ?   p.DateFrom                : null;
        d.DateTo                = p.DateTo                  ?   p.DateTo                : null;
        d.emIDs                      = p.emIDs                ?   p.emIDs.filter(x => {if(x !== false || x !== null || x !== "" || x > 0 )  return x;}).join()              : '';
        d.Step                = p.Step                  ?   p.Step                : null;
        d.disposition           = p.disposition             ?   p.disposition           : null;
        d.dctID           = p.dctID             ?   p.dctID           : null;
        d.IsOut              = checkType(p.IsOut)      ?   Boolean(p.IsOut)          : null;
    }
}
class CounterIn extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.DateFrom                  = p.DateFrom             ?   p.DateFrom                 : null;
        d.DateTo                    = p.DateTo               ?   p.DateTo                   : null;
        d.emIDs                     = p.emIDs                ?   p.emIDs.filter(x => {if(x !== false || x !== null || x !== "" || x > 0 )  return x;}).join()              : '';
    }
}
class Counter extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.Period                    = p.Period             ?   p.Period.toISOString().substring(0, 10)                : null;
        d.emID                      = p.emID               ?   p.emID                   : null;
    }
}
class Private extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.emID                  = p.emID                    ?   p.emID                  : null;
        d.emName                = p.emName                  ?   p.emName                : null;
        d.LoginName             = p.LoginName               ?   p.LoginName             : null;
        d.roleID                = p.roleID                  ?   p.roleID                : null;
        d.roleName              = p.roleName                ?   p.roleName              : null;
        d.Permission            = p.Permission              ?   p.Permission            : null;
        d.Queue                 = p.Queue                   ?   p.Queue                 : false;
        d.onlineStatus          = p.onlineStatus            ?   p.onlineStatus          : null;
        d.coIDs                  = p.coIDs                        ?   p.coIDs                         : null;
        d.isActive              = checkType(p.isActive[0])  ?   Boolean(p.isActive[0])  : false;
    }
}
class ReportCalls extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.emID                  = p.emID                    ?   p.emID                  : null;
        d.emName                = p.emName                  ?   p.emName                : null;
        d.items                 = p.items                   ?   JSON.parse(p.items)     : null;
    }
}
class ReportStatus extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.emID                  = p.emID                    ?   p.emID                  : null;
        d.emName                = p.emName                  ?   p.emName                : null;
        d.qtyClient             = p.qtyClient               ?   p.qtyClient             : null;
    }
}
class FileExportIn extends Model.Post {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.token                = p.token;
        d.DateFrom                = p.DateFrom                  ?   p.DateFrom                : null;
        d.DateTo                = p.DateTo                  ?   p.DateTo                : null;
        d.emIDs                      = p.emIDs                ?   p.emIDs.filter(x => {if(x !== false || x !== null || x !== "" || x > 0 )  return x;}).join()              : '';
        d.Step                = p.Step                  ?   p.Step                : null;
        d.disposition           = p.disposition             ?   p.disposition           : null;
        d.dctID           = p.dctID             ?   p.dctID           : null;
        d.IsOut              = checkType(p.IsOut)      ?   Boolean(p.IsOut)          : null;
    }
}
class FileExport extends Model.Post {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.ccName                = p.ccName              ?   p.ccName         : null;
        d.IsOut                 = p.IsOut               ?   p.IsOut          : null;
        d.clName                = p.clName              ?   p.clName         : null;
        d.Created               = p.Created             ?   p.Created.toISOString()./*replace(/T/, ' ').*/replace(/\..+/, '')       : null;
        d.emName                = p.emName              ?   p.emName         : null;
        d.dcStatusName          = p.dcStatusName        ?   p.dcStatusName   : null;
        d.regName               = p.regName             ?   p.regName        : null;
        d.SIP                   = p.SIP                 ?   p.SIP            : null;
        d.LinkFile              = p.LinkFile            ?   p.LinkFile       : null;
        d.ffName                = p.ffName              ?   p.ffName         : null;
        d.duration              = p.duration            ?   p.duration       : null;
        d.billsec               = p.billsec             ?   p.billsec        : null;
        d.holdtime              = p.holdtime            ?   p.holdtime       : null;
        d.channel               = p.channel             ?   p.channel        : null;
        d.CauseCode             = p.CauseCode           ?   p.CauseCode      : null;
        d.CauseDesc             = p.CauseDesc           ?   p.CauseDesc      : null;
        d.CauseWho              = p.CauseWho            ?   p.CauseWho       : null;
        d.Queue                 = p.Queue               ?   p.Queue          : null;
        d.CallType              = p.CallType            ?   p.CallType       : null;
        d.target                = p.target              ?   p.target       : null;
    }
}

const model = new emEmployModel();
module.exports = model;
