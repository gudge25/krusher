//CallType
crmUA.filter('CallTypeFilters', function() {
    return input => {
        return input ? 'Исходящий' : 'Входящий';
    };
});

//isActive
crmUA.filter('isActiveFilters', $filter => {
    return input => {
        return input ?  $filter('translate')('true') : $filter('translate')('false');
    };
});

//CallStatus
crmUA.filter('CallStatus', $filter => {
    return input => {
        let res;
        switch(input){
            case 7001 : case "ANSWERED"     : { res = { "disposition" : $filter('translate')('answered')        , "color" : "badge-success" };      break; }
            case 7004 : case "FAILED"       : { res = { "disposition" : $filter('translate')('error')           , "color" : "badge-danger" };       break; }
            case 7003 : case "BUSY"         : { res = { "disposition" : $filter('translate')('busy')            , "color" : "badge-warning" };      break; }
            case 7005 : 
            case "CONGESTION" : 
            case "CHANUNAVAIL"              : { res = { "disposition" : $filter('translate')('noavailable')     , "color" : "badge-info" };         break; }
            case 7002 : case "NO ANSWER"    : { res = { "disposition" : $filter('translate')('didNotAnswer')    , "color" : "badge-secondary" };      break; }
            case 7006 : case "RINGING"      : { res = { "disposition" : $filter('translate')('Ringing')         , "color" : "badge-info" };         break; }
            case 7007 : case "UP"           : { res = { "disposition" : $filter('translate')('Up')              , "color" : "badge-primary" };      break; }
            case 7008 : case "LIMIT"        : { res = { "disposition" : $filter('translate')('LIMIT')           , "color" : "badge-danger" };       break; }
            case 7009 : case "BLOCKED"      : { res = { "disposition" : $filter('translate')('BLOCKED')         , "color" : "badge-danger" };       break; }
            case 7010 : case "CANCEL"       : { res = { "disposition" : $filter('translate')('CANCEL')          , "color" : "badge-secondary" };      break; }
            default                         : { res = { "disposition" :  $filter('translate')(input)    , "color" : "btn-outline-primary" };      break; }
        }
        return res;
    };
});