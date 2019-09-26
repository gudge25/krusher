/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class regLocationModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find : `reg_GetLocation`,
            Insert: `reg_InsLocation`,
            Update: `reg_UpdLocation`,
            Delete: `reg_DelLocation`,
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
        d.lID = p.lID;
        d.lName = p.lName;
        d.langID = p.langID;
        d.isActive                      = checkType(p.isActive[0])          ? Boolean(p.isActive[0])    :    null;
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.lID = p.lID;
        d.lName = p.lName;
        d.langID = p.langID;
        d.isActive                      = checkType(p.isActive)          ? Boolean(p.isActive)    :    null;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID = p.HIID;
        d.lID = p.lID;
        d.lName = p.lName;
        d.langID = p.langID;
        d.isActive                      = checkType(p.isActive)          ? Boolean(p.isActive)    :    null;
    }
}

const model = new regLocationModel();
module.exports = model;
