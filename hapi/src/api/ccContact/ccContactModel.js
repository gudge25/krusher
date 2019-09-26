/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
var BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class ccContactModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find: 'cc_GetContact',
            ForSip: 'cc_GetForSip',
            BillReport: 'cc_GetBillingReport',
            dailyHour: 'cc_GetDailyHour',
            dailyHourExport: 'cc_GetExportDailyHour',
            dailyCalls: 'cc_GetDailyCalls',
            dailyCallsExport: 'cc_GetExportDailyCalls',
            dailyStatuses: 'cc_GetDailyStatuses',
            dailyStatusesExport: 'cc_GetExportDailyStatuses',
            dailyReport: 'cc_GetDailyReport',
            dailyReportExport: 'cc_GetExportDailyReport',
            Dashboard: 'cc_GetDashboard',
            GetMissed: 'cc_GetMissed',
            CallerManager: 'cc_GetLastCallerManager',
            FileExport: 'cc_GetExport',
            FileExportRecords: 'cc_SetExportRecords',
            FileExportRecordsList: 'cc_GetExportRecordsList',
            DeleteExportRecords: 'cc_DelExportRecords',
            Delete: `cc_DelContact`,
            Insert: 'cc_InsContact',
            Update: 'cc_UpdContact',
        };
        super(storedProc);

        this.Find           = Find;
        this.FindIn         = FindIn;
        this.FindIn         = FindIn;
        this.ForSip         = ForSip;
        this.Dashboard      = Dashboard;
        this.CallerManager  = CallerManager;
        this.FileExport     = FileExport;
        this.FileExportIn   = FileExportIn;
        this.Update         = Update;
        this.Insert         = Insert;
        this.dailyHour      = dailyHour;
        this.dailyHourIn    = dailyHourIn;
        this.dailyStatuses  = dailyStatuses;
        this.dailyStatusesIn= dailyStatusesIn;
        this.dailyCalls     = dailyCalls;
        this.dailyCallsIn   = dailyCallsIn;
        this.dailyReportIn  = dailyReportIn;
        this.dailyReport    = dailyReport;
        this.InsList        = InsList;
        this.FindInList     = FindInList;
        this.RecordExportList     = RecordExportList;
        this.FindInExportRecord     = FindInExportRecord;
        this.getMissed     = getMissed;
    }
    repoForSip(params, callback) {
        this.execute(this.StoredProc.ForSip, params, callback);
    }
    repoBillReport(params, callback) {
        this.execute(this.StoredProc.BillReport, params, callback);
    }
    repodailyHour(params, callback) {
        this.execute(this.StoredProc.dailyHour, params, callback);
    }
    repodailyHourExport(params, callback) {
        this.execute(this.StoredProc.dailyHourExport, params, callback);
    }
    repodailyCalls(params, callback) {
        this.execute(this.StoredProc.dailyCalls, params, callback);
    }
    repodailyCallsExport(params, callback) {
        this.execute(this.StoredProc.dailyCallsExport, params, callback);
    }
    repodailyStatuses(params, callback) {
        this.execute(this.StoredProc.dailyStatuses, params, callback);
    }
    repodailyStatusesExport(params, callback) {
        this.execute(this.StoredProc.dailyStatusesExport, params, callback);
    }
    repoGetDashboard(params, callback) {
        this.execute(this.StoredProc.Dashboard, params, callback);
    }
    repoFileExport(params, callback) {
        this.execute(this.StoredProc.FileExport, params, callback);
    }
    repoCallerManager(params, callback) {
        this.execute(this.StoredProc.CallerManager, params, callback);
    }
    repodailyReport(params, callback) {
        this.execute(this.StoredProc.dailyReport, params, callback);
    }
    repodailyReportExport(params, callback) {
        this.execute(this.StoredProc.dailyReportExport, params, callback);
    }
    repoFindRecords(params, callback) {
        this.execute(this.StoredProc.FileExportRecords, params, callback);
    }
    repoFindRecordsList(params, callback) {
        this.execute(this.StoredProc.FileExportRecordsList, params, callback);
    }
    repoDeleteExportRecords(params, callback) {
        this.execute(this.StoredProc.DeleteExportRecords, params, callback);
    }
    repogetMissed(params, callback) {
        this.execute(this.StoredProc.GetMissed, params, callback);
    }
}

