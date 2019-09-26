/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');
class astMonitoringModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Insert: 'ast_InsMonitoring',
            Find: 'ast_GetMonitoring'
        };
        super(storedProc);

        this.Insert     = Insert;
        this.FindPost   = FindPost;
    }
}
class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.SIP           = p.SIP                 ?   p.SIP               : null;
        d.eventName     = p.eventName           ?   p.eventName         : null;
        d.hourer        = p.hourer              ?   p.hourer            : null;
        d.eventSwitch   = p.eventSwitch         ?   p.eventSwitch       : null;
        d.counter       = p.counter             ?   p.counter           : null;
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.SIP           = p.SIP                 ?   p.SIP               : null;
        d.eventName     = p.eventName           ?   p.eventName         : null;
        d.dev_status    = p.dev_status          ?   p.dev_status        : null;
        d.dev_state     = p.dev_state           ?   p.dev_state         : null;
        d.pause         = checkType(p.pause)    ?   Boolean(p.pause)    : null;
        d.address       = p.address             ?   p.address           : null;
    }
}

const model = new astMonitoringModel();
module.exports = model;