/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class crmClientProductModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find : 'crm_GetClientProduct',
            Insert: 'crm_InsClientProduct',
            Update: 'crm_UpdClientProduct',
            Delete: 'crm_DelClientProduct',
        };
        super(storedProc);

        this.FindPost = FindPost;
        this.Insert = Insert;
        this.Update = Update;
    }
}
class FindPost extends Model.Get {
  constructor(p) {
    super(p);
    const d = this.Data;
    d.cpID = p.cpID;
    d.clID = p.clID;
    d.psID = p.psID;
    d.cpQty = p.cpQty;
    d.cpPrice = p.cpPrice;
    d.psName = p.psName;
    d.isActive                      = checkType(p.isActive[0])                         ?   Boolean(p.isActive[0])                     : null;
  }
}
class Insert extends Model.Post {
  constructor(p) {
    super(p);
    const d = this.Data;
    d.cpID = p.cpID;
    d.clID = p.clID;
    d.psID = p.psID;
    d.cpQty = p.cpQty;
    d.cpPrice = p.cpPrice;
  }
}
class Update extends Model.Put {
  constructor(p) {
    super(p);
    const d = this.Data;
    d.cpID = p.cpID;
    d.clID = p.clID;
    d.psID = p.psID;
    d.cpQty = p.cpQty;
    d.cpPrice = p.cpPrice;
  }
}

const model = new crmClientProductModel();
module.exports = model;
