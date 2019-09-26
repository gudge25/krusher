/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class astTrunkModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find : `ast_GetTrunk`,
            Insert: `ast_InsTrunk`,
            Update: `ast_UpdTrunk`,
            Delete: `ast_DelTrunk`,
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
        d.trID = p.trID;
        d.trName = p.trName;
        d.template = p.template;
        d.secret = p.secret;
        d.context = p.context;
        d.callgroup = p.callgroup;
        d.pickupgroup = p.pickupgroup;
        d.callerid = p.callerid;
        d.host = p.host;
        d.nat = p.nat;
        d.defaultuser = p.defaultuser;
        d.fromuser = p.fromuser;
        d.fromdomain = p.fromdomain;
        d.callbackextension = p.callbackextension;
        d.port = p.port;
        d.isServer                         = p.isServer         ? checkType(p.isServer[0])    ?   Boolean(p.isServer[0]) : false : null;
        d.type = p.type;
        d.directmedia = p.directmedia;
        d.insecure = p.insecure;
        d.outboundproxy = p.outboundproxy;
        d.acl = p.acl;
        d.dtmfmode = p.dtmfmode;
        d.lines = p.lines;
        d.DIDs             = p.DIDs                       ?   p.DIDs.toString()              : null;
        d.ManageID = p.ManageID;
        d.coID = p.coID;
        //d.transport                     = p.transport   !== undefined            ?   p.transport.filter(x => x).join()                                 : null;
        d.transport              = p.transport           ? checkType(p.transport[0])    ?   p.transport.filter(x => x).join()  : false : null;
        d.encryption              = p.encryption                ? checkType(p.encryption[0])    ?   Boolean(p.encryption[0]) : false : null;
        d.avpf              = p.avpf                ? checkType(p.avpf[0])    ?   Boolean(p.avpf[0]) : false : null;
        d.force_avp              = p.force_avp                ? checkType(p.force_avp[0])    ?   Boolean(p.force_avp[0]) : false : null;
        d.icesupport              = p.icesupport                ? checkType(p.icesupport[0])    ?   Boolean(p.icesupport[0]) : false : null;
        d.videosupport              = p.videosupport                ? checkType(p.videosupport[0])    ?   Boolean(p.videosupport[0]) : false : null;
        d.allow              = p.allow           ? checkType(p.allow[0])    ?   p.allow.filter(x => x).join()  : false : null;
        d.dtlsenable              = p.dtlsenable                ? checkType(p.dtlsenable[0])    ?   Boolean(p.dtlsenable[0]) : false : null;
        d.dtlsverify              = p.dtlsverify                ? checkType(p.dtlsverify[0])    ?   Boolean(p.dtlsverify[0]) : false : null;
        d.dtlscertfile                      = p.dtlscertfile;
        d.dtlscafile                      = p.dtlscafile;
        d.dtlssetup                      = p.dtlssetup;
        d.isActive                     = checkType(p.isActive)   ?   Boolean(p.isActive) : null;
    }
}
class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.trID = p.trID;
        d.trName = p.trName;
        d.template = p.template;
        d.secret = p.secret;
        d.context = p.context;
        d.callgroup = p.callgroup;
        d.pickupgroup = p.pickupgroup;
        d.callerid = p.callerid;
        d.host = p.host;
        d.nat = p.nat;
        d.defaultuser = p.defaultuser;
        d.fromuser = p.fromuser;
        d.fromdomain = p.fromdomain;
        d.callbackextension = p.callbackextension;
        d.port = p.port;
        d.isServer                         = p.isServer         ? checkType(p.isServer[0])    ?   Boolean(p.isServer[0]) : false : null;
        d.type = p.type;
        d.directmedia = p.directmedia;
        d.insecure = p.insecure;
        d.outboundproxy = p.outboundproxy;
        d.acl = p.acl;
        d.dtmfmode = p.dtmfmode;
        d.lines = p.lines;
        d.DIDs             = p.DIDs                       ?   p.DIDs.toString()              : null;
        d.ManageID = p.ManageID;
        d.coID = p.coID;
        d.transport                     = p.transport;
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
        d.isActive = p.isActive ? checkType(p.isActive[0]) ? Boolean(p.isActive[0]) : false : null;
    }
}

