class astTimeGroupItemsModel extends BaseModel {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.tgID           = p.tgID            ? parseInt(p.tgID)              : null ;
        this.tgiID          = p.tgiID           ? parseInt(p.tgiID)             : null ;
        this.TimeStart      = p.TimeStart       ? p.TimeStart                   : null ;
        this.TimeFinish     = p.TimeFinish      ? p.TimeFinish                  : null ;
        this.DayStart       = p.DayStart        ? p.DayStart.toString()         : null ;
        this.DayFinish      = p.DayFinish       ? p.DayFinish.toString()        : null ;
        this.DayNumStart    = p.DayNumStart     ? parseInt(p.DayNumStart)       : null ;
        this.DayNumFinish   = p.DayNumFinish    ? parseInt(p.DayNumFinish)      : null ;
        // this.WeekBegin      = p.WeekBegin       ? parseInt(p.WeekBegin)         : null ;
        // this.WeekEnd        = p.WeekEnd         ? parseInt(p.WeekEnd)           : null ;
        this.MonthStart     = p.MonthStart      ? p.MonthStart.toString()       : null ;
        this.MonthFinish    = p.MonthFinish     ? p.MonthFinish.toString()      : null ;
     }

    put(){
        super.put();
        let p = this.p; delete this.p;
        this.TimeStart      = p.TimeStart       ? p.TimeStart                 : `08:00:00`;
        this.TimeFinish     = p.TimeFinish      ? p.TimeFinish                : `20:00:00`;
        this.DayStart       = p.DayStart        ? p.DayStart.toString()       : null ;
        this.DayFinish      = p.DayFinish       ? p.DayFinish.toString()      : null ;
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.tgiID          = p.tgiID           ? parseInt(p.tgiID)   : lookUp(API.us.Sequence, 'tgiID').seqValue;
        return this;
    }
}