/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class sfInvoiceModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find: 'sf_GetInvoice',
            Insert: 'sf_InsInvoice',
            Update: 'sf_UpdInvoice',
            Delete: 'sf_DelInvoice',
        };
        super(storedProc);

        this.FindPost = FindPost;
        this.Update = Update;
        this.Insert = Insert;
    }
}
class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.isActive                      = checkType(p.isActive[0])                         ?   Boolean(p.isActive[0])                     : null;
        d.Delivery = p.Delivery;
        d.VATSum = p.VATSum;
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.Delivery = p.Delivery;
        d.VATSum = p.VATSum;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.dcNo = p.dcNo;
        d.dcDate = p.dcDate;
        d.dcLink = p.dcLink;
        d.dcComment = p.dcComment;
        d.dcSum = p.dcSum;
        d.dcStatus = p.dcStatus;
        d.clID = p.clID;
        d.emID = p.emID;
        d.isActive                      = checkType(p.isActive)                         ?   Boolean(p.isActive)                     : null;
        d.Delivery = p.Delivery;
        d.VATSum = p.VATSum;
    }
}

const model = new sfInvoiceModel();
module.exports = model;
