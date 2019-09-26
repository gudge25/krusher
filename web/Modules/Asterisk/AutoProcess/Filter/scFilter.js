crmUA.filter('scFilters', function() {
    return input => {
        let a;
            let Scenarios = FactScenarioRun.name;
            angular.forEach(Scenarios.data, todo => {
                if(todo.id_scenario == input) {  a = todo.name_scenario;  }
            });
        return a;
    };
});

//CallStatus
crmUA.filter('ProcessStatus', function($filter, $translate) {
    return function(input) {
        switch (input){
            case 101601     : { var input = { "disposition" : $filter('translate')('New')       ,	"color" : "badge-default" };	break; }

            case 101602     : { var input = { "disposition" : $filter('translate')('Progress')	,	"color" : "badge-info" };		break; }

            case 101603     : { var input = { "disposition" : $filter('translate')('Stoped')    ,	"color" : "badge-danger" };		break; }

            case 101604   	: { var input = { "disposition" : $filter('translate')('Finished')	,	"color" : "badge-success" };	break; }

            default         : { var input = { "disposition" : input ,	"color" : "badge-primary" };    break; }
        }
        return input;
    };
});