const Measures = {
    data: { Name: `measurement`, Small: ``} ,
    url   : "/Measures",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Us/Measures/Views/All.html',
            controller: 'MeasuresCtrl'
        }
    }
};
const MeasuresNew = {
    data: { Name: `measurement`, Small: ``} ,
    url   : "/MeasuresNew",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Us/Measures/Views/New.html',
            controller: 'MeasuresNewCtrl'
        }
    }
};
const MeasuresEdit = {
    data: { Name: `measurement`, Small: ``} ,
    url   : "/MeasuresEdit/{msID:[0-9]{1,30}}",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Us/Measures/Views/Edit.html',
            controller: 'MeasuresEditCtrl'
        }
    }
};