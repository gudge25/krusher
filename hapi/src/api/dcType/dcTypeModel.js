/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class dcTypeModel extends BaseDAO {
  constructor() {
    const storedProc = {
      Find: 'dc_GetType',
      Insert: 'dc_InsType',
      Update: 'dc_UpdType',
      Delete: 'dc_DelType'
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
        d.HIID       = p.HIID !== undefined         ?   p.HIID       : null;
        d.dctID = p.dctID;
        d.dctName = p.dctName;
        d.isActive                      = checkType(p.isActive[0])                         ?   Boolean(p.isActive[0])                     : null;
        d.Created = p.Created;
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.dctID = p.dctID;
        d.dctName = p.dctName;
        d.isActive                      = checkType(p.isActive[0])                         ?   Boolean(p.isActive[0])                     : null;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID = p.HIID;
        d.dctID = p.dctID;
        d.dctName = p.dctName;
        d.isActive                      = checkType(p.isActive[0])                         ?   Boolean(p.isActive[0])                     : null;
    }
}

const model = new dcTypeModel();
module.exports = model;
