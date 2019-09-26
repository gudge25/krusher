/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class astTimeGroupModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find:   'ast_GetTimeGroup',
            Insert: 'ast_InsTimeGroup',
            Update: 'ast_UpdTimeGroup',
            Delete: 'ast_DelTimeGroup'
        };
        super(storedProc);

        this.Insert     = Insert;
        this.Update     = Update;
        this.FindPost   = FindPost;
    }
}
class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID       = p.HIID     !== undefined     ?   p.HIID       : null;
        d.tgID                   = p.tgID                                 ?   p.tgID                           : null;
        d.tgName                 = p.tgName                               ?   p.tgName                         : null;
        d.destination                 = p.destination                               ?   p.destination                         : null;
        d.destdata                 = p.destdata                               ?   p.destdata                         : null;
        d.destdata2                 = p.destdata2                               ?   p.destdata2                         : null;
        d.invalid_destination                 = p.invalid_destination                               ?   p.invalid_destination                         : null;
        d.invalid_destdata                 = p.invalid_destdata                               ?   p.invalid_destdata                         : null;
        d.invalid_destdata2                 = p.invalid_destdata2                               ?   p.invalid_destdata2                         : null;
        d.isActive                      = checkType(p.isActive[0])                         ?   Boolean(p.isActive[0])                     : null;
    }
}

class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.tgID                   = p.tgID                                 ?   p.tgID                           : null;
        d.tgName                 = p.tgName                               ?   p.tgName                         : null;
        d.destination                 = p.destination                               ?   p.destination                         : null;
        d.destdata                 = p.destdata                               ?   p.destdata                         : null;
        d.destdata2                 = p.destdata2                               ?   p.destdata2                         : null;
        d.invalid_destination                 = p.invalid_destination                               ?   p.invalid_destination                         : null;
        d.invalid_destdata                 = p.invalid_destdata                               ?   p.invalid_destdata                         : null;
        d.invalid_destdata2                 = p.invalid_destdata2                               ?   p.invalid_destdata2                         : null;
        d.isActive                      = checkType(p.isActive)                         ?   Boolean(p.isActive)                     : false;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID       = p.HIID     !== undefined     ?   p.HIID       : null;
        d.tgID                   = p.tgID                                 ?   p.tgID                           : null;
        d.tgName                 = p.tgName                               ?   p.tgName                         : null;
        d.destination                 = p.destination                               ?   p.destination                         : null;
        d.destdata                 = p.destdata                               ?   p.destdata                         : null;
        d.destdata2                 = p.destdata2                               ?   p.destdata2                         : null;
        d.invalid_destination                 = p.invalid_destination                               ?   p.invalid_destination                         : null;
        d.invalid_destdata                 = p.invalid_destdata                               ?   p.invalid_destdata                         : null;
        d.invalid_destdata2                 = p.invalid_destdata2                               ?   p.invalid_destdata2                         : null;
        d.isActive                      = checkType(p.isActive)                         ?   Boolean(p.isActive)                     : false;
    }
}

const model = new astTimeGroupModel();
module.exports = model;
