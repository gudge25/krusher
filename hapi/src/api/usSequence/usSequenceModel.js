/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class usSequenceModel extends BaseDAO {
    constructor() {
        const storedProc = {
            FindByID : `us_GetNextID`,
            Find : `us_ServerTime`,
        };
        super(storedProc);

        this.FindOne        = FindOne;
        this.Find           = Find;
    }
}
class FindOne extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.seqName = p.seqName;
        d.seqValue = p.seqValue;
    }
}
class Find extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.time                         = p.time                   ?   p.time.toISOString().replace(/T/, ' ').replace(/\..+/, '')              : null;
    }
}

const model = new usSequenceModel();
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