class FindIn extends Model.Get {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.DateFrom   = p.DateFrom;
        d.DateTo   = p.DateTo;
        d.dcIDs                         = p.dcIDs                   ?   p.dcIDs.filter(x => x).join()              : null;
        d.emIDs                         = p.emIDs                   ?   p.emIDs.filter(x => x).join()              : null;
        d.dcStatuss                     = p.dcStatuss               ?   p.dcStatuss.filter(x => x).join()          : null;
        d.ffIDs                         = p.ffIDs                   ?   p.ffIDs.filter(x => x).join()              : null;
        d.isMissed   = p.isMissed;
        d.isUnique   = p.isUnique;
        d.offset   = p.offset;
        d.limit   = p.limit;
        d.CallTypes                      = p.CallTypes                ?   p.CallTypes.filter(x => x).join()              : null;
        d.ccNames                      = p.ccNames                ?   p.ccNames.filter(x => x).join()              : null;
        d.channels                      = p.channels                ?   p.channels.filter(x => x).join()              : null;
        d.comparison            = p.comparison;
        d.billsec               = p.billsec;
        d.clIDs                 = p.clIDs              ?   p.clIDs.filter(x => x).join()              : null;
        d.IsOut                 = p.IsOut === 'null'   ?   false : p.IsOut ;
        d.id_autodials          = p.id_autodials       ?   p.id_autodials.filter(x => x).join()              : null;
        d.id_scenarios          = p.id_scenarios       ?   p.id_scenarios.filter(x => x).join()              : null;
        d.ManageIDs             = p.ManageIDs          ?   p.ManageIDs.filter(x => x).join()              : null;
        d.target                = p.target             ?   p.target          : null;
        d.coIDs                 = p.coIDs              ?   p.coIDs.filter(x => x).join()              : null;
        d.destination           = p.destination        ?   p.destination       : null;
        d.destdata              = p.destdata           ?   p.destdata          : null;
        d.destdata2             = p.destdata2          ?   p.destdata2         : null;
        d.ContactStatuses             = p.ContactStatuses          ?   p.ContactStatuses.filter(x => x).join()         : null;
        d.emID   = p.emID;
    }
}
class FindInExportRecord extends Model.Get {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.DateFrom   = p.DateFrom;
        d.DateTo   = p.DateTo;
        d.dcIDs                         = p.dcIDs                   ?   p.dcIDs.filter(x => x).join()              : null;
        d.emIDs                         = p.emIDs                   ?   p.emIDs.filter(x => x).join()              : null;
        d.dcStatuss                     = p.dcStatuss               ?   p.dcStatuss.filter(x => x).join()          : null;
        d.ffIDs                         = p.ffIDs                   ?   p.ffIDs.filter(x => x).join()              : null;
        d.isMissed   = p.isMissed;
        d.isUnique   = p.isUnique;
        d.offset   = p.offset;
        d.limit   = p.limit;
        d.CallTypes                      = p.CallTypes                ?   p.CallTypes.filter(x => x).join()              : null;
        d.ccNames                      = p.ccNames                ?   p.ccNames.filter(x => x).join()              : null;
        d.channels                      = p.channels                ?   p.channels.filter(x => x).join()              : null;
        d.comparison            = p.comparison;
        d.billsec               = p.billsec;
        d.clIDs                 = p.clIDs              ?   p.clIDs.filter(x => x).join()              : null;
        d.IsOut                 = p.IsOut === 'null'   ?   false : p.IsOut ;
        d.id_autodials          = p.id_autodials       ?   p.id_autodials.filter(x => x).join()              : null;
        d.id_scenarios          = p.id_scenarios       ?   p.id_scenarios.filter(x => x).join()              : null;
        d.ManageIDs             = p.ManageIDs          ?   p.ManageIDs.filter(x => x).join()              : null;
        d.target                = p.target             ?   p.target          : null;
        d.coIDs                 = p.coIDs              ?   p.coIDs.filter(x => x).join()              : null;
        d.destination           = p.destination        ?   p.destination       : null;
        d.destdata              = p.destdata           ?   p.destdata          : null;
        d.destdata2             = p.destdata2          ?   p.destdata2         : null;
        d.ContactStatuses             = p.ContactStatuses          ?   p.ContactStatuses.filter(x => x).join()         : null;
        d.convertFormat             = p.convertFormat          ?   p.convertFormat        : null;
        d.emID   = p.emID;
    }
}
class getMissed extends Model.Get {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.missed   = p.missed;
    }
}
class FindInList extends Model.Get {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.DateFrom   = p.DateFrom;
        d.DateTo   = p.DateTo;
        d.statusReady   = p.statusReady;
        d.convertFormat   = p.convertFormat;
    }
}

