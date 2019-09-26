/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class slDealItemModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find :  'sl_GetDealItem',
            Insert: 'sl_InsDealItem',
            Update: 'sl_UpdDealItem',
            Delete: 'sl_DelDealItem',
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
        d.dcID = p.dcID;
        d.diID = p.diID;
        d.psID = p.psID;
        d.psName = p.psName;
        d.iPrice = p.iPrice;
        d.iQty = p.iQty;
        d.isActive                      = checkType(p.isActive[0])          ? Boolean(p.isActive[0])    :    null;
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.dcID = p.dcID;
        d.diID = p.diID;
        d.psID = p.psID;
        d.psName = p.psName;
        d.iPrice = p.iPrice;
        d.iQty = p.iQty;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.dcID = p.dcID;
        d.diID = p.diID;
        d.psID = p.psID;
        d.psName = p.psName;
        d.iPrice = p.iPrice;
        d.iQty = p.iQty;
    }
}

const model = new slDealItemModel();
module.exports = model;
