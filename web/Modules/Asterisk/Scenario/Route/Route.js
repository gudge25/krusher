const Scenario = {
    data: { Name: `scenario`, Small: ``} ,
    url   : "/Scenario",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Asterisk/Scenario/Views/All.html',
            controller: 'ScenarioCtrl'
        }
    }
};
const ScenarioNew = {
    data: { Name: `scenario`, Small: ``} ,
    url   : "/ScenarioNew",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Asterisk/Scenario/Views/New.html',
            controller: 'ScenarioNewCtrl'
        }
    }
};
const ScenarioEdit = {
    data: { Name: `scenario`, Small: ``} ,
    url   : "/ScenarioEdit/{id_scenario:[0-9]{1,10}}",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Asterisk/Scenario/Views/Edit.html',
            controller: 'ScenarioEditCtrl'
        }
    }
};