class Find extends Model.Get {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.DateFrom              = p.DateFrom;
        d.DateTo                = p.DateTo;
        d.Created               = p.Created                 ?   p.Created.toISOString().replace(/\..+/, '')                             : null;
        d.HIID                  = p.HIID                    ?   p.HIID                                                                  : null;
        d.dcID                  = p.dcID                    ?   p.dcID                                                                  : null;
        d.ccID                  = p.ccID                    ?   p.ccID                                                                  : null;
        d.ccName                = p.ccName                  ?   p.ccName                                                                : null;
        d.IsOut                 = p.IsOut                   ? checkType(p.IsOut[0])    ?   Boolean(p.IsOut[0]) : false : null;
        d.isMissed                 = p.isMissed                   ? checkType(p.isMissed[0])    ?   Boolean(p.isMissed[0]) : false : null;
        d.clID                  = p.clID                    ?   p.clID                                                                  : null;
        d.clName                = p.clName                  ?   p.clName                                                                : null;
        d.IsPerson              = p.IsPerson                ? checkType(p.IsPerson[0])    ?   Boolean(p.IsPerson[0]) : false : null;
        d.emID                  = p.emID                    ?   p.emID                                                                  : null;
        d.emName                = p.emName                  ?   p.emName                                                                : null;
        d.dcStatus              = p.dcStatus                ?   p.dcStatus                                                              : null;
        d.dcStatusName          = p.dcStatusName            ?   p.dcStatusName                                                          : null;
        d.SIP                   = p.SIP                     ?   p.SIP                                                                   : null;
        d.LinkFile              = p.LinkFile                ?   p.LinkFile                                                              : null;
        d.ffID                  = p.ffID                    ?   p.ffID                                                                  : null;
        d.ffName                = p.ffName                  ?   p.ffName                                                                : null;
        d.uID                   = p.uID                     ?   p.uID                                                                   : null;
        d.duration              = p.duration                ?   p.duration                                                              : null;
        d.billsec               = p.billsec                 ?   p.billsec                                                               : null;
        d.holdtime              = p.holdtime                ?   p.holdtime                                                              : null;
        d.serviceLevel          = p.serviceLevel            ?   p.serviceLevel                                                          : null;
        d.channel               = p.channel                 ?   p.channel                                                               : null;
        d.CauseCode             = p.CauseCode               ?   p.CauseCode                                                             : null;
        d.CauseDesc             = p.CauseDesc               ?   p.CauseDesc                                                             : null;
        d.CauseWho              = p.CauseWho                ?   p.CauseWho                                                              : null;
        d.CallType              = p.CallType                ?   p.CallType                                                              : null;
        d.id_autodial           = p.id_autodial             ?   p.id_autodial                                                           : null;
        d.id_scenario           = p.id_scenario             ?   p.id_scenario                                                           : null;
        d.target                = p.target                  ?   p.target                                                                : null;
        d.coID                  = p.coID                    ?   p.coID                                                                  : null;
        d.coName                = p.coName                  ?   p.coName                                                                : null;
        d.coDescription         = p.coDescription           ?   p.coDescription                                                         : null;
        d.destination           = p.destination             ?   p.destination       : null;
        d.destdata              = p.destdata                ?   p.destdata          : null;
        d.destdata2             = p.destdata2               ?   p.destdata2         : null;
        d.transferFrom          = p.transferFrom            ?   p.transferFrom         : null;
        d.transferTo            = p.transferTo              ?   p.transferTo         : null;
        d.Comment               = p.Comment                 ?   p.Comment                                                               : null;
        d.ContactStatus         = p.ContactStatus           ?   p.ContactStatus                                                         : null;
        d.isActive              = p.isActive                ?   checkType(p.isActive[0])    ?   Boolean(p.isActive[0]) : false : null;
    }
}
class InsList extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.ID              = p.ID;
    }
}
class ForSip extends Model.Get {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.ccID                  = p.ccID                ?   p.ccID          : null;
        d.ccName                = p.ccName              ?   p.ccName        : null;
        d.clID                  = p.clID                ?   p.clID          : null;
        d.clName                = p.clName              ?   p.clName        : null;
        d.dcID                  = p.dcID                ?   p.dcID          : null;
    }
}

