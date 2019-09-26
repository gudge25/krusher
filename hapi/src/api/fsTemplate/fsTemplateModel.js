/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class fsTemplateModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find: `fs_GetTemplate`,
            Insert: 'fs_InsTemplate',
            Update: 'fs_UpdTemplate',
            Delete: 'fs_DelTemplate',
            FindEncoding: "fs_GetEncodingTemplate",
        };
        super(storedProc);

        this.FindPost = FindPost;
        this.Insert = Insert;
        this.Update = Update;
        this.FindEncoding = FindEncoding;
    }

    repoFindEncoding(params, callback) {
        this.execute(this.StoredProc.FindEncoding, params, callback);
    }
}
class FindEncoding extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID       = p.HIID         ?   p.HIID       : null;
        d.Encoding = p.Encoding;
        d.Description = p.Description;
    }
}
class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.ftID = p.ftID;
        d.ftName = p.ftName;
        d.delimiter = p.delimiter;
        d.Encoding = p.Encoding;
        d.isActive                      = checkType(p.isActive[0])                         ?   Boolean(p.isActive[0])                     : null;
    }
}

class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.ftID = p.ftID;
        d.ftName = p.ftName;
        d.delimiter = p.delimiter;
        d.Encoding = p.Encoding;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID = p.HIID;
        d.ftID = p.ftID;
        d.ftName = p.ftName;
        d.delimiter = p.delimiter;
        d.Encoding = p.Encoding;
        d.isActive                      = checkType(p.isActive)                         ?   Boolean(p.isActive)                     : null;
    }
}

const model = new fsTemplateModel();
module.exports = model;
