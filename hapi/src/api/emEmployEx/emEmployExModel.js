/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class emEmployExModel extends BaseDAO {
  constructor() {
    const storedProc = {
      Find: 'em_GetEmployEx',
      Insert: 'em_InsEmployEx',
      Update: 'em_UpdEmployEx',
      Delete: 'em_DelEmployEx'
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
        d.emID = p.emID;
        d.Settings = JSON.parse(p.Settings);
        d.isActive                      = checkType(p.isActive[0])                         ?   Boolean(p.isActive[0])                     : null;
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.emID = p.emID;
        d.Settings = JSON.stringify(p.Settings);
        d.isActive                      = checkType(p.isActive[0])                         ?   Boolean(p.isActive[0])                     : null;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID = p.HIID;
        d.emID = p.emID;
        d.Settings = JSON.stringify(p.Settings);
        d.isActive                      = checkType(p.isActive[0])                         ?   Boolean(p.isActive[0])                     : null;
    }
}

const model = new emEmployExModel();
module.exports = model;
