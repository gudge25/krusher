/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class usCommentModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find : `us_GetComment`,
            Insert: `us_InsComment`,
            Delete: `us_DelComment`,
        };
        super(storedProc);

        this.FindPost       = FindPost;
        this.Insert         = Insert;
    }
}
class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID = p.HIID;
        d.id  = p.id;
        d.uID = p.uID;
        d.uComment = p.uComment;
        d.Created               = p.Created                  ?   p.Created.toISOString()./*replace(/T/, ' ').*/replace(/\..+/, '')                : null;
        d.Changed               = p.Changed                  ?   p.Changed.toISOString()./*replace(/T/, ' ').*/replace(/\..+/, '')                : null;
        d.isActive                      = checkType(p.isActive[0])         ?   Boolean(p.isActive[0])                     : null;
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token = p.token;
        d.uID = p.uID;
        d.uComment = p.uComment;
        d.isActive = p.isActive;
    }
}

const model = new usCommentModel();
module.exports = model;