class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token                         = p.token;
        d.trID = p.trID;
        d.trName = p.trName;
        d.template = p.template;
        d.secret = p.secret;
        d.context = p.context;
        d.callgroup = p.callgroup;
        d.pickupgroup = p.pickupgroup;
        d.callerid = p.callerid;
        d.host = p.host;
        d.nat = p.nat;
        d.defaultuser = p.defaultuser;
        d.fromuser = p.fromuser;
        d.fromdomain = p.fromdomain;
        d.callbackextension = p.callbackextension;
        d.port = p.port;
        d.isServer                      = checkType(p.isServer)                         ?   Boolean(p.isServer)                     : null;
        d.type = p.type;
        d.directmedia = p.directmedia;
        d.insecure = p.insecure;
        d.outboundproxy = p.outboundproxy;
        d.acl = p.acl;
        d.dtmfmode = p.dtmfmode;
        d.lines = p.lines;
        d.DIDs                      = p.DIDs   !== undefined               ?   p.DIDs.filter(x => x).join()                                 : null;
        d.ManageID = p.ManageID;
        d.coID = p.coID;
        d.transport                     = p.transport   !== undefined               ?   p.transport.filter(x => x).join()                                 : null;
        d.encryption                      = checkType(p.encryption)                         ?   Boolean(p.encryption)                     : null;
        d.avpf                      = checkType(p.avpf)                         ?   Boolean(p.avpf)                     : null;
        d.force_avp                      = checkType(p.force_avp)                         ?   Boolean(p.force_avp)                     : null;
        d.icesupport                      = checkType(p.icesupport)                         ?   Boolean(p.icesupport)                     : null;
        d.videosupport                      = checkType(p.videosupport)                         ?   Boolean(p.videosupport)                     : null;
        d.allow                     = p.allow   !== undefined               ?   p.allow.filter(x => x).join()                                 : null;
        d.dtlsenable                      = checkType(p.dtlsenable)                         ?   Boolean(p.dtlsenable)                     : null;
        d.dtlsverify                      = checkType(p.dtlsverify)                         ?   Boolean(p.dtlsverify)                     : null;
        d.dtlscertfile                      = p.dtlscertfile;
        d.dtlscafile                      = p.dtlscafile;
        d.dtlssetup                      = p.dtlssetup;
        d.isActive                      = checkType(p.isActive)                         ?   Boolean(p.isActive)                     : null;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token                         = p.token;
        d.HIID = p.HIID;
        d.trID = p.trID;
        d.trName = p.trName;
        d.template = p.template;
        d.secret = p.secret;
        d.context = p.context;
        d.callgroup = p.callgroup;
        d.pickupgroup = p.pickupgroup;
        d.callerid = p.callerid;
        d.host = p.host;
        d.nat = p.nat;
        d.defaultuser = p.defaultuser;
        d.fromuser = p.fromuser;
        d.fromdomain = p.fromdomain;
        d.callbackextension = p.callbackextension;
        d.port = p.port;
        d.isServer                      = checkType(p.isServer)                         ?   Boolean(p.isServer)                     : null;
        d.type = p.type;
        d.directmedia = p.directmedia;
        d.insecure = p.insecure;
        d.outboundproxy = p.outboundproxy;
        d.acl = p.acl;
        d.dtmfmode = p.dtmfmode;
        d.lines = p.lines;
        d.DIDs                     = p.DIDs   !== undefined               ?   p.DIDs.filter(x => x).join()                                 : null;
        d.ManageID = p.ManageID;
        d.coID = p.coID;
        d.transport                     = p.transport   !== undefined               ?   p.transport.filter(x => x).join()                                 : null;
        d.encryption                      = checkType(p.encryption)                         ?   Boolean(p.encryption)                     : null;
        d.avpf                      = checkType(p.avpf)                         ?   Boolean(p.avpf)                     : null;
        d.force_avp                      = checkType(p.force_avp)                         ?   Boolean(p.force_avp)                     : null;
        d.icesupport                      = checkType(p.icesupport)                         ?   Boolean(p.icesupport)                     : null;
        d.videosupport                      = checkType(p.videosupport)                         ?   Boolean(p.videosupport)                     : null;
        d.allow                     = p.allow   !== undefined               ?   p.allow.filter(x => x).join()                                 : null;
        d.dtlsenable                      = checkType(p.dtlsenable)                         ?   Boolean(p.dtlsenable)                     : null;
        d.dtlsverify                      = checkType(p.dtlsverify)                         ?   Boolean(p.dtlsverify)                     : null;
        d.dtlscertfile                      = p.dtlscertfile;
        d.dtlscafile                      = p.dtlscafile;
        d.dtlssetup                      = p.dtlssetup;
        d.isActive                      = checkType(p.isActive)                         ?   Boolean(p.isActive)                     : null;
    }
}

const model = new astTrunkModel();
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