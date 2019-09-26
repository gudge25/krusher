/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class astTtsFieldsModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find: `ast_GetTtsFields`,
            Insert: `ast_InsTtsFields`,
            Update: `ast_UpdTtsFields`,
            Delete: `ast_DelTtsFields`,
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
        //d.HIID       = p.HIID  !== undefined        ?   p.HIID       : null;
        d.ttsfID = p.ttsfID;
        d.fields = p.fields;
        d.langID = p.langID;
        d.fieldName = p.fieldName;
        d.isActive = checkType(p.isActive[0]) ? Boolean(p.isActive[0]) : null;
    }
}

class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.ttsfID = p.ttsfID;
        d.fields = p.fields;
        d.langID = p.langID;
        d.fieldName = p.fieldName;
        d.isActive = checkType(p.isActive) ? Boolean(p.isActive) : null;
    }
}

class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID = p.HIID;
        d.ttsfID = p.ttsfID;
        d.fields = p.fields;
        d.langID = p.langID;
        d.fieldName = p.fieldName;
        d.isActive = checkType(p.isActive) ? Boolean(p.isActive) : null;
    }
}

const model = new astTtsFieldsModel();
module.exports = model;