class FileExportIn extends Model.Post {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.token   = p.token;
        d.DateFrom   = p.DateFrom;
        d.DateTo   = p.DateTo;
        d.emIDs                         = p.emIDs                   ?   p.emIDs.filter(x => x).join()              : '';
        d.dcStatuss                     = p.dcStatuss               ?   p.dcStatuss.filter(x => x).join()          : '';
        d.ffIDs                         = p.ffIDs                   ?   p.ffIDs.filter(x => x).join()              : '';
        d.isMissed   = p.isMissed;
        d.isUnique   = p.isUnique;
        d.CallTypes                      = p.CallTypes                ?   p.CallTypes.filter(x => x).join()              : '';
        d.ccNames                      = p.ccNames                ?   p.ccNames.filter(x => x).join()              : '';
        d.channels                      = p.channels                ?   p.channels.filter(x => x).join()              : '';
        d.comparison   = p.comparison;
        d.billsec  = p.billsec;
        d.clIDs                      = p.clIDs                ?   p.clIDs.filter(x => x).join()              : '';
        d.IsOut                 = p.IsOut === 'null'   ?   false : p.IsOut ;
        d.id_autodials                      = p.id_autodials                ?   p.id_autodials.filter(x => x).join()              : '';
        d.id_scenarios                      = p.id_scenarios                ?   p.id_scenarios.filter(x => x).join()              : '';
        d.target                = p.target              ?   p.target       : null;
        d.url                = p.url              ?   p.url       : '';
        d.isActive                 = p.isActive === 'null'   ?   false : p.isActive ;
    }
}
class RecordExportList extends Model.Post {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.idCR                = p.idCR              ?   p.idCR         : null;
        d.link                 = p.link               ?   p.link          : null;
        d.statusReady                 = p.statusReady               ?   p.statusReady          : null;
        d.DateFrom               = p.DateFrom             ?   p.DateFrom.toISOString()./*replace(/T/, ' ').*/replace(/\..+/, '')       : null;
        d.DateTo               = p.DateTo             ?   p.DateTo.toISOString()./*replace(/T/, ' ').*/replace(/\..+/, '')       : null;
        d.dcIDs                 = p.dcIDs               ?   p.dcIDs          : null;
        d.emIDs                 = p.emIDs               ?   p.emIDs          : null;
        d.dcStatuss                 = p.dcStatuss               ?   p.dcStatuss          : null;
        d.ffIDs                 = p.ffIDs               ?   p.ffIDs          : null;
        d.isMissed = p.isMissed ? checkType(p.isMissed[0]) ? Boolean(p.isMissed[0]) : false : null;
        d.isUnique = p.isUnique ? checkType(p.isUnique[0]) ? Boolean(p.isUnique[0]) : false : null;
        d.CallTypes                 = p.CallTypes               ?   p.CallTypes          : null;
        d.channels                 = p.channels               ?   p.channels          : null;
        d.ccNames                 = p.ccNames               ?   p.ccNames          : null;
        d.comparison                 = p.comparison               ?   p.comparison          : null;
        d.billsec                 = p.billsec               ?   p.billsec          : null;
        d.clIDs                 = p.clIDs               ?   p.clIDs          : null;
        d.clIDs                 = p.clIDs               ?   p.clIDs          : null;
        d.IsOut = p.IsOut ? checkType(p.IsOut[0]) ? Boolean(p.IsOut[0]) : false : null;
        d.id_autodials                 = p.id_autodials               ?   p.id_autodials          : null;
        d.id_scenarios                 = p.id_scenarios               ?   p.id_scenarios          : null;
        d.ManageIDs                 = p.ManageIDs               ?   p.ManageIDs          : null;
        d.target                 = p.target               ?   p.target          : null;
        d.coIDs                 = p.coIDs               ?   p.coIDs          : null;
        d.destination                 = p.destination               ?   p.destination          : null;
        d.destdata                 = p.destdata               ?   p.destdata          : null;
        d.destdata2                 = p.destdata2               ?   p.destdata2          : null;
        d.ContactStatuses                 = p.ContactStatuses               ?   p.ContactStatuses          : null;
        d.emID                 = p.emID               ?   p.emID          : null;
        d.convertFormat                 = p.convertFormat               ?   p.convertFormat          : null;
        d.isActive = p.isActive ? checkType(p.isActive[0]) ? Boolean(p.isActive[0]) : false : null;
        d.Created               = p.Created             ?   p.Created.toISOString()./*replace(/T/, ' ').*/replace(/\..+/, '')       : null;
        d.Changed               = p.Changed             ?   p.Changed.toISOString()./*replace(/T/, ' ').*/replace(/\..+/, '')       : null;
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
        d.CallType              = p.CallType            ?   p.CallType       : null;
        d.target                = p.target              ?   p.target       : null;
    }
}
class Dashboard extends Model.Get {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.ID                    = p.ID                  ?   p.ID            : null;
        d.Name                  = p.Name                ?   p.Name          : null;
        d.QtyCalls              = p.QtyCalls            ?   p.QtyCalls      : null;
        d.Percent               = p.Percent             ?   p.Percent       : null;
        d.ModuleID              = p.ModuleID            ?   p.ModuleID      : null;
    }
}
class CallerManager extends Model.Get {
    constructor(p) {

        super(p);
        const d = this.Data;
        if (p.length > 0) {
            if (p.queID != null) {
                d.queID = p.queID ? p.queID : null;
                d.queName = p.queName ? p.queName : null;
                d.clID = p.clID ? p.clID : null;
                d.clName = p.clName ? p.clName : null;
            } else {
                d.SIP = p.SIP ? p.SIP : null;
                d.emID = p.emID ? p.emID : null;
                d.emName = p.emName ? p.emName : null;
                d.clID = p.clID ? p.clID : null;
                d.clName = p.clName ? p.clName : null;
            }
        }
    }
}
class Insert extends Model.Post {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.Aid                   = p.Aid                 ?   p.Aid               : null;
        d.dcID                  = p.dcID                ?   p.dcID              : null;
        d.ccName                = p.ccName              ?   p.ccName            : null;
        d.ccID                  = p.ccID                ?   p.ccID              : null;
        d.IsOut                 = p.IsOut               ?   p.IsOut             : null;
        d.disposition           = p.disposition         ?   p.disposition       : null;
        d.clID                  = p.clID                ?   p.clID              : null;
        d.SIP                   = p.SIP                 ?   p.SIP               : null;
        d.emID                  = p.emID                ?   p.emID              : null;
        d.LinkFile              = p.LinkFile            ?   p.LinkFile          : null;
        d.duration              = p.duration            ?   p.duration          : null;
        d.billsec               = p.billsec             ?   p.billsec           : null;
        d.holdtime              = p.holdtime            ?   p.holdtime          : null;
        d.channel               = p.channel             ?   p.channel           : null;
        d.isAutocall            = p.isAutocall          ?   p.isAutocall        : null;
        d.CauseCode             = p.CauseCode           ?   p.CauseCode         : null;
        d.CauseDesc             = p.CauseDesc           ?   p.CauseDesc         : null;
        d.CauseWho              = p.CauseWho            ?   p.CauseWho          : null;
        d.CallType              = p.CallType            ?   p.CallType          : null;
        d.id_autodial           = p.id_autodial         ?   p.id_autodial       : null;
        d.id_scenario           = p.id_scenario         ?   p.id_scenario       : null;
        d.ffID                  = p.ffID                ?   p.ffID              : null;
        d.target                = p.target              ?   p.target            : null;
        d.coID                  = p.coID                ?   p.coID              : null;
        d.destination           = p.destination         ?   p.destination       : null;
        d.destdata              = p.destdata            ?   p.destdata          : null;
        d.destdata2             = p.destdata2           ?   p.destdata2         : null;
        d.transferFrom          = p.transferFrom        ?   p.transferFrom.filter(x => x).join()              : '';
        d.transferTo            = p.transferTo          ?   p.transferTo.filter(x => x).join()              : '';
        d.isActive              = checkType(p.isActive) ?   Boolean(p.isActive) : null;
    }
}
class Update extends Model.Post {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.dcID                  = p.dcID                ?   p.dcID          : null;
        d.ccName                = p.ccName              ?   p.ccName        : null;
        d.ccID                  = p.ccID                ?   p.ccID          : null;
        d.IsOut                 = p.IsOut               ?   p.IsOut         : null;
        d.disposition           = p.disposition         ?   p.disposition   : null;
        d.clID                  = p.clID                ?   p.clID          : null;
        d.SIP                   = p.SIP                 ?   p.SIP           : null;
        d.emID                  = p.emID                ?   p.emID              : null;
        d.LinkFile              = p.LinkFile            ?   p.LinkFile      : null;
        d.duration              = p.duration            ?   p.duration      : null;
        d.billsec               = p.billsec             ?   p.billsec       : null;
        d.holdtime              = p.holdtime            ?   p.holdtime      : null;
        d.channel               = p.channel             ?   p.channel       : null;
        d.isAutocall            = p.isAutocall          ?   p.isAutocall    : null;
        d.CauseCode             = p.CauseCode           ?   p.CauseCode     : null;
        d.CauseDesc             = p.CauseDesc           ?   p.CauseDesc     : null;
        d.CauseWho              = p.CauseWho            ?   p.CauseWho      : null;
        d.CallType              = p.CallType            ?   p.CallType      : null;
        d.id_autodial           = p.id_autodial         ?   p.id_autodial   : null;
        d.id_scenario           = p.id_scenario         ?   p.id_scenario   : null;
        d.ffID                  = p.ffID                ?   p.ffID          : null;
        d.target                = p.target              ?   p.target          : null;
        d.coID                  = p.coID                ?   p.coID              : null;
        d.destination           = p.destination         ?   p.destination       : null;
        d.destdata              = p.destdata            ?   p.destdata          : null;
        d.destdata2             = p.destdata2           ?   p.destdata2         : null;
        d.transferFrom          = p.transferFrom        ?   p.transferFrom.filter(x => x).join()              : '';
        d.transferTo            = p.transferTo          ?   p.transferTo.filter(x => x).join()              : '';
        d.Comment               = p.Comment             ?   p.Comment         : null;
        d.ContactStatus         = p.ContactStatus       ?   p.ContactStatus         : null;
        d.isAsterisk              = checkType(p.isAsterisk) ?   Boolean(p.isAsterisk) : null;
        d.isActive              = checkType(p.isActive) ?   Boolean(p.isActive) : null;
    }
}

