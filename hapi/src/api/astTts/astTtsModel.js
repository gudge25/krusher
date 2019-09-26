/*jshint node:true*/
'use strict';
const Model = require('src/base/BaseModel');
const BaseDAO = require('src/base/BaseDao');
const checkType = require('src/util/checkType');

class astTtsModel extends BaseDAO {
    constructor() {
        const storedProc = {
            Find : `ast_GetTts`,
            Insert: `ast_InsTts`,
            Update: `ast_UpdTts`,
            Delete: `ast_DelTts`,
        };
        super(storedProc);

        this.Insert     = Insert;
        this.Update     = Update;
        this.FindPost   = FindPost;
        this.FindPostIn = FindPostIn;
    }
}

class FindPostIn extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token = p.token;
        d.ttsID = p.ttsID;
        d.ttsName = p.ttsName;
        d.engID = p.engID;
        d.ttsFields = p.ttsFields ? p.ttsFields.filter(x => x).join() : null;
        d.isActive = p.isActive === 'null' ? false : p.isActive;
        d.sorting = p.sorting ? p.sorting : null;
        d.field = p.field ? p.field : null;
        d.offset = p.offset ? p.offset : null;
        d.limit = p.limit ? p.limit : null;
    }
}

class FindPost extends Model.Get {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.HIID = p.HIID !== undefined ? p.HIID : null;
        d.token = p.token;
        d.ttsID = p.ttsID;
        d.ttsName = p.ttsName;
        d.ttsText = p.ttsText;
        d.settings = JSON.parse(p.settings);
        d.engID = p.engID;
        d.ttsFields = p.ttsFields;
        d.recIDBefore = p.recIDBefore;
        d.recIDAfter = p.recIDAfter;
        d.yandexApikey = p.yandexApikey;
        d.yandexEmotion = p.yandexEmotion;
        d.yandexEmotions = p.yandexEmotions;
        d.yandexFast = p.yandexFast ? Boolean(p.yandexFast[0]) : null;
        d.yandexGenders = p.yandexGenders;
        d.yandexLang = p.yandexLang;
        d.yandexSpeaker = p.yandexSpeaker;
        d.yandexSpeakers = p.yandexSpeakers;
        d.yandexSpeed = p.yandexSpeed;
        d.isActive = checkType(p.isActive[0]) ? Boolean(p.isActive[0]) : null;
    }
}

class Insert extends Model.Post {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token = p.token;
        d.ttsID = p.ttsID;
        d.ttsName = p.ttsName;
        d.ttsText = p.ttsText;
        d.settings = JSON.stringify(p.settings);
        d.engID = p.engID;
        d.ttsFields = p.ttsFields ? p.ttsFields.filter(x => x).join() : null;
        d.recIDBefore = p.recIDBefore ?   p.recIDBefore.filter(x => x).join()              : '';
        d.recIDAfter = p.recIDAfter ?   p.recIDAfter.filter(x => x).join()              : '';
        d.yandexApikey = p.yandexApikey;
        d.yandexEmotion = p.yandexEmotion;
        d.yandexEmotions = p.yandexEmotions;
        d.yandexFast = p.yandexFast;
        d.yandexGenders = p.yandexGenders;
        d.yandexLang = p.yandexLang;
        d.yandexSpeaker = p.yandexSpeaker;
        d.yandexSpeakers = p.yandexSpeakers;
        d.yandexSpeed = p.yandexSpeed;
        d.isActive                      = checkType(p.isActive)                         ?   Boolean(p.isActive)                     : null;
    }
}
class Update extends Model.Put {
    constructor(p) {
        super(p);
        const d = this.Data;
        d.token = p.token;
        d.HIID = p.HIID;
        d.ttsID = p.ttsID;
        d.ttsName = p.ttsName;
        d.ttsText = p.ttsText;
        d.settings = JSON.stringify(p.settings);
        d.engID = p.engID;
        d.ttsFields = p.ttsFields ? p.ttsFields.filter(x => x).join() : null;
        d.recIDBefore = p.recIDBefore ?   p.recIDBefore.filter(x => x).join()              : '';
        d.recIDAfter = p.recIDAfter ?   p.recIDAfter.filter(x => x).join()              : '';
        d.yandexApikey = p.yandexApikey;
        d.yandexEmotion = p.yandexEmotion;
        d.yandexEmotions = p.yandexEmotions;
        d.yandexFast = p.yandexFast;
        d.yandexGenders = p.yandexGenders;
        d.yandexLang = p.yandexLang;
        d.yandexSpeaker = p.yandexSpeaker;
        d.yandexSpeakers = p.yandexSpeakers;
        d.yandexSpeed = p.yandexSpeed;
        d.isActive                      = checkType(p.isActive)                         ?   Boolean(p.isActive)                     : null;
    }
}

const model = new astTtsModel();
module.exports = model;

//JDI model from WEB
// class astRouteIncModel extends BaseModelNew {
//     constructor(p) {
//         p = p ? p : {};
//         super(p);
//         this.p = p;
//         this.rtID           = p.rtID        ? p.rtID    : null ;
//         this.Aid            = p.Aid         ? p.Aid     : null ;
//         this.trID           = p.trID        ? p.trID    : null ;
//         this.DID            = p.DID         ? p.DID     : null ;
//         this.exten          = p.exten       ? p.exten   : null ;
//         this.context        = p.context     ? p.context : null ;
//         this.Action         = p.Action      ? p.Action  : null ;
//         this.isActive       = p.isActive    ? p.isActive: null ;
//     }

//     get(){
//         super.get();
//         let p = this.p; delete this.p;
//         return this;
//     }

//     postFind(){
//         super.postFind();
//         let p = this.p; delete this.p;
//         return this;
//     }

//     put(){
//         super.put();
//         let p = this.p; delete this.p;
//         return this;
//     }

//     post(){
//         super.post();
//         let p = this.p; delete this.p;
//         delete this.rtID;
//         this.context        = p.context     ? p.context : `office` ;
//         this.isActive       = p.isActive    ? p.isActive: true ;
//         return this;
//     }
// }