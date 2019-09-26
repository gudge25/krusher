/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class astTimeGroupItemsModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find:   'ast_GetTimeGroupItems',
            Insert: 'ast_InsTimeGroupItems',
            Update: 'ast_UpdTimeGroupItems',
            Delete: 'ast_DelTimeGroupItems'
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
        d.tgiID                   = p.tgiID                                 ?   p.tgiID                           : null;
        d.tgID                   = p.tgID                                 ?   p.tgID                           : null;
        d.TimeStart                 = p.TimeStart                               ?   p.TimeStart                         : null;
        d.TimeFinish                 = p.TimeFinish                               ?   p.TimeFinish                         : null;
        d.DayNumStart                 = p.DayNumStart                               ?   p.DayNumStart                         : null;
        d.DayNumFinish                 = p.DayNumFinish                               ?   p.DayNumFinish                         : null;
        d.DayStart                 = p.DayStart                               ?   p.DayStart                         : null;
        d.DayFinish                 = p.DayFinish                               ?   p.DayFinish                         : null;
        d.MonthStart                 = p.MonthStart                               ?   p.MonthStart                         : null;
        d.MonthFinish                 = p.MonthFinish                               ?   p.MonthFinish                         : null;
        d.isActive                      = checkType(p.isActive[0])                         ?   Boolean(p.isActive[0])                     : null;
    }
}

class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.tgiID                   = p.tgiID                                 ?   p.tgiID                           : null;
        d.tgID                   = p.tgID                                 ?   p.tgID                           : null;
        d.TimeStart                 = p.TimeStart                               ?   p.TimeStart                         : null;
        d.TimeFinish                 = p.TimeFinish                               ?   p.TimeFinish                         : null;
        d.DayNumStart                 = p.DayNumStart                               ?   p.DayNumStart                         : null;
        d.DayNumFinish                 = p.DayNumFinish                               ?   p.DayNumFinish                         : null;
        d.DayStart                 = p.DayStart                               ?   p.DayStart                         : null;
        d.DayFinish                 = p.DayFinish                               ?   p.DayFinish                         : null;
        d.MonthStart                 = p.MonthStart                               ?   p.MonthStart                         : null;
        d.MonthFinish                 = p.MonthFinish                               ?   p.MonthFinish                         : null;
        d.isActive                      = checkType(p.isActive)                         ?   Boolean(p.isActive)                     : false;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID       = p.HIID     !== undefined     ?   p.HIID       : null;
        d.tgiID                   = p.tgiID                                 ?   p.tgiID                           : null;
        d.tgID                   = p.tgID                                 ?   p.tgID                           : null;
        d.TimeStart                 = p.TimeStart                               ?   p.TimeStart                         : null;
        d.TimeFinish                 = p.TimeFinish                               ?   p.TimeFinish                         : null;
        d.DayNumStart                 = p.DayNumStart                               ?   p.DayNumStart                         : null;
        d.DayNumFinish                 = p.DayNumFinish                               ?   p.DayNumFinish                         : null;
        d.DayStart                 = p.DayStart                               ?   p.DayStart                         : null;
        d.DayFinish                 = p.DayFinish                               ?   p.DayFinish                         : null;
        d.MonthStart                 = p.MonthStart                               ?   p.MonthStart                         : null;
        d.MonthFinish                 = p.MonthFinish                               ?   p.MonthFinish                         : null;
        d.isActive                      = checkType(p.isActive)                         ?   Boolean(p.isActive)                     : false;
    }
}

const model = new astTimeGroupItemsModel();
module.exports = model;
