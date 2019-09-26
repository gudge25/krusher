/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class emEmployStatusModel extends BaseDAO {
    constructor() {
        const storedProc = {
            /*Find: 'em_GetEmployStatus',
            Insert: 'em_InsEmployStatus',*/
            GetStat: 'em_GetEmployStatusStat'
        };
        super(storedProc);

  /*      this.FindPost = FindPost;
        this.Insert = Insert;*/
        this.Stat = Stat;
        this.StatIn = StatIn;
    }

    repoStat(params, callback) {
        this.execute(this.StoredProc.GetStat, params, callback);
    }
}
/*class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID       = p.HIID !== undefined         ?   p.HIID       : null;
        d.emsID = p.emsID;
        d.emID = p.emID;
        d.onlineStatus = p.onlineStatus;
        d.timeSpent = p.timeSpent;
        d.isActive                      = checkType(p.isActive)                         ?   Boolean(p.isActive)                     : null;
        d.Created               = p.Created                  ?   p.Created.toISOString().replace(/\..+/, '')                : null;
        d.Changed               = p.Changed                  ?   p.Changed.toISOString().replace(/\..+/, '')                : null;
    }
}
class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token = p.token;
        d.emsID = p.emsID;
        d.emID = p.emID;
        d.onlineStatus = p.onlineStatus;
        d.timeSpent = p.timeSpent;
        d.isActive                      = checkType(p.isActive)                         ?   Boolean(p.isActive)                     : null;
    }
}*/
class StatIn extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token = p.token;
        d.DateFrom                = p.DateFrom                  ?   p.DateFrom                : null;
        d.DateTo                = p.DateTo                  ?   p.DateTo                : null;
        d.emIDs                      = p.emIDs                ?   p.emIDs.filter(x => {if(x !== false || x !== null || x !== "" || x > 0 )  return x;}).join()              : '';
        d.onlineStatus = p.onlineStatus;
        d.sorting               = p.sorting                     ?   p.sorting                       : null;
        d.field                 = p.field                       ?   p.field                         : null;
        d.offset                = p.offset                      ?   p.offset                        : null;
        d.limit                 = p.limit                       ?   p.limit                         : null;
    }
}
class Stat extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.dateSpent = p.dateSpent;
        d.dateSpent               = p.dateSpent                  ?   p.dateSpent.toISOString().slice(0,10)                : null;
        d.emID = p.emID;
        d.Available = p.Available;
        d.Unvailable = p.Unvailable;
        d.Pause = p.Pause;
        d.Dinner = p.Dinner;
        d.Meeting = p.Meeting;
        d.Logout = p.Logout;
        d.Other = p.Other;
        d.Post_Processing = p.Post_Processing;
        d.All_State = p.All_State;
    }
}

const model = new emEmployStatusModel();
module.exports = model;