class dailyHourIn extends Model.Get {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.DateFrom   = p.DateFrom;
        d.DateTo   = p.DateTo;
        d.emIDs                         = p.emIDs                   ?   p.emIDs.filter(x => x).join()              : '';
        d.channels                         = p.channels                   ?   p.channels.filter(x => x).join()              : '';
        d.IsOut              = checkType(p.IsOut) ?   Boolean(p.IsOut) : null;
        d.CallTypes                         = p.CallTypes                   ?   p.CallTypes.filter(x => x).join()              : '';
        d.ffIDs                         = p.ffIDs                   ?   p.ffIDs.filter(x => x).join()              : '';
        d.ContactStatuses                         = p.ContactStatuses                   ?   p.ContactStatuses.filter(x => x).join()              : '';
        d.coIDs                         = p.coIDs                   ?   p.coIDs.filter(x => x).join()              : '';
        d.clIDs                         = p.clIDs                   ?   p.clIDs.filter(x => x).join()              : '';
        d.ManagerIDs                         = p.ManagerIDs                   ?   p.ManagerIDs.filter(x => x).join()              : '';
        d.targets                         = p.targets                   ?   p.targets.filter(x => x).join()              : '';
    }
}
class dailyHour extends Model.Get {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.Period   = p.Period.toISOString()./*replace(/T/, ' ').*/replace(/\..+/, '') ;
        d.hourPeriod   = p.hourPeriod;
        d.CallsCount   = p.CallsCount;
        d.ReceivedBefore20sec   = p.ReceivedBefore20sec;
        d.ReceivedBefore20secPercent   = p.ReceivedBefore20secPercent;
        d.ReceivedBefore30sec   = p.ReceivedBefore30sec;
        d.ReceivedBefore30secPercent   = p.ReceivedBefore30secPercent;
        d.ReceivedBefore60sec   = p.ReceivedBefore60sec;
        d.ReceivedBefore60secPercent   = p.ReceivedBefore60secPercent;
        d.ReceivedAfter60sec   = p.ReceivedAfter60sec;
        d.ReceivedAfter60secPercent   = p.ReceivedAfter60secPercent;
        d.ReceivedCalls   = p.ReceivedCalls;
        d.LostBefore20sec   = p.LostBefore20sec;
        d.LostBefore20secPercent   = p.LostBefore20secPercent;
        d.LostBefore30sec   = p.LostBefore30sec;
        d.LostBefore30secPercent   = p.LostBefore30secPercent;
        d.LostBefore60sec   = p.LostBefore60sec;
        d.LostBefore60secPercent   = p.LostBefore60secPercent;
        d.LostAfter60sec   = p.LostAfter60sec;
        d.LostAfter60secPercent   = p.LostAfter60secPercent;
        d.LostCalls   = p.LostCalls;
        d.AHT   = p.AHT;
        d.SL   = p.SL;
    }
}
class dailyReport extends Model.Get {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.Period   = p.Period.toISOString().replace(/\..+/, '').replace('T00:00:00', '');
        d.hourPeriod   = p.hourPeriod;
        d.CallsCount   = p.CallsCount;
        d.LostBefore5sec   = p.LostBefore5sec;
        d.LostBefore5secPercent   = p.LostBefore5secPercent;
        d.LostBefore30sec   = p.LostBefore30sec;
        d.LostBefore30secPercent   = p.LostBefore30secPercent;
        d.LostAfter30sec   = p.LostAfter30sec;
        d.LostAfter30secPercent   = p.LostAfter30secPercent;
        d.ReceivedCalls   = p.ReceivedCalls;
        d.ReceivedBefore20sec   = p.ReceivedBefore20sec;
        d.ReceivedBefore20secPercent   = p.ReceivedBefore20secPercent;
        d.ReceivedBefore30sec   = p.ReceivedBefore30sec;
        d.ReceivedBefore30secPercent   = p.ReceivedBefore30secPercent;
        d.ReceivedAfter30sec   = p.ReceivedAfter30sec;
        d.ReceivedAfter30secPercent   = p.ReceivedAfter30secPercent;
        d.LostAfter60sec   = p.LostAfter60sec;
        d.LostAfter60secPercent   = p.LostAfter60secPercent;
        d.LostCalls   = p.LostCalls;
        d.AHT   = p.AHT;
        d.SL   = p.SL;
        d.LCR   = p.LCR;
        d.ATT   = p.ATT;
        d.HT   = p.HT;
        d.Recalls   = p.Recalls;
        d.RLCR   = p.RLCR;
    }
}
class dailyStatusesIn extends Model.Get {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.DateFrom   = p.DateFrom;
        d.DateTo   = p.DateTo;
        d.emIDs                         = p.emIDs                   ?   p.emIDs.filter(x => x).join()              : '';
        d.channels                         = p.channels                   ?   p.channels.filter(x => x).join()              : '';
        d.IsOut              = checkType(p.IsOut) ?   Boolean(p.IsOut) : null;
        d.CallTypes                         = p.CallTypes                   ?   p.CallTypes.filter(x => x).join()              : '';
        d.ffIDs                         = p.ffIDs                   ?   p.ffIDs.filter(x => x).join()              : '';
        d.ContactStatuses                         = p.ContactStatuses                   ?   p.ContactStatuses.filter(x => x).join()              : '';
        d.coIDs                         = p.coIDs                   ?   p.coIDs.filter(x => x).join()              : '';
        d.clIDs                         = p.clIDs                   ?   p.clIDs.filter(x => x).join()              : '';
        d.ManagerIDs                         = p.ManagerIDs                   ?   p.ManagerIDs.filter(x => x).join()              : '';
        d.targets                         = p.targets                   ?   p.targets.filter(x => x).join()              : '';
    }
}

