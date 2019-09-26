/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class regRegionModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find : `reg_GetRegion`,
            Insert: `reg_InsRegion`,
            Update: `reg_UpdRegion`,
            Delete: `reg_DelRegion`,
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
        d.rgID = p.rgID;
        d.rgName = p.rgName;
        d.cID = p.cID;
        d.cName = p.cName;
        d.langID = p.langID;
        d.isActive                      = checkType(p.isActive[0])          ? Boolean(p.isActive[0])    :    null;
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.rgID = p.rgID;
        d.rgName = p.rgName;
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
        d.rgID = p.rgID;
        d.rgName = p.rgName;
        d.cID = p.cID;
        d.langID = p.langID;
        d.isActive                      = checkType(p.isActive)          ? Boolean(p.isActive)    :    null;
    }
}

const model = new regRegionModel();
module.exports = model;
