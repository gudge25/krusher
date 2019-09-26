/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class regCountryModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find : `reg_GetCountry`,
            Insert: `reg_InsCountry`,
            Update: `reg_UpdCountry`,
            Delete: `reg_DelCountry`,
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
        d.cID = p.cID;
        d.cName = p.cName;
        d.langID = p.langID;
        d.LenNumber1 = p.LenNumber1;
        d.LenNumber2 = p.LenNumber2;
        d.isActive                      = checkType(p.isActive[0])          ? Boolean(p.isActive[0])    :    null;
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.cID = p.cID;
        d.cName = p.cName;
        d.langID = p.langID;
        d.isActive                      = checkType(p.isActive)          ? Boolean(p.isActive)    :    null;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID = p.HIID;
        d.cID = p.cID;
        d.cName = p.cName;
        d.langID = p.langID;
        d.isActive                      = checkType(p.isActive)          ? Boolean(p.isActive)    :    null;
    }
}

const model = new regCountryModel();
module.exports = model;
