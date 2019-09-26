/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class pchPaymentModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find: 'pch_GetPayment',
            Insert: 'pch_InsPayment',
            Update: 'pch_UpdPayment',
            Delete: 'pch_DelPayment',
        };
        super(storedProc);

        this.FindPost       = FindPost;
        this.Insert         = Insert;
        this.Update         = Update;
    }
}
class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.PayType = p.PayType;
        d.PayMethod = p.PayMethod;
        d.isActive                      = checkType(p.isActive[0])          ? Boolean(p.isActive[0])    :    null;
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.PayType = p.PayType;
        d.PayMethod = p.PayMethod;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.PayType = p.PayType;
        d.PayMethod = p.PayMethod;
    }
}

const model = new pchPaymentModel();
module.exports = model;
