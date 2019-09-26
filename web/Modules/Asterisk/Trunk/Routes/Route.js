const Trunk = {
    data: { Name: `trunks`, Small: ``} ,
    url: "/Trunk",
    views: {
        "viewA": {
            templateUrl: Gulp + 'Asterisk/Trunk/Views/All.html',
            controller: 'TrunkCtrl'
        }
    }
};
const TrunkNew = {
    data: { Name: `trunk`, Small: ``} ,
    url: "/TrunkNew",
    views: {
        "viewA": {
            templateUrl: Gulp + 'Asterisk/Trunk/Views/New.html',
            controller: 'TrunkCtrlNew'
        }
    }
};
const TrunkEdit =  {
    data: { Name: `trunk`, Small: ``} ,
    url: "/TrunkEdit/{trID:[0-9]{1,10}}",
    views: {
        "viewA": {
            templateUrl: Gulp + 'Asterisk/Trunk/Views/Edit.html',
            controller: 'TrunkCtrlEdit'
        }
    }
};