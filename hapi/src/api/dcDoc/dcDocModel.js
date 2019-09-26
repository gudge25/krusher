/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class dcDocModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find: 'dc_GetDoc',
            FindStream: 'dc_GetDocStream',
            FindByClient: 'dc_GetDocByClient',
        };
        super(storedProc);

        this.FindPost       = FindPost;
        this.FindByClient   = FindByClient;
        this.FindStream     = FindStream;
    }

    repoFindStream(obj, callback) {
        this.execute(this.StoredProc.FindStream, obj, callback);
    }
    repoFindByClient(obj, callback) {
        this.execute(this.StoredProc.FindByClient,obj, callback);
    }
}
class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID              = p.HIID    !== undefined             ?   p.HIID              : null;
        d.dcID              = p.dcID                ?   p.dcID              : null;
        d.dctType           = p.dctType             ?   p.dctType          : null;
        d.dctName           = p.dctName             ?   p.dctName          : null;
        d.dcNo              = p.dcNo                ?   p.dcNo              : null;
        d.dcDate            = p.dcDate              ?   p.dcDate.toISOString().split('T')[0]            : null;
        d.dcLink            = p.dcLink              ?   p.dcLink            : null;
        d.dcLinkType        = p.dcLinkType          ?   p.dcLinkType        : null;
        d.dcLinkDate        = p.dcLinkDate          ?   p.dcLinkDate.toISOString().replace(/\..+/, '')        : null;
        d.dcLinkNo          = p.dcLinkNo            ?   p.dcLinkNo          : null;
        d.dcComment         = p.dcComment           ?   p.dcComment         : null;
        d.dcSum             = p.dcSum               ?   p.dcSum             : null;
        d.dcStatus          = p.dcStatus            ?   p.dcStatus          : null;
        d.dcStatusName      = p.dcStatusName        ?   p.dcStatusName      : null;
        d.clID              = p.clID                ?   p.clID              : null;
        d.clName            = p.clName              ?   p.clName            : null;
        d.emID              = p.emID                ?   p.emID              : null;
        d.emName            = p.emName              ?   p.emName            : null;
        d.crID            = p.crID              ?   p.crID            : null;
        d.pcID            = p.pcID              ?   p.pcID            : null;
        d.dcRate            = p.dcRate              ?   p.dcRate            : null;
        d.Created         = p.Created           ?   p.Created.toISOString().replace(/\..+/, '')         : null;
        d.CreatedBy         = p.CreatedBy           ?   p.CreatedBy         : null;
        d.CreatedName       = p.CreatedName         ?   p.CreatedName       : null;
        d.Changed          = p.Changed            ?   p.Changed.toISOString().replace(/\..+/, '')          : null;
        d.ChangedBy          = p.ChangedBy            ?   p.ChangedBy          : null;
        d.EditedName        = p.EditedName          ?   p.EditedName        : null;
        d.isActive          = checkType(p.isActive[0]) ?   Boolean(p.isActive[0]) : null;
        d.tpName        = p.tpName          ?   p.tpName        : null;
    }
}
class FindStream extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.dup_action = p.dup_action;
        d.dctName = p.dctName;
        d.dctID = p.dctID;
        d.OLD_dcNo = p.OLD_dcNo;
        d.OLD_dcDate = p.OLD_dcDate ? toJSONLocal(p.OLD_dcDate) : null;
        d.OLD_dcSum = p.OLD_dcSum;
        d.OLD_dcStatus = p.OLD_dcStatus;
        d.OLD_emID = p.OLD_emID;
        d.OLD_clID = p.OLD_clID;
        d.OLD_clName = p.OLD_clName;
    }
}
class FindByClient extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.dcID = p.dcID;
        d.dctID = p.dctID;
        d.dctName = p.dctName;
        d.dcDate = p.dcDate;
        d.dcNo = p.dcNo;
        d.emID = p.emID;
        d.emName = p.emName;
        d.dcStatus = p.dcStatus;
        d.ccName = p.ccName;
    }
}


const model = new dcDocModel();
module.exports = model;
