/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');
class crmClientModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find: 'crm_GetClient',
            Insert: 'crm_InsClient',
            Update: 'crm_UpdClient',
            Delete: 'crm_DelClient',
            FindSum: 'crm_GetFindClientSummary',
            GetByContact: 'crm_GetClientByContact',
            GetByPhone: 'crm_GetClientByPhone',
            GetIPClient: 'crm_GetIPClient',
            GetByName: 'crm_GetClientByName',
            Search: 'crm_GetSearchClient',
            FindStream: 'crm_GetClientStream',
            FindByParent: 'crm_GetClientByParent',
            SetActual: 'crm_SetActualClient',
            FindSabd: 'crm_GetClientSabd',
            UpdSabd: 'crm_UpdClientSabd',
            CheckPhone: 'crm_CheckSabdClientRobocall',
            GetSave: 'crm_GetSaveClient',
            InsSave: 'crm_InsSaveClient',
            UpdSave: 'crm_UpdSaveClient',
            BulkDelete: 'crm_BulkDelClient'
        };
        super(storedProc);

        this.FindPost = FindPost;
        this.FindPostIn = FindPostIn;
        this.Insert = Insert;
        this.Update = Update;
        this.FindSum = FindSum;
        this.GetByContact = GetByContact;
        this.GetByPhone = GetByPhone;
        this.Autocall = Autocall;
        this.GetByName = GetByName;
        this.GetIPClient = GetIPClient;
        this.FindStream = FindStream;
        this.Search = Search;
        this.FindByParent = FindByParent;
        this.SetActual = SetActual;
        this.FindSabd = FindSabd;
        this.UpdSabd = UpdSabd;
        this.GetSave = GetSave;
        this.InsSave = InsSave;
        this.UpdSave = UpdSave;
        this.BulkDelete = BulkDelete;
    }

    repoSetActual(params, callback) {
        this.execute(this.StoredProc.SetActual, params, callback);
    }
    repoGetByContact(params, callback) {
        this.execute(this.StoredProc.GetByContact, params, callback);
    }
    repoGetByPhone(params, callback) {
        this.execute(this.StoredProc.GetByPhone, params, callback);
    }
    repoGetIPClient(params, callback) {
        this.execute(this.StoredProc.GetIPClient, params, callback);
    }
    repoFindByParent(params, callback) {
        this.execute(this.StoredProc.FindByParent, params, callback);
    }
    repoUpdSabd(params, callback) {
        this.execute(this.StoredProc.UpdSabd, params, callback);
    }
    repoFindSabd(params, callback) {
        this.execute(this.StoredProc.FindSabd, params, callback);
    }
    repoInsSave(params, callback) {
        this.execute(this.StoredProc.InsSave, params, callback);
    }
    repoGetSave(params, callback) {
        this.execute(this.StoredProc.GetSave, params, callback);
    }
    repoUpdSave(params, callback) {
        this.execute(this.StoredProc.UpdSave, params, callback);
    }
    repoFindStream(params, callback) {
        this.execute(this.StoredProc.FindStream, params, callback);
    }
    repoFindSum(params, callback) {
        this.execute(this.StoredProc.FindSum, params, callback);
    }
    repoSearch(params, callback) {
        this.execute(this.StoredProc.Search, params, callback);
    }
    repoGetByName(params, callback) {
        this.execute(this.StoredProc.GetByName, params, callback);
    }
    repoBulkDelete(params, callback) {
        this.execute(this.StoredProc.BulkDelete, params, callback);
    }
}

