const Sippeers = {
    data: { Name: `SIP`, Small: ``} ,
    url: "/SIP",
    views: {
        "viewA": {
            templateUrl: Gulp + 'Asterisk/SIP/Views/All.html',
            controller: 'SIPCtrl'
        }
    }
};
const SippeersNew = {
    data: { Name: `SIP`, Small: ``} ,
    url: "/SIPNew",
    views: {
        "viewA": {
            templateUrl: Gulp + 'Asterisk/SIP/Views/New.html',
            controller: 'SIPCtrlNew'
        }
    }
};
const SippeersEdit =  {
    data: { Name: `SIP`, Small: ``} ,
    url: "/SIPEdit/{sipID:[0-9]{1,10}}/:sipName",
    views: {
        "viewA": {
            templateUrl: Gulp + 'Asterisk/SIP/Views/Edit.html',
            controller: 'SIPCtrlEdit'
        }
    }
};