/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class fsTemplateItemModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find : 'fs_GetTemplateItem',
            Insert: 'fs_InsTemplateItem',
            Update: 'fs_UpdTemplateItem',
            Delete: 'fs_DelTemplateItem',
        };
        super(storedProc);

        this.FindPost = FindPost;
        this.Update = Update;
        this.Insert = Insert;
    }
}
class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;

        d.HIID       = p.HIID  !== undefined        ?   p.HIID       : null;
        d.ftiID = p.ftiID;
        d.ftID = p.ftID;
        d.ftType = p.ftType;
        d.ColNumber = p.ColNumber.split(',').map(Number);
        //d.ColNumber                         = p.ColNumber                   ?   p.ColNumber.filter(x => x).join()              : '';
        d.ftDelim = p.ftDelim;
        d.isActive          = checkType(p.isActive[0])          ? Boolean(p.isActive[0])    :    null;
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token   = p.token;
        d.ftiID = p.ftiID;
        d.ftID = p.ftID;
        d.ftType = p.ftType;
        d.ColNumber                         = p.ColNumber                   ?   p.ColNumber.join()              : '';
        d.ftDelim = p.ftDelim;
        d.isActive          = checkType(p.isActive)          ? Boolean(p.isActive)    :    null;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID = p.HIID;
        d.token   = p.token;
        d.ftiID = p.ftiID;
        d.ftID = p.ftID;
        d.ftType = p.ftType;
        //d.ColNumber = p.ColNumber.join();
        d.ColNumber                         = p.ColNumber                   ?   p.ColNumber.join()              : '';
        //d.ColNumber                         = p.ColNumber                   ?   p.ColNumber.filter(x => x).join()              : '';
        d.ftDelim = p.ftDelim;
        d.isActive          = checkType(p.isActive)          ? Boolean(p.isActive)    :    null;
    }
}

const model = new fsTemplateItemModel();
module.exports = model;