class FindPostIn extends Model.Get {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.clID = p.clID;
        d.clName = p.clName;
        d.IsPerson                         = p.IsPerson;
        d.ffID = p.ffID;
        d.CompanyIDs                     = p.CompanyIDs               ?   p.CompanyIDs.filter(x => x).join()          : null;
        d.emID = p.emID;
        d.tagID = p.tagID;
        d.clStatus = p.clStatus;
        d.ccStatus = p.ccStatus;
        d.CallDate = p.CallDate;
        d.CallDateTo = p.CallDateTo;
        d.cID = p.cID;
        d.dctID = p.dctID;
        d.isActive                         = p.isActive;
        d.sorting = p.sorting;
        d.field = p.field;
        d.offset = p.offset;
        d.limit = p.limit;
    }
}
class FindPost extends Model.Get {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.HIID = Number(p.HIID);
        d.clID = Number(p.clID);
        d.clName = String(p.clName);
        d.IsPerson                        = p.IsPerson         ? checkType(p.IsPerson[0])    ?   Boolean(p.IsPerson[0]) : false : null;
        d.Sex = p.Sex;
        d.isActive = Boolean(p.isActive[0]);
        d.Comment = p.Comment;
        d.emID = p.emID;
        d.emName = p.emName;
        d.tagName = p.tagName;
        d.cusID = p.cusID;
        d.clStatus = Number(p.clStatus);
        d.ccStatus = Number(p.ccStatus);
        d.isFixed = Boolean(p.isFixed[0]);
        d.ffID = p.ffID;
        d.ParentID = p.ParentID;
        d.CallDate = p.CallDate ? p.CallDate.toISOString()./*replace(/T/, ' ').*/replace(/\..+/, '') : null;
        d.Created = p.Created ? p.Created.toISOString()./*replace(/T/, ' ').*/replace(/\..+/, '') : null;
        d.Changed = p.Changed ? p.Changed.toISOString()./*replace(/T/, ' ').*/replace(/\..+/, '') : null;
        d.Phone = p.Phone;
        d.Email = p.Email;
        d.rpID = p.rpID;
        d.GMT = p.GMT;
        d.ccQty = Number(p.ccQty);
        d.CompanyID = p.CompanyID;
        d.ActualStatus = p.ActualStatus;
        d.isNotice                        = p.isNotice         ? checkType(p.isNotice[0])    ?   Boolean(p.isNotice[0]) : false : null;
        d.isDial                        = p.isDial         ? checkType(p.isDial[0])    ?   Boolean(p.isDial[0]) : false : null;
    }
}
class Insert extends Model.Post {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.token = p.token;
        d.clID = p.clID;
        d.clName = p.clName;
        d.IsPerson = p.IsPerson;
        d.Sex = p.Sex;
        d.Comment = p.Comment;
        d.ffID = p.ffID;
        d.ParentID = p.ParentID;
        d.CompanyID = p.CompanyID;
        d.isActual = p.isActual;
        d.responsibleID = p.responsibleID;
        d.ActualStatus = p.ActualStatus;
        d.Position = p.Position ? p.Position : null;
        d.isActive = p.isActive;
        d.emIDEditor = p.emIDEditor;
        d.host = p.host;
    }
}
class Update extends Model.Put {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.token = p.token;
        d.clID = p.clID;
        d.clName = p.clName;
        d.IsPerson = p.IsPerson;
        d.Sex = p.Sex;
        d.Comment = p.Comment;
        d.ffID = p.ffID;
        d.ParentID = p.ParentID;
        d.CompanyID = p.CompanyID;
        d.isActual = p.isActual ? p.isActual : null;
        d.responsibleID = p.responsibleID;
        d.ActualStatus = p.ActualStatus;
        d.Position = p.Position ? p.Position : null;
        d.isActive = p.isActive;
        d.emIDEditor = p.emIDEditor;
        d.host = p.host;
    }
}
class FindSum extends Model.Get {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.FilterID = p.FilterID;
        d.FilterName = p.FilterName;
        d.Name = p.Name;
        d.Qty = p.Qty;
    }
}
class GetByContact extends Model.Get {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.clID = p.clID;
        d.clName = p.clName;
        d.ParentID = p.ParentID;
        d.ParentName = p.ParentName;
        d.ffID = p.ffID;
        d.ffName = p.ffName;
        d.Comment = p.Comment;
        d.Created = p.Created;
    }
}
class GetByPhone extends Model.Get {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.clID = p.clID;
        d.clName = p.clName;
        d.ParentID = p.ParentID;
        d.ParentName = p.ParentName;
        d.ffID = p.ffID;
        d.ffName = p.ffName;
        d.Created = p.Created;
    }
}
class GetIPClient extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.clName = p.clName;
    }
}
class GetByName extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.clName = p.clName;
    }
}
class Search extends Model.Get {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.token = p.token;
        d.clID = p.clID;
        d.clName = p.clName;
        d.IsPerson = p.IsPerson[0];
        d.isActive = Boolean(p.isActive[0]);
        d.Comment = p.Comment;
        d.Contacts = p.Contacts ? p.Contacts.split(',').map(String) : null;
        d.Responsibles = p.Responsibles ? p.Responsibles : null;
    }
}
class FindByParent extends Model.Get {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.clID = p.clID;
        d.clName = p.clName;
        d.IsPerson = Boolean(p.IsPerson);
        d.isActive = Boolean(p.isActive[0]);
        d.Comment = p.Comment;
        d.Position = p.Position;
        d.Contacts = p.Contacts ? p.Contacts.split(',').map(String) : null;
        d.Responsibles = p.Responsibles ? p.Responsibles : null;
        d.Addresses = p.Addresses ? p.Addresses.split(',').map(String) : null;
    }
}
class Autocall extends Model.Get {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.clID = p.clID;
        d.clName = p.clName;
        d.ccID = p.ccID;
        d.phone = p.ccName;
    }
}
class FindStream extends Model.Get {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.dup_action = p.dup_action;
        d.clID = p.clID;
        d.clName = p.clName;
        d.isPerson = Boolean(p.isPerson[0]);
        d.isActive = Boolean(p.isActive[0]);
        d.Comment = p.Comment;
        d.ffID = p.ffID;
        d.ParentID = p.OLD_ParentID;
        d.OLD_clName = p.OLD_clName;
        d.OLD_isPerson = p.OLD_isPerson ? Boolean(p.OLD_isPerson[0]) : p.OLD_isPerson;
        d.OLD_isActive = p.OLD_isActive ? Boolean(p.OLD_isActive[0]) : p.OLD_isActive;
        d.OLD_Comment = p.OLD_Comment;
        d.OLD_ffID = p.OLD_ffID;
        d.OLD_ParentID = p.OLD_ParentID;
    }
}
class SetActual extends Model.Put {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.clID = p.clID;
    }
}
class FindSabd extends Model.Get {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.HIID = p.HIID;
        d.clID = p.clID;
        d.inn = p.inn;
        d.nameFull = p.nameFull;
        d.nameShort = p.nameShort;
        d.adress = p.adress;
        d.fio = p.fio;
        d.io = p.io;
        d.post = p.post;
        d.sex = p.sex;
        d.famIO = p.famIO;
        d.kvedCode = p.kvedCode;
        d.kvedDescr = p.kvedDescr;
        d.orgNote = p.orgNote;
        d.isNotice                                  = checkType(p.isNotice[0])         ? Boolean(p.isNotice[0])               : false;
        d.callDate                                  = p.callDate                    ? toJSONLocal(d.callDate, true)     : d.callDate;
        d.email = p.email;
        d.actualStatus = p.actualStatus;
        d.phoneDialer = p.phoneDialer;
        d.phoneComment = p.phoneComment;
        d.phones                                    = p.phones                      ? JSON.parse(p.phones)              : null;
        d.dbPrefix = p.dbPrefix;
    };
}

