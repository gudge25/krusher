/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class regAreaModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find : `reg_GetArea`,
            Insert: `reg_InsArea`,
            Update: `reg_UpdArea`,
            Delete: `reg_DelArea`,
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
        d.aID = p.aID;
        d.aName = p.aName;
        d.langID = p.langID;
        d.isActive                      = checkType(p.isActive[0])          ? Boolean(p.isActive[0])    :    null;
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.aID = p.aID;
        d.aName = p.aName;
        d.langID = p.langID;
        d.isActive                      = checkType(p.isActive)          ? Boolean(p.isActive)    :    null;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token = p.token;
        d.HIID = p.HIID;
        d.aID = p.aID;
        d.aName = p.aName;
        d.cID = p.cID;
        d.rgID = p.rgID;
        d.langID = p.langID;
        d.isActive                      = checkType(p.isActive)          ? Boolean(p.isActive)    :    null;
    }
}

const model = new regAreaModel();
module.exports = model;
