/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');
class astSippeersModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find : `ast_GetSippeers`,
            Insert: `ast_InsSippeers`,
            Update: `ast_UpdSippeers`,
            Delete: `ast_DelSippeers`,
        };
        super(storedProc);

        this.Insert     = Insert;
        this.Update     = Update;
        this.FindPost   = FindPost;
        this.FindPostIn   = FindPostIn;
    }
}
class FindPostIn extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.sipID = p.sipID;
        d.sipName = p.sipName;
        d.template = p.template;
        d.secret = p.secret;
        d.context = p.context;
        d.callgroup = p.callgroup;
        d.pickupgroup = p.pickupgroup;
        d.callerid = p.callerid;
        d.nat = p.nat;
        d.lines = p.lines;
        d.dtmfmode = p.dtmfmode;
        d.emID = p.emID;
        d.transport              = p.transport           ? checkType(p.transport)    ?   p.transport.filter(x => x).join()  : false : null;
        d.encryption              = p.encryption                ? checkType(p.encryption)    ?   Boolean(p.encryption) : false : null;
        d.avpf              = p.avpf                ? checkType(p.avpf)    ?   Boolean(p.avpf) : false : null;
        d.force_avp              = p.force_avp                ? checkType(p.force_avp)    ?   Boolean(p.force_avp) : false : null;
        d.icesupport              = p.icesupport                ? checkType(p.icesupport)    ?   Boolean(p.icesupport) : false : null;
        d.videosupport              = p.videosupport                ? checkType(p.videosupport)    ?   Boolean(p.videosupport) : false : null;
        d.allow              = p.allow           ? checkType(p.allow)    ?   p.allow.filter(x => x).join()  : false : null;
        d.dtlsenable              = p.dtlsenable                ? checkType(p.dtlsenable)    ?   Boolean(p.dtlsenable) : false : null;
        d.dtlsverify              = p.dtlsverify                ? checkType(p.dtlsverify)    ?   Boolean(p.dtlsverify) : false : null;
        d.dtlscertfile                      = p.dtlscertfile;
        d.dtlscafile                      = p.dtlscafile;
        d.dtlssetup                      = p.dtlssetup;
        d.sipLogin = p.sipLogin;
        d.sipPass = p.sipPass;
        d.isPrimary              = p.isPrimary                ? checkType(p.isPrimary)    ?   Boolean(p.isPrimary) : false : null;
        d.sipType = p.sipType;
        d.isActive                     = checkType(p.isActive)   ?   Boolean(p.isActive) : null;
    }
}

class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.sipID = p.sipID;
        d.sipName = p.sipName;
        d.template = p.template;
        d.secret = p.secret;
        d.context = p.context;
        d.callgroup = p.callgroup;
        d.pickupgroup = p.pickupgroup;
        d.callerid = p.callerid;
        d.nat = p.nat;
        d.lines = p.lines;
        d.dtmfmode = p.dtmfmode;
        d.emID = p.emID;
        d.transport                     = p.transport ;
        d.encryption              = p.encryption                ? checkType(p.encryption[0])    ?   Boolean(p.encryption[0]) : false : null;
        d.avpf              = p.avpf                ? checkType(p.avpf[0])    ?   Boolean(p.avpf[0]) : false : null;
        d.force_avp              = p.force_avp                ? checkType(p.force_avp[0])    ?   Boolean(p.force_avp[0]) : false : null;
        d.icesupport              = p.icesupport                ? checkType(p.icesupport[0])    ?   Boolean(p.icesupport[0]) : false : null;
        d.videosupport              = p.videosupport                ? checkType(p.videosupport[0])    ?   Boolean(p.videosupport[0]) : false : null;
        d.allow                     = p.allow;
        d.dtlsenable              = p.dtlsenable                ? checkType(p.dtlsenable[0])    ?   Boolean(p.dtlsenable[0]) : false : null;
        d.dtlsverify              = p.dtlsverify                ? checkType(p.dtlsverify[0])    ?   Boolean(p.dtlsverify[0]) : false : null;
        d.dtlscertfile                      = p.dtlscertfile;
        d.dtlscafile                      = p.dtlscafile;
        d.dtlssetup                      = p.dtlssetup;
        d.sipLogin = p.sipLogin;
        d.sipPass = p.sipPass;
        d.isPrimary              = p.isPrimary                ? checkType(p.isPrimary[0])    ?   Boolean(p.isPrimary[0]) : false : null;
        d.sipType = p.sipType;
        d.isActive              = p.isActive                ? checkType(p.isActive[0])    ?   Boolean(p.isActive[0]) : false : null;
        d.Created               = p.Created                 ?   p.Created.toISOString().replace(/\..+/, '')                             : null;
        d.Changed               = p.Changed                 ?   p.Changed.toISOString().replace(/\..+/, '')                             : null;
    }
}

