/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');
class smsSmsModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find:   'ast_GetSms',
            Insert: 'ast_InsSingleSms',
            InsertIncomingGoIP: 'ast_InsIncomingGoIP',
            InsertBulk: 'ast_InsBulkSms',
            UpdateBulk: 'ast_UpdBulkSms',
            FindBulk: 'ast_GetBulkSms',
            DelBulk: 'ast_DelBulkSms'
        };
        super(storedProc);

        this.Insert         = Insert;
        this.InsertGoipIncoming         = InsertGoipIncoming;
        this.FindPost       = FindPost;
        this.FindPostIn     = FindPostIn;
        this.InsertBulk     = InsertBulk;
        this.UpdateBulk     = UpdateBulk;
        this.FindBulkPost     = FindBulkPost;
    }

    repoIncomingGoip(params, callback) {
        this.execute(this.StoredProc.InsertIncomingGoIP, params, callback);
    }
    repoInsertBulk(params, callback) {
        this.execute(this.StoredProc.InsertBulk, params, callback);
    }
    repoUpdateBulk(params, callback) {
        this.execute(this.StoredProc.UpdateBulk, params, callback);
    }
    repoBulkFind(params, callback) {
        this.execute(this.StoredProc.FindBulk, params, callback);
    }
    repoBulkDelete(params, callback) {
        this.execute(this.StoredProc.DelBulk, params, callback);
    }
}
class FindPostIn extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token                         = p.token                                       ?   p.token                                 : null;
        d.dcID                   = p.dcID                                 ?   p.dcID                           : null;
        d.emID                 = p.emID                               ?   p.emID                         : null;
        d.ccID                 = p.ccID                               ?   p.ccID                         : null;
        d.clID                 = p.clID                               ?   p.clID                         : null;
        d.ffID                 = p.ffID                               ?   p.ffID                         : null;
        d.originator                      = p.originator                                    ?   p.originator                              : null;
        d.ccName                     = p.ccName                                   ?   p.ccName                             : null;
        d.text_sms                       = p.text_sms                                     ?   p.text_sms                               : null;
        d.isActive                      = checkType(p.isActive)                         ?   Boolean(p.isActive)                     : false;
    }
}
class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID                          = p.HIID     !== undefined                      ?   p.HIID                                  : null;
        d.dcID                   = p.dcID                                 ?   p.dcID                           : null;
        d.emID                 = p.emID                               ?   p.emID                         : null;
        d.ccID                 = p.ccID                               ?   p.ccID                         : null;
        d.clID                 = p.clID                               ?   p.clID                         : null;
        d.ffID                 = p.ffID                               ?   p.ffID                         : null;
        d.originator                      = p.originator                                    ?   p.originator                              : null;
        d.ccName                     = p.ccName                                   ?   p.ccName                             : null;
        d.text_sms                       = p.text_sms                                     ?   p.text_sms                               : null;
        d.isActive                      = checkType(p.isActive[0])                      ?   Boolean(p.isActive[0])                  : null;
        d.Created                       = p.Created                 ?   p.Created.toISOString().replace(/\..+/, '')                             : null;
        d.Changed                       = p.Changed                 ?   p.Changed.toISOString().replace(/\..+/, '')                             : null;
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token                         = p.token                                       ?   p.token                                 : null;
        d.dcID                   = p.dcID                                 ?   p.dcID                           : null;
        d.emID                 = p.emID                               ?   p.emID                         : null;
        d.ccID                 = p.ccID                               ?   p.ccID                         : null;
        d.clID                 = p.clID                               ?   p.clID                         : null;
        d.ffID                 = p.ffID                               ?   p.ffID                         : null;
        d.originator                      = p.originator                                    ?   p.originator                              : null;
        d.ccName                     = p.ccName                                   ?   p.ccName                             : null;
        d.text_sms                       = p.text_sms                                     ?   p.text_sms                               : null;
        d.isActive                      = checkType(p.isActive)                         ?   Boolean(p.isActive)                     : false;
    }
}
class InsertBulk extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token                     = p.token                                       ?   p.token                                 : null;
        d.bulkID                    = p.bulkID                                 ?   p.bulkID                           : null;
        d.originator                = p.originator                               ?   p.originator                         : null;
        d.ffID                      = p.ffID                               ?   p.ffID                         : null;
        d.text_sms                  = p.text_sms                                     ?   p.text_sms                               : null;
        d.timeBegin                 = p.timeBegin                                     ?   p.timeBegin                               : null;
        d.emID                      = p.emID                               ?   p.emID                         : null;
        d.status                      = p.status                               ?   p.status                         : null;
        d.isActive                  = checkType(p.isActive)                         ?   Boolean(p.isActive)                     : false;
    }
}
class UpdateBulk extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token                     = p.token                                       ?   p.token                                 : null;
        d.HIID                      = p.HIID  !== undefined                         ?   p.HIID                                 : null;
        d.bulkID                    = p.bulkID                                 ?   p.bulkID                           : null;
        d.originator                = p.originator                               ?   p.originator                         : null;
        d.ffID                      = p.ffID                               ?   p.ffID                         : null;
        d.text_sms                  = p.text_sms                                     ?   p.text_sms                               : null;
        d.timeBegin                 = p.timeBegin                                     ?   p.timeBegin                               : null;
        d.emID                      = p.emID                               ?   p.emID                         : null;
        d.status                      = p.status                               ?   p.status                         : null;
        d.isActive                  = checkType(p.isActive)                         ?   Boolean(p.isActive)                     : false;
    }
}
class FindBulkPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.bulkID                    = p.bulkID                                 ?   p.bulkID                           : null;
        d.originator                = p.originator                               ?   p.originator                         : null;
        d.ffID                      = p.ffID                               ?   p.ffID                         : null;
        d.text_sms                  = p.text_sms                                     ?   p.text_sms                               : null;
        d.timeBegin                 = p.timeBegin                                     ?   p.timeBegin.toISOString().replace(/\..+/, '')                                   : null;
        d.emID                      = p.emID                               ?   p.emID                         : null;
        d.status                      = p.status                               ?   p.status                         : null;
        d.isActive                  = checkType(p.isActive[0])                         ?   Boolean(p.isActive[0])                     : false;
        d.Created                       = p.Created                 ?   p.Created.toISOString().replace(/\..+/, '')                             : null;
        d.Changed                       = p.Changed                 ?   p.Changed.toISOString().replace(/\..+/, '')                             : null;
    }
}
class InsertGoipIncoming extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.name                         = p.name                                       ?   p.name                                 : null;
        d.number                   = p.number                                 ?   p.number                           : null;
        d.content                 = p.content                               ?   p.content                         : null;
    }
}

const model = new smsSmsModel();
module.exports = model;
