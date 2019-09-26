/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');
class astEventsModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Insert: 'ast_InsEvents',
            Find: 'ast_GetEvents'
        };
        super(storedProc);

        this.Insert     = Insert;
        this.FindPost   = FindPost;
        this.FindPostIn   = FindPostIn;
    }
}



class FindPostIn extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.DateFrom   = p.DateFrom;
        d.DateTo   = p.DateTo;
        d.phone           = p.phone                 ?   p.phone               : null;
        d.eventName     = p.eventName           ?   p.eventName         : null;
    }
}
class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.phone           = p.phone                 ?   p.phone               : null;
        d.eventName     = p.eventName           ?   p.eventName         : null;
        d.timeStart        = p.timeStart              ?   p.timeStart            : null;
        d.timeEnd   = p.timeEnd         ?   p.timeEnd       : null;
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token           = p.token                 ?   p.token               : null;
        d.ccName           = p.ccName                 ?   p.ccName               : null;
        d.SIP           = p.SIP                 ?   p.SIP               : null;
        d.eventName     = p.eventName           ?   p.eventName         : null;
    }
}

const model = new astEventsModel();
module.exports = model;