class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token             = p.token;
        d.sipID             = p.sipID;
        d.sipName           = p.sipName;
        d.template          = p.template;
        d.secret            = p.secret;
        d.context           = p.context;
        d.callgroup         = p.callgroup;
        d.pickupgroup       = p.pickupgroup;
        d.callerid          = p.callerid;
        d.nat               = p.nat;
        d.lines             = p.lines;
        d.dtmfmode          = p.dtmfmode;
        d.emID              = p.emID;
        d.transport         = (p.transport   !== undefined && p.transport   !== null )           ?   p.transport.filter(x => x).join()                                 : null;
        d.encryption        = checkType(p.encryption)           ? Boolean(p.encryption)   :  null;
        d.avpf              = p.avpf                            ? checkType(p.avpf)          ?   Boolean(p.avpf) : false : null;
        d.force_avp         = p.force_avp                       ? checkType(p.force_avp)     ?   Boolean(p.force_avp) : false : null;
        d.icesupport        = p.icesupport                      ? checkType(p.icesupport)    ?   Boolean(p.icesupport) : false : null;
        d.videosupport      = p.videosupport                    ? checkType(p.videosupport)  ?   Boolean(p.videosupport) : false : null;
        d.allow             = (p.allow   !== undefined && p.allow   !== null )                  ?   p.allow.filter(x => x).join()                                 : null;
        d.dtlsenable        = p.dtlsenable                      ? checkType(p.dtlsenable)    ?   Boolean(p.dtlsenable) : false : null;
        d.dtlsverify        = p.dtlsverify                      ? checkType(p.dtlsverify)    ?   Boolean(p.dtlsverify) : false : null;
        d.dtlscertfile      = p.dtlscertfile;
        d.dtlscafile        = p.dtlscafile;
        d.dtlssetup         = p.dtlssetup;
        d.isPrimary              = p.isPrimary                ? checkType(p.isPrimary)    ?   Boolean(p.isPrimary) : false : null;
        d.sipType = p.sipType;
        d.isActive          = checkType(p.isActive)             ?   Boolean(p.isActive)                     : null;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID              = p.HIID;
        d.token             = p.token;
        d.sipID             = p.sipID;
        d.sipName           = p.sipName;
        d.template          = p.template;
        d.secret            = p.secret;
        d.context           = p.context;
        d.callgroup         = p.callgroup;
        d.pickupgroup       = p.pickupgroup;
        d.callerid          = p.callerid;
        d.nat               = p.nat;
        d.lines             = p.lines;
        d.dtmfmode          = p.dtmfmode;
        d.emID              = p.emID;
        d.transport         = (p.transport   !== undefined && p.transport   !== null )      ?   p.transport.filter(x => x).join()   : null;
        d.encryption        = checkType(p.encryption)           ? Boolean(p.encryption)   :  null;
        d.avpf              = p.avpf                            ? checkType(p.avpf)          ?   Boolean(p.avpf) : false : null;
        d.force_avp         = p.force_avp                       ? checkType(p.force_avp)     ?   Boolean(p.force_avp) : false : null;
        d.icesupport        = p.icesupport                      ? checkType(p.icesupport)    ?   Boolean(p.icesupport) : false : null;
        d.videosupport      = p.videosupport                    ? checkType(p.videosupport)  ?   Boolean(p.videosupport) : false : null;
        d.allow             = (p.allow   !== undefined && p.allow   !== null )                  ?   p.allow.filter(x => x).join()                                 : null;
        d.dtlsenable        = p.dtlsenable                      ? checkType(p.dtlsenable)    ?   Boolean(p.dtlsenable) : false : null;
        d.dtlsverify        = p.dtlsverify                      ? checkType(p.dtlsverify)    ?   Boolean(p.dtlsverify) : false : null;
        d.dtlscertfile      = p.dtlscertfile;
        d.dtlscafile        = p.dtlscafile;
        d.dtlssetup         = p.dtlssetup;
        d.isPrimary         = p.isPrimary                ? checkType(p.isPrimary)    ?   Boolean(p.isPrimary) : false : null;
        d.sipType = p.sipType;
        d.isActive          = checkType(p.isActive)         ?   Boolean(p.isActive)                                                 : null;
    }
}

const model = new astSippeersModel();
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