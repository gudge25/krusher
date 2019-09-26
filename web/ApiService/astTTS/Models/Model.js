class astTTSModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.ttsID          = p.ttsID !== undefined ?   p.ttsID         : null;
        this.ttsName        = p.ttsName         ?   p.ttsName           : null;
        this.engID          = p.engID           ?   p.engID             : null;
        this.recIDAfter     = p.recIDAfter      ?   p.recIDAfter        : null;
        this.recIDBefore    = p.recIDBefore     ?   p.recIDBefore       : null;
        this.yandexApikey   = p.yandexApikey    ?   p.yandexApikey      : null;
        this.yandexEmotion  = p.yandexEmotion   ?   p.yandexEmotion     : null;
        this.yandexEmotions = p.yandexEmotions  ?   p.yandexEmotions    : null;
        this.yandexFast     = p.yandexFast      ?   p.yandexFast        : null;
        this.yandexGenders  = p.yandexGenders   ?   p.yandexGenders     : null;
        this.yandexLang     = p.yandexLang      ?   p.yandexLang        : null;
        this.yandexSpeaker  = p.yandexSpeaker   ?   p.yandexSpeaker     : null;
        this.yandexSpeakers = p.yandexSpeakers  ?   p.yandexSpeakers    : null;
        this.yandexSpeed    = p.yandexSpeed     ?   p.yandexSpeed       : null;
        this.ttsFields      = p.ttsFields       ?   p.ttsFields         : null;
    }

    get(){
        super.get();
        let  p = this.p; delete this.p;
        this.settings       = p.settings        ? p.settings            : null;
        this.ttsText        = p.ttsText         ? p.ttsText             : null;
        this.recIDAfter     = p.recIDAfter      ? p.recIDAfter.split(",").map( a => parseInt(a) )   : [];
        this.recIDBefore    = p.recIDBefore     ? p.recIDBefore.split(",").map( a => parseInt(a) )  : [];
        this.ttsFields      = p.ttsFields       ? p.ttsFields.split(",").map( a => parseInt(a) )    : [];
        return this;
    }


    put(){
        super.put();
        let p = this.p; delete this.p;
        this.settings       = p.settings        ? p.settings              : {};
        this.ttsText        = p.ttsText         ? p.ttsText               : null;
        this.engID          = p.engID           ? p.engID                 : null;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.ttsID          = p.ttsID           ? p.ttsID                   : lookUp(API.us.Sequence, 'ttsID').seqValue;
        this.settings       = p.settings        ? p.settings                : {};
        this.ttsText        = p.ttsText         ? p.ttsText                 : null;
        return this;
    }

    postFind(){
        super.postFind();
        let p = this.p; delete this.p; delete this.recIDAfter; delete this.recIDBefore; delete this.yandexApikey; delete this.yandexEmotion; delete this.yandexEmotions;
        delete this.yandexFast; delete this.yandexGenders; delete this.yandexLang; delete this.yandexSpeaker; delete this.yandexSpeakers; delete this.yandexSpeed;

        return this;
    }
}
