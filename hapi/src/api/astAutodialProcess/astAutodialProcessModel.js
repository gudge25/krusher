/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
var BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class astAutodialProcessModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find:   'ast_GetAutodialProcess',
            Insert: 'ast_InsAutodialProcess',
            Update: 'ast_UpdAutodialProcess',
            Delete: 'ast_DelAutodialProcess',
            Autocall: 'cc_AutodialByScenario'
        };
        super(storedProc);

        this.Insert     = Insert;
        this.Update     = Update;
        this.FindPost   = FindPost;
        this.Autocall   = Autocall;
    }

    repoAutocall(params, callback) {
        this.execute(this.StoredProc.Autocall, params, callback);
    }
}
class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID       = p.HIID    !== undefined      ?   p.HIID       : null;
        if(p.Aid    !== undefined)
            d.Aid        = p.Aid    ?   p.Aid       : null;
        d.id_autodial       = p.id_autodial         ?   p.id_autodial       : null;
        d.process           = p.process             ?   p.process           : null;
        d.ffID              = p.ffID                ?   p.ffID              : null;
        d.id_scenario       = p.id_scenario         ?   p.id_scenario       : null;
        d.emID              = p.emID                ?   p.emID              : null;
        d.factor            = p.factor              ?   p.factor            : null;
        d.called            = p.called              ?   p.called            : null;
        d.targetCalls       = p.targetCalls         ?   p.targetCalls       : null;
        d.planDateBegin     = p.planDateBegin       ?   p.planDateBegin.toISOString()/*.replace(/T/, ' ')*/.replace(/\..+/, '')       : null;
        d.errorDescription  = p.errorDescription    ?   p.errorDescription  : null;
        d.description       = p.description         ?   p.description       : null;
        d.Created           = p.Created             ?   p.Created.toISOString()/*.replace(/T/, ' ')*/.replace(/\..+/, '')           : null;
        d.Changed           = p.Changed             ?   p.Changed.toISOString()/*.replace(/T/, ' ')*/.replace(/\..+/, '')           : null;
        d.isActive          = checkType(p.isActive) ?   Boolean(p.isActive) : null;
        d.offset            = p.offset              ?   p.offset            : null;
        d.limit             = p.limit               ?   p.limit             : null;

    }
}
class Autocall extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        /*if (p.length > 0) {
            if (p.clID != null) {*/
                d.clID = p.clID ? p.clID : null;
                d.clName = p.clName ? p.clName : null;
                d.ccID = p.ccID ? p.ccID : null;
                d.phone = p.ccName ? p.ccName : null;
                d.callerID = p.callerID ? p.callerID : null;
                d.SleepTime = p.SleepTime ? p.SleepTime : null;
                d.RecallAfterMin = p.RecallAfterMin ? p.RecallAfterMin : null;
                d.destination = p.destination ? p.destination : null;
                d.destdata = p.destdata ? p.destdata : null;
                d.target = p.target ? p.target : null;
                d.AutoDial = p.AutoDial ? p.AutoDial : null;
                d.ffID = p.ffID ? p.ffID : null;
                d.curID = p.curID ? p.curID : null;
                d.curName = p.curName ? p.curName : null;
                d.langID = p.langID ? p.langID : null;
                d.langName = p.langName ? p.langName : null;
                d.sum = p.sum ? p.sum : null;
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
                d.emName = p.emName ? p.emName : null;
                d.ActDate = p.ActDate ? p.ActDate : null;
                d.cusID = p.cusID ? p.cusID : null;
                d.Account = p.Account ? p.Account : null;
                d.Bank = p.Bank ? p.Bank : null;
                d.TaxCode = p.TaxCode ? p.TaxCode : null;
                d.RegCode = p.RegCode ? p.RegCode : null;
                d.CertNumber = p.CertNumber ? p.CertNumber : null;
                d.SortCode = p.SortCode ? p.SortCode : null;
                d.OrgType = p.OrgType ? p.OrgType : null;
                d.dcID = p.dcID ? p.dcID : null;
           /* }
        }*/
    }
}

class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token       = p.token         ?   p.token       : null;
        d.id_autodial       = p.id_autodial         ?   p.id_autodial       : null;
        d.process           = p.process             ?   p.process           : null;
        d.ffID              = p.ffID                ?   p.ffID              : null;
        d.id_scenario       = p.id_scenario         ?   p.id_scenario       : null;
        d.emID        = p.emID          ?   p.emID        : null;
        d.factor            = p.factor              ?   p.factor            : null;
        d.called            = p.called              ?   p.called            : null;
        d.targetCalls       = p.targetCalls         ?   p.targetCalls       : null;
        d.planDateBegin       = p.planDateBegin         ?   p.planDateBegin       : null;
        d.errorDescription  = p.errorDescription    ?   p.errorDescription  : null;
        d.description       = p.description         ?   p.description       : null;
        d.isActive          = checkType(p.isActive) ?   Boolean(p.isActive) : null;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token       = p.token         ?   p.token       : null;
        d.HIID = p.HIID;
        d.id_autodial       = p.id_autodial         ?   p.id_autodial       : null;
        d.process           = p.process             ?   p.process           : null;
        d.ffID              = p.ffID                ?   p.ffID              : null;
        d.id_scenario       = p.id_scenario         ?   p.id_scenario       : null;
        d.emID              = p.emID                ?   p.emID              : null;
        d.factor            = p.factor              ?   p.factor            : null;
        d.called            = p.called              ?   p.called            : null;
        d.targetCalls       = p.targetCalls         ?   p.targetCalls       : null;
        d.planDateBegin     = p.planDateBegin       ?   p.planDateBegin       : null;
        d.errorDescription  = p.errorDescription    ?   p.errorDescription  : null;
        d.description       = p.description         ?   p.description       : null;
        d.isActive          = checkType(p.isActive) ?   Boolean(p.isActive) : null;
    }
}
const model = new astAutodialProcessModel();
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