class dailyStatuses extends Model.Get {
    constructor(p) {

        super(p);
    }
}
class dailyReportIn extends Model.Get {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.DateFrom   = p.DateFrom;
        d.DateTo   = p.DateTo;
        d.emIDs                         = p.emIDs                   ?   p.emIDs.filter(x => x).join()              : '';
        d.channels                         = p.channels                   ?   p.channels.filter(x => x).join()              : '';
        d.IsOut              = checkType(p.IsOut) ?   Boolean(p.IsOut) : null;
        d.CallTypes                         = p.CallTypes                   ?   p.CallTypes.filter(x => x).join()              : '';
        d.ffIDs                         = p.ffIDs                   ?   p.ffIDs.filter(x => x).join()              : '';
        d.ContactStatuses                         = p.ContactStatuses                   ?   p.ContactStatuses.filter(x => x).join()              : '';
        d.coIDs                         = p.coIDs                   ?   p.coIDs.filter(x => x).join()              : '';
        d.clIDs                         = p.clIDs                   ?   p.clIDs.filter(x => x).join()              : '';
        d.ManagerIDs                         = p.ManagerIDs                   ?   p.ManagerIDs.filter(x => x).join()              : '';
        d.targets                         = p.targets                   ?   p.targets.filter(x => x).join()              : '';
        d.step   = p.step ? p.step : 0;
    }
}
class dailyCallsIn extends Model.Get {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.DateFrom   = p.DateFrom;
        d.DateTo   = p.DateTo;
        d.dcIDs                         = p.dcIDs                   ?   p.dcIDs.filter(x => x).join()              : '';
        d.emIDs                         = p.emIDs                   ?   p.emIDs.filter(x => x).join()              : '';
        d.dcStatuss                     = p.dcStatuss               ?   p.dcStatuss.filter(x => x).join()          : '';
        d.ffIDs                         = p.ffIDs                   ?   p.ffIDs.filter(x => x).join()              : '';
        d.isMissed   = p.isMissed;
        d.isUnique   = p.isUnique;
        d.offset   = p.offset;
        d.limit   = p.limit;
        d.CallTypes                      = p.CallTypes                ?   p.CallTypes.filter(x => x).join()              : '';
        d.ccNames                      = p.ccNames                ?   p.ccNames.filter(x => x).join()              : '';
        d.channels                      = p.channels                ?   p.channels.filter(x => x).join()              : '';
        d.comparison            = p.comparison;
        d.billsec               = p.billsec;
        d.clIDs                 = p.clIDs              ?   p.clIDs.filter(x => x).join()              : '';
        d.IsOut                 = p.IsOut === 'null'   ?   false : p.IsOut ;
        d.id_autodials          = p.id_autodials       ?   p.id_autodials.filter(x => x).join()              : '';
        d.id_scenarios          = p.id_scenarios       ?   p.id_scenarios.filter(x => x).join()              : '';
        d.ManageIDs             = p.ManageIDs          ?   p.ManageIDs.filter(x => x).join()              : '';
        d.target                = p.target             ?   p.target          : null;
        d.coIDs                 = p.coIDs              ?   p.coIDs.filter(x => x).join()              : '';
        d.destination           = p.destination        ?   p.destination       : null;
        d.destdata              = p.destdata           ?   p.destdata          : null;
        d.destdata2             = p.destdata2          ?   p.destdata2         : null;
        d.ContactStatuses             = p.ContactStatuses          ?   p.ContactStatuses         : null;
    }
}
class dailyCalls extends Model.Get {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.Created   = p.Created.toISOString().replace(/\..+/, '').replace('T00:00:00', '');
        d.duration   = p.duration;
        d.billsec   = p.billsec;
        d.serviceLevel   = p.serviceLevel;
        d.ccName   = p.ccName;
        d.emID   = p.emID;
        d.emName   = p.emName;
        d.ContactStatus   = p.ContactStatus;
        d.ContactStatusName   = p.ContactStatusName;
        d.Comment   = p.Comment;
        d.adsName   = p.adsName;
        d.isActive              = p.isActive                ?   checkType(p.isActive[0])    ?   Boolean(p.isActive[0]) : false : null;
    }
}

const model = new ccContactModel();
module.exports = model;
