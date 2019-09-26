/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class sfInvoiceItemModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find : 'sf_GetInvoiceItem',
            Insert: 'sf_InsInvoiceItem',
            Update: 'sf_UpdInvoiceItem',
            Delete: 'sf_DelInvoiceItem',
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
        d.dcID      = p.dcID;
        d.iiID      = p.iiID;
        d.OwnerID   = p.OwnerID;
        d.psID      = p.psID;
        d.iNo       = p.iNo;
        d.iName     = p.iName;
        d.iPrice    = p.iPrice;
        d.iQty      = p.iQty;
        d.iComments = p.iComments;
        d.msID      = p.msID;
        d.isActive                      = checkType(p.isActive[0])          ? Boolean(p.isActive[0])    :    null;
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.dcID = p.dcID;
        d.iiID = p.iiID;
        d.OwnerID = p.OwnerID;
        d.psID = p.psID;
        d.iNo = p.iNo;
        d.iName = p.iName;
        d.iPrice = p.iPrice;
        d.iQty = p.iQty;
        d.iComments = p.iComments;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.dcID = p.dcID;
        d.iiID = p.iiID;
        d.OwnerID = p.OwnerID;
        d.psID = p.psID;
        d.iNo = p.iNo;
        d.iName = p.iName;
        d.iPrice = p.iPrice;
        d.iQty = p.iQty;
        d.iComments = p.iComments;
    }
}

const model = new sfInvoiceItemModel();
module.exports = model;
