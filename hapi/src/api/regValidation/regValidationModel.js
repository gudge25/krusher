/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class regValidationModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find : `reg_GetValidation`,
            Insert: `reg_InsValidation`,
            Update: `reg_UpdValidation`,
            Delete: `reg_DelValidation`,
            checkPhone: `reg_ValidationPhone`,
        };
        super(storedProc);

        this.FindPost       = FindPost;
        this.Insert         = Insert;
        this.Update         = Update;
        this.checkPhone     = checkPhone;
    }

    repoPhone(params, callback) {
        this.execute(this.StoredProc.checkPhone, params, callback);
    }
}
class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID       = p.HIID  !== undefined        ?   p.HIID       : null;
        d.vID = p.vID;
        d.prefix = p.prefix;
        d.prefixBegin = p.prefixBegin;
        d.prefixEnd = p.prefixEnd;
        d.gmt = p.gmt;
        d.MCC = p.MCC;
        d.MNC = p.MNC;
        d.cID = p.cID;
        d.rgID = p.rgID;
        d.aID = p.aID;
        d.lID = p.lID;
        d.oID = p.oID;
        d.langID = p.langID;
        d.isActive                      = checkType(p.isActive[0])          ? Boolean(p.isActive[0])    :    null;
        d.isGSM                      = checkType(p.isGSM)          ? Boolean(p.isGSM)    :    null;
    }
}
class checkPhone extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.vID = p.vID;
        d.prefix = p.prefix;
        d.prefixBegin = p.prefixBegin;
        d.prefixEnd = p.prefixEnd;
        d.gmt = p.gmt;
        d.MCC = p.MCC;
        d.MNC = p.MNC;
        d.cID = p.cID
        d.rgID = p.rgID;
        d.aID = p.aID;
        d.lID = p.lID;
        d.oID = p.oID;
        d.isActive                      = checkType(p.isActive)          ? Boolean(p.isActive)    :    null;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token = p.token;
        d.HIID = p.HIID;
        d.vID = p.vID;
        d.prefix = p.prefix;
        d.prefixBegin = p.prefixBegin;
        d.prefixEnd = p.prefixEnd;
        d.MCC = p.MCC;
        d.MNC = p.MNC;
        d.cID = p.cID;
        d.rgID = p.rgID;
        d.aID = p.aID;
        d.lID = p.lID;
        d.oID = p.oID;
        d.gmt = p.gmt;
        d.isActive                      = checkType(p.isActive)          ? Boolean(p.isActive)    :    null;
    }
}

const model = new regValidationModel();
module.exports = model;
