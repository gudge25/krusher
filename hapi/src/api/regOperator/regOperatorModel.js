/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class regOperatorModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find : `reg_GetOperator`,
            Insert: `reg_InsOperator`,
            Update: `reg_UpdOperator`,
            Delete: `reg_DelOperator`,
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
        d.HIID       = p.HIID  !== undefined        ?   p.HIID       : null;
        d.oID = p.oID;
        d.oName = p.oName;
        d.MCC = p.MCC;
        d.MNC = p.MNC;
        d.isActive                      = checkType(p.isActive[0])          ? Boolean(p.isActive[0])    :    null;
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.oID = p.oID;
        d.oName = p.oName;
        d.MCC = p.MCC;
        d.MNC = p.MNC;
        d.isActive                      = checkType(p.isActive)          ? Boolean(p.isActive)    :    null;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token = p.token;
        d.HIID = p.HIID;
        d.oID = p.oID;
        d.oName = p.oName;
        d.MCC = p.MCC;
        d.MNC = p.MNC;
        d.isActive                      = checkType(p.isActive)          ? Boolean(p.isActive)    :    null;
    }
}

const model = new regOperatorModel();
module.exports = model;
