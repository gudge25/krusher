/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class emRoleModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find : 'em_GetRole',
            Insert: 'em_InsRole',
            Update: 'em_UpdRole',
            Delete: 'em_DelRole',
        };
        super(storedProc);

        this.FindPost       = FindPost;
        //this.Find           = Find;
        this.Insert         = Insert;
        this.Update         = Update;
    }
}
class FindPost extends Model.Get {
  constructor(p) {
    super(p);
    const d = this.Data;
        d.roleID = p.roleID;
        d.roleName = p.roleName;
        d.Permission = p.Permission;
      d.isActive                      = checkType(p.isActive[0])                         ?   Boolean(p.isActive[0])                     : null;
        d.sorting               = p.sorting                 ?   p.sorting               : null;
        d.field                 = p.field                   ?   p.field                 : null;
        d.offset                = p.offset                  ?   p.offset                : null;
        d.limit                 = p.limit                   ?   p.limit                 : null;
  }
}
class Insert extends Model.Post {
  constructor(p) {
    super(p);
    const d = this.Data;
    d.roleID = p.roleID;
    d.roleName = p.roleName;
    d.Permission = p.Permission;
      d.isActive                      = checkType(p.isActive[0])                         ?   Boolean(p.isActive[0])                     : null;
  }
}
class Update extends Model.Put {
  constructor(p) {
    super(p);
    const d = this.Data;
    d.roleID = p.roleID;
    d.roleName = p.roleName;
    d.Permission = p.Permission;
      d.isActive                      = checkType(p.isActive[0])                         ?   Boolean(p.isActive[0])                     : null;
  }
}

const model = new emRoleModel();
module.exports = model;
