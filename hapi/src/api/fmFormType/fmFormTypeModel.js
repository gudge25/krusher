/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class fmFormTypeModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find: 'fm_GetFormType',
            Insert: 'fm_InsFormType',
            Update: 'fm_UpdFormType',
            Delete: 'fm_DelFormType',
            FindLookup: 'fm_GetFormTypeLookup',
        };
        super(storedProc);

        this.FindPost       = FindPost;
        this.FindLookup     = FindLookup;
        this.Insert         = Insert;
        this.Update         = Update;
    }

    repoFindLookup(params, callback) {
        this.execute(this.StoredProc.FindLookup, params, callback);
    }
}
class FindLookup extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.tpID   = p.tpID;
        d.tpName = p.tpName;
        d.ffID   = p.ffID;
        d.ffName = p.ffName;
    }
}
class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.tpID = p.tpID;
        d.tpName = p.tpName;
        d.ffID = p.ffID;
        d.isActive          = checkType(p.isActive[0]) ?   Boolean(p.isActive[0]) : null;
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const data = this.Data;
        data.tpID = p.tpID;
        data.tpName = p.tpName;
        data.isActive = p.isActive;
        data.ffID = p.ffID;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const data = this.Data;
        data.tpID = p.tpID;
        data.tpName = p.tpName;
        data.isActive = p.isActive;
        data.ffID = p.ffID;
    }
}

const model = new fmFormTypeModel();
module.exports = model;
