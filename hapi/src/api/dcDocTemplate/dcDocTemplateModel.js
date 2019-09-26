/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class dcDocTemplateModel extends BaseDAO {
  constructor() {
    const storedProc = {
        Find: 'dc_GetDocTemplate',
        Insert: 'dc_InsDocTemplate',
        Update: 'dc_UpdDocTemplate',
        Delete: 'dc_DelDocTemplate',
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
    d.dtID = p.dtID;
    d.dtName = p.dtName;
    d.dcTypeID = p.dcTypeID;
    d.dtTemplate = p.dtTemplate;
    d.isActive = Boolean(p.isActive);
    d.isDefault = Boolean(p.isDefault);
    d.dcTypeName = p.dcTypeName;
      d.isActive                      = checkType(p.isActive[0])                         ?   Boolean(p.isActive[0])                     : null;
  }
}
class Insert extends Model.Post {
  constructor(p) {
    super(p);
    const d = this.Data;
    d.dtID = p.dtID;
    d.dtName = p.dtName;
    d.dcTypeID = p.dcTypeID;
    d.dtTemplate = p.dtTemplate;
    d.isActive = p.isActive;
    d.isDefault = p.isDefault;
  }
}
class Update extends Model.Put {
  constructor(p) {
    super(p);
    const d = this.Data;
    d.dtID = p.dtID;
    d.dtName = p.dtName;
    d.dcTypeID = p.dcTypeID;
    d.dtTemplate = p.dtTemplate;
    d.isActive = p.isActive;
    d.isDefault = p.isDefault;
  }
}

const model = new dcDocTemplateModel();
module.exports = model;
