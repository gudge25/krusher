/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');
class mpIntegrationInstallModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find:   'mp_GetIntegrationInstall',
            Insert: 'mp_InsIntegrationInstall',
            Update: 'mp_UpdIntegrationInstall',
            Delete: 'mp_DelIntegrationInstall'
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
        d.token                         = p.token                                       ?   p.token                                 : null;
        d.mpiID                   = p.mpiID                                 ?   p.mpiID                           : null;
        d.mpID                   = p.mpID                                 ?   p.mpID                           : null;
        d.login                 = p.login                               ?   p.login                         : null;
        d.pass                      = p.pass                                    ?   p.pass                              : null;
        d.tokenAccess                     = p.tokenAccess                                   ?   p.tokenAccess                             : null;
        d.link                       = p.link                                     ?   p.link                               : null;
        d.data1                       = p.data1                                     ?   p.data1                               : null;
        d.data2                       = p.data2                                     ?   p.data2                               : null;
        d.data3                       = p.data3                                     ?   p.data3                               : null;
        d.isActive                      = checkType(p.isActive)                      ?   Boolean(p.isActive)                  : null;
    }
}
class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID                          = p.HIID     !== undefined                      ?   p.HIID                                  : null;
        d.mpiID                   = p.mpiID                                 ?   p.mpiID                           : null;
        d.mpID                   = p.mpID                                 ?   p.mpID                           : null;
        d.login                 = p.login                               ?   p.login                         : null;
        d.tokenAccess                     = p.tokenAccess                                   ?   p.tokenAccess                             : null;
        d.link                       = p.link                                     ?   p.link                               : null;
        d.data1                       = p.data1                                     ?   p.data1                               : null;
        d.data2                       = p.data2                                     ?   p.data2                               : null;
        d.data3                       = p.data3                                     ?   p.data3                               : null;
        d.isActive                      = checkType(p.isActive[0])                      ?   Boolean(p.isActive[0])                  : null;
        d.Created               = p.Created                 ?   p.Created.toISOString().replace(/\..+/, '')                             : null;
        d.Changed               = p.Changed                 ?   p.Changed.toISOString().replace(/\..+/, '')                             : null;
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token                         = p.token                                       ?   p.token                                 : null;
        d.mpiID                   = p.mpiID                                 ?   p.mpiID                           : null;
        d.mpID                   = p.mpID                                 ?   p.mpID                           : null;
        d.login                 = p.login                               ?   p.login                         : null;
        d.pass                      = p.pass                                    ?   p.pass                              : null;
        d.tokenAccess                     = p.tokenAccess                                   ?   p.tokenAccess                             : null;
        d.link                       = p.link                                     ?   p.link                               : null;
        d.data1                       = p.data1                                     ?   p.data1                               : null;
        d.data2                       = p.data2                                     ?   p.data2                               : null;
        d.data3                       = p.data3                                     ?   p.data3                               : null;
        d.isActive                      = checkType(p.isActive)                      ?   Boolean(p.isActive)                  : null;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token                         = p.token                                       ?   p.token                                 : null;
        d.HIID = p.HIID;
        d.mpiID                   = p.mpiID                                 ?   p.mpiID                           : null;
        d.mpID                   = p.mpID                                 ?   p.mpID                           : null;
        d.login                 = p.login                               ?   p.login                         : null;
        d.pass                      = p.pass                                    ?   p.pass                              : null;
        d.tokenAccess                     = p.tokenAccess                                   ?   p.tokenAccess                             : null;
        d.link                       = p.link                                     ?   p.link                               : null;
        d.data1                       = p.data1                                     ?   p.data1                               : null;
        d.data2                       = p.data2                                     ?   p.data2                               : null;
        d.data3                       = p.data3                                     ?   p.data3                               : null;
        d.isActive                      = checkType(p.isActive)                      ?   Boolean(p.isActive)                  : null;
    }
}

const model = new mpIntegrationInstallModel();
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