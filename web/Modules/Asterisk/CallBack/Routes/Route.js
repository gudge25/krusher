const CallBack = {
    data: { Name: `CallBack`, Small: ``} ,
    url         : "/CallBack",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Asterisk/CallBack/Views/All.html',
            controller  : 'CallBackCtrl'
        }
    }
};
const CallBackEdit = {
    data: { Name: `CallBack`, Small: ``} ,
    url         : "/CallBackEdit/{cbID:[0-9]{1,10}}",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Asterisk/CallBack/Views/Edit.html',
            controller  : 'CallBackEditCtrl'
        }
    }
};
const CallBackNew = {
    data: { Name: `CallBack`, Small: ``} ,
    url         : "/CallBackNew",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Asterisk/CallBack/Views/New.html',
            controller  : 'CallBackCtrlNew'
        }
    }
};