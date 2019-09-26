/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');

class fsBaseModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find: 'fs_GetBase',
            Insert: 'fs_InsBase',
            Update: 'fs_UpdBase',
            Delete: 'fs_DelBase',
            Sabd: 'fs_GetBaseSabd',
            SabdDetail: 'fs_GetBaseSabdDetail',
        };
        super(storedProc);

        this.FindPost = FindPost;
        this.Insert = Insert;
        this.Update = Update;
        this.Lookup = Lookup;
        this.Sabd = Sabd;
        this.SabdDetail = SabdDetail;
    }

    repoSabd(params, callback) {
        this.execute(this.StoredProc.Sabd, params, callback)
    }
    repoSabdDetail(params, callback) {
        this.execute(this.StoredProc.SabdDetail, params, callback)
    }
}
class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID       = p.HIID  !== undefined        ?   p.HIID       : null;
        d.dbID = p.dbID;
        d.dbName = p.dbName;
        d.dbPrefix = p.dbPrefix;
        d.isActive = Boolean(p.isActive[0]);
        d.activeTo = p.activeTo;
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.dbID = p.dbID;
        d.dbName = p.dbName;
        d.dbPrefix = p.dbPrefix;
        d.activeTo = p.activeTo;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID = p.HIID;
        d.dbID = p.dbID;
        d.dbName = p.dbName;
        d.dbPrefix = p.dbPrefix;
        d.activeTo = p.activeTo;
        d.isActive = p.isActive;
    }
}
class Lookup extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.dbID = p.dbID;
        d.dbName = p.dbName;
    }
}
class Sabd extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.dbName = p.dbName;
        d.ffID = p.ffID;
        d.ffName = p.ffName;
    }
}
class SabdDetail extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.FilterID = p.FilterID;
        d.Name = p.Name;
        d.Qty = p.Qty;
        d.clID = p.clID;
    }
}

const model = new fsBaseModel();
module.exports = model;
