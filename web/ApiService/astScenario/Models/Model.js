class astScenarioModel extends BaseModelRoute {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.id_scenario                   = p.id_scenario                                 ?   parseInt(p.id_scenario)                  : null;
        this.name_scenario                 = p.name_scenario                               ?   p.name_scenario.toString()               : null;
        this.callerID                      = p.callerID                                    ?   p.callerID.toString()                    : null;
        this.TimeBegin                     = p.TimeBegin                                   ?   p.TimeBegin.toString()                   : null;
        this.TimeEnd                       = p.TimeEnd                                     ?   p.TimeEnd.toString()                     : null;
        this.DaysCall                      = p.DaysCall                                    ?   p.DaysCall.toString()                    : null;
        this.RecallCount                   = p.RecallCount                                 ?   parseInt(p.RecallCount)                  : null;
        this.RecallAfterMin                = p.RecallAfterMin !== undefined                ?   parseInt(p.RecallAfterMin)               : null;
        this.RecallCountPerDay             = p.RecallCountPerDay                           ?   parseInt(p.RecallCountPerDay)            : null;
        this.RecallDaysCount               = p.RecallDaysCount                             ?   parseInt(p.RecallDaysCount)              : null;
        this.RecallAfterPeriod             = p.RecallAfterPeriod                           ?   parseInt(p.RecallAfterPeriod)            : null;
        this.AutoDial                      = p.AutoDial                                    ?   p.AutoDial.toString()                    : null;
        this.IsRecallForSuccess            = isBoolean(p.IsRecallForSuccess)               ?   Boolean(p.IsRecallForSuccess)            : null;
        this.IsCallToOtherClientNumbers    = isBoolean(p.IsCallToOtherClientNumbers)       ?   Boolean(p.IsCallToOtherClientNumbers)    : null;
        this.IsCheckCallFromOther          = isBoolean(p.IsCheckCallFromOther)             ?   Boolean(p.IsCheckCallFromOther)          : null;
        this.AllowPrefix                   = p.AllowPrefix                                 ?   p.AllowPrefix                            : null;
        this.target                        = p.target                                      ?   p.target.toString()                      : null;
        this.isFirstClient                 = isBoolean(p.isFirstClient)                    ?   Boolean(p.isFirstClient)                 : null;
        this.roIDs                         = p.roIDs                                       ?   p.roIDs                                  : null;
        this.limitChecker                  = p.limitChecker                                ?   parseInt(p.limitChecker)                 : null;
        this.limitStatuses                 = p.limitStatuses                               ?   p.limitStatuses                          : null;
    }

    get(){
        super.get();
        let  p = this.p; delete this.p;
        this.DaysCall                       = p.DaysCall                                    ?  p.DaysCall.split(",").map( a => parseInt(a) )        : [];
        this.roIDs                          = p.roIDs                                       ?  p.roIDs.split(",").map( a => parseInt(a) )           : [];
        this.AllowPrefix                    = p.AllowPrefix                                 ?  p.AllowPrefix.split(",").map( a => a.toString() )    : [];
        this.limitStatuses                  = p.limitStatuses                               ?  p.limitStatuses.split(",").map( a => parseInt(a) )   : [];

        return this;
    }

    put(){
        super.put();
        let p = this.p; delete this.p;
        this.isActive                      = isBoolean(p.isActive)                         ?   Boolean(p.isActive)                      : true;
        this.TimeBegin                     = p.TimeBegin                                   ?   p.TimeBegin.toString()                   : `09:00:00`;
        this.TimeEnd                       = p.TimeEnd                                     ?   p.TimeEnd.toString()                     : `21:00:00`;
        this.DaysCall                      = p.DaysCall                                    ?   p.DaysCall.join()                        : [1,2,3,4,5,6,7];
        this.RecallCount                   = p.RecallCount                                 ?   parseInt(p.RecallCount)                  : 20;
        this.RecallAfterMin                = p.RecallAfterMin !== undefined                ?   parseInt(p.RecallAfterMin)               : 60;
        this.RecallCountPerDay             = p.RecallCountPerDay                           ?   parseInt(p.RecallCountPerDay)            : 2;
        this.RecallDaysCount               = p.RecallDaysCount                             ?   parseInt(p.RecallDaysCount)              : 7;
        this.RecallAfterPeriod             = p.RecallAfterPeriod                           ?   parseInt(p.RecallAfterPeriod)            : 1;
        this.IsRecallForSuccess            = isBoolean(p.IsRecallForSuccess)               ?   Boolean(p.IsRecallForSuccess)            : false;
        this.IsCallToOtherClientNumbers    = isBoolean(p.IsCallToOtherClientNumbers)       ?   Boolean(p.IsCallToOtherClientNumbers)    : false;
        this.IsCheckCallFromOther          = isBoolean(p.IsCheckCallFromOther)             ?   Boolean(p.IsCheckCallFromOther)          : false;
        this.isFirstClient                 = isBoolean(p.isFirstClient)                    ?   Boolean(p.isFirstClient)                 : true;
        this.roIDs                         = p.roIDs                                       ?   p.roIDs                                  : [];
        return this;
    }

    post(){
        super.post();
        let p = this.p; delete this.p;
        this.id_scenario                   = p.id_scenario                                 ? parseInt(p.id_scenario)                    : lookUp(API.us.Sequence, 'id_scenario').seqValue;
        this.isActive                      = isBoolean(p.isActive)                         ?   Boolean(p.isActive)                      : true;
        this.TimeBegin                     = p.TimeBegin                                   ?   p.TimeBegin                              : `09:00:00`;
        this.TimeEnd                       = p.TimeEnd                                     ?   p.TimeEnd                                : `21:00:00`;
        this.DaysCall                      = p.DaysCall                                    ?   p.DaysCall.join()                        : `1,2,3,4,5,6,7`;
        this.RecallCount                   = p.RecallCount                                 ?   parseInt(p.RecallCount)                  : 20;
        this.RecallAfterMin                = p.RecallAfterMin !== undefined                ?   parseInt(p.RecallAfterMin)               : 60;
        this.RecallCountPerDay             = p.RecallCountPerDay                           ?   parseInt(p.RecallCountPerDay)            : 2;
        this.RecallDaysCount               = p.RecallDaysCount                             ?   parseInt(p.RecallDaysCount)              : 7;
        this.RecallAfterPeriod             = p.RecallAfterPeriod                           ?   parseInt(p.RecallAfterPeriod)            : 1;
        this.IsRecallForSuccess            = isBoolean(p.IsRecallForSuccess)               ?   Boolean(p.IsRecallForSuccess)            : false;
        this.IsCallToOtherClientNumbers    = isBoolean(p.IsCallToOtherClientNumbers)       ?   Boolean(p.IsCallToOtherClientNumbers)    : false;
        this.IsCheckCallFromOther          = isBoolean(p.IsCheckCallFromOther)             ?   Boolean(p.IsCheckCallFromOther)          : false;
        this.isFirstClient                 = isBoolean(p.isFirstClient)                    ?   Boolean(p.isFirstClient)                 : true;
        this.roIDs                         = p.roIDs                                       ?   p.roIDs                                  : [];
        return this;
    }
}