class UpdSabd extends Model.Put {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.HIID = p.HIID;
        d.clID = p.clID;
        d.inn = p.inn;
        d.nameFull = p.nameFull;
        d.nameShort = p.nameShort;
        d.adress = p.adress;
        d.fio = p.fio;
        d.io = p.io;
        d.post = p.post;
        d.sex = p.sex;
        d.famIO = p.famIO;
        d.kvedCode = p.kvedCode;
        d.kvedDescr = p.kvedDescr;
        d.orgNote = p.orgNote;
        d.isNotice = p.isNotice;
        d.callDate = p.callDate;
        d.email = p.email;
        d.actualStatus = p.actualStatus;
        d.phoneDialer = p.phoneDialer;
        d.phoneComment = p.phoneComment ? p.phoneComment : null;
        d.phones = p.phones ? JSON.stringify({ data: p.phones }) : null;
    }
}
class GetSave extends Model.Get {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.HIID = p.HIID;
        d.clID = p.clID;
        d.clName = p.clName;
        d.IsPerson                                  = checkType(p.IsPerson)         ? Boolean(p.IsPerson)               : false;
        d.IsActive = p.IsActive ? checkType(p.IsActive[0]) ? Boolean(p.IsActive[0]) : false : null;
        d.Comment = p.Comment;
        d.ffID = p.ffID;
        d.ParentID = p.ParentID;
        d.CompanyID = p.CompanyID;
        d.Position = p.Position;
        d.TaxCode = p.TaxCode;
        d.address = p.address;
        d.contacts = p.contacts ? JSON.parse(p.contacts) : null;
    }
}
class InsSave extends Model.Post {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.token = p.token;
        d.clID = p.clID;
        d.clName = p.clName;
        d.IsPerson = p.IsPerson;
        d.isActive = p.isActive;
        d.Comment = p.Comment;
        d.ffID = p.ffID;
        d.ParentID = p.ParentID;
        d.CompanyID = p.CompanyID;
        d.Position = p.Position ? p.Position : null;
        d.TaxCode = p.TaxCode ? p.TaxCode : null;
        d.address = p.address ? p.address : null;
        d.contacts = p.contacts ? JSON.stringify({ data: p.contacts }) : null;
        d.emIDEditor = p.emIDEditor;
        d.host = p.host;
    }
}
class UpdSave extends Model.Put {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.token = p.token;
        d.HIID = p.HIID;
        d.clID = p.clID;
        d.clName = p.clName;
        d.IsPerson = p.IsPerson;
        d.isActive = p.isActive;
        d.Comment = p.Comment;
        d.ffID = p.ffID;
        d.ParentID = p.ParentID;
        d.CompanyID = p.CompanyID;
        d.Position = p.Position ? p.Position : null;
        d.TaxCode = p.TaxCode ? p.TaxCode : null;
        d.address = p.address ? p.address : null;
        d.contacts = p.contacts ? JSON.stringify({ data: p.contacts }) : null;
        d.emIDEditor = p.emIDEditor;
        d.host = p.host;
    }
}
class BulkDelete extends Model.Get {
    constructor(p) {

        super(p);
        const d = this.Data;
        d.clIDs                         = p.clIDs                   ?   p.clIDs.filter(x => x).join()              : '';
        d.emIDEditor = p.emIDEditor;
        d.host = p.host;
    }
}

const model = new crmClientModel();
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