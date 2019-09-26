//BaseModel for Documents DC
class BaseModelSIP extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.transport      = p.transport               ? p.transport               : null ;
        this.encryption     = isBoolean(p.encryption)   ? Boolean(p.encryption)     : null ;
        this.avpf           = isBoolean(p.avpf)         ? Boolean(p.avpf)           : null ;
        this.force_avp      = isBoolean(p.force_avp)    ? Boolean(p.force_avp)      : null ;
        this.icesupport     = isBoolean(p.icesupport)   ? Boolean(p.icesupport)     : null ;
        this.videosupport   = isBoolean(p.videosupport) ? Boolean(p.videosupport)   : null ;
        this.allow          = p.allow                   ? p.allow                   : null ;
        this.dtlsenable     = isBoolean(p.dtlsenable)   ? Boolean(p.dtlsenable)     : null ;
        this.dtlsverify     = isBoolean(p.dtlsverify)   ? Boolean(p.dtlsverify)     : null ;
        this.dtlscertfile   = p.dtlscertfile            ? p.dtlscertfile.toString() : null ;
        this.dtlscafile     = p.dtlscafile              ? p.dtlscafile.toString()   : null ;
        this.dtlssetup      = isInteger(p.dtlssetup)    ? parseInt(p.dtlssetup)     : null ;

        this.template       = p.template                ? p.template.toString()     : null ;
        this.secret         = p.secret                  ? p.secret.toString()       : null ;
        this.context        = p.context                 ? p.context.toString()      : null ;
        this.callgroup      = isInteger(p.callgroup)    ? parseInt(p.callgroup)     : null ;
        this.pickupgroup    = isInteger(p.pickupgroup)  ? parseInt(p.pickupgroup)   : null ;
        this.callerid       = p.callerid                ? p.callerid.toString()     : null ;
        this.nat            = isInteger(p.nat)          ? parseInt(p.nat)           : null ;
        this.dtmfmode       = isInteger(p.dtmfmode)     ? parseInt(p.dtmfmode)      : null ;
        this.lines          = isInteger(p.lines)        ? parseInt(p.lines)         : null ;
    }

    get(){
        super.get();
        let p = this.p;
        p = this.p ? this.p : {}; // delete this.p;
        this.transport      = p.transport               ? p.transport.split(",").map( a => parseInt(a) )       : [] ;
        this.allow          = p.allow                   ? p.allow.split(",").map( a => parseInt(a) )           : [] ;
        //this.dtlssetup      = p.dtlssetup               ? p.dtlssetup.split(",").map( a => parseInt(a) )       : [] ;
        return this;
    }




    put(){
        super.put();
        let p = this.p;
        this.nat            = isInteger(p.nat)          ? parseInt(p.nat)           : 102506 ;
        this.callgroup      = isInteger(p.callgroup)    ? parseInt(p.callgroup)     : 1 ;
        this.pickupgroup    = isInteger(p.pickupgroup)  ? parseInt(p.pickupgroup)   : null ;
        this.dtmfmode       = isInteger(p.dtmfmode)     ? parseInt(p.dtmfmode)      : 102903 ;
        this.allow          = p.allow && p.allow.length > 0             ? p.allow       : [103201, 103202, 103203] ;
        this.transport      = p.transport && p.transport.length > 0     ? p.transport   : [103102] ;
        this.context        = p.context                 ? p.context.toString()      : `undefined` ;
        return this;
    }

    post(){
        super.post();
        let p   = this.p;
        this.nat            = isInteger(p.nat)          ? parseInt(p.nat)           : 102506 ;
        this.callgroup      = isInteger(p.callgroup)    ? parseInt(p.callgroup)     : 1 ;
        this.pickupgroup    = isInteger(p.pickupgroup)  ? parseInt(p.pickupgroup)   : null ;
        this.dtmfmode       = isInteger(p.dtmfmode)     ? parseInt(p.dtmfmode)      : 102903 ;
        this.allow          = p.allow && p.allow.length > 0             ? p.allow                   : [103201, 103202, 103203] ;
        this.transport      = p.transport && p.transport.length > 0     ? p.transport               : [103102] ;
        this.context        = p.context                 ? p.context.toString()     : `undefined` ;
        return this;
    }
}