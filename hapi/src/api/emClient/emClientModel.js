/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class emClientModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find: 'em_GetClient',
            Insert: 'em_InsClient',
        };
        super(storedProc);

        this.Insert         = Insert;
        this.FindPost       = FindPost;
    }
}

class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.count_of_calls             = p.count_of_calls                   ?   p.count_of_calls                     : null;
        d.client_name                = p.client_name                      ?   p.client_name                        : null;
        d.client_contact = p.client_contact ? p.client_contact : null;
    }
}

class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.LoginName             = p.LoginName               ?   p.LoginName             : null;
        d.Password              = p.Password                ?   p.Password              : null;
        d.url                   = p.url                     ?   p.url                   : null;
        d.IP                    = p.IP                      ?   p.IP                    : null;
        d.port                  = p.port                    ?   p.port                  : null;
        d.phone                 = p.phone                   ?   p.phone                 : null;
        d.mobile_phone          = p.mobile_phone            ?   p.mobile_phone          : null;
        d.email_info            = p.email_info              ?   p.email_info            : null;
        d.email_tech            = p.email_tech              ?   p.email_tech            : null;
        d.email_finance         = p.email_finance           ?   p.email_finance         : null;
        d.hosting_type          = p.hosting_type            ?   p.hosting_type          : null;
        d.clientName            = p.clientName              ?   p.clientName            : null;
        d.clientContact = p.clientContact ? p.clientContact : null;
        d.id_currency           = p.id_currency             ?   p.id_currency           : null;
        d.isActive              = checkType(p.isActive[0])  ?   Boolean(p.isActive[0])  : false;
    }
}

const model = new emClientModel();
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