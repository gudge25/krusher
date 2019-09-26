app.config(function($stateProvider) {
    $stateProvider
        .state('index', {
            url : "/",
            templateUrl : "Modules/Menu/Views/index.html"
        }).state('route2', {
            url : "/users",
            templateUrl : "Modules/User/Views/users.html",
            controller : 'Users'
        }).state('route3', {
            url : "/statistica",
            templateUrl : "Modules/Statistic/Views/cdr.html",
            controller : 'CDR'
        }).state('route4', {
            url : "/clients",
            templateUrl : "Modules/Client/Views/clients.html",
            controller : 'Clients'
        })
        .state('manual', {
            url : "/manual",
            templateUrl : "Modules/Manual/Views/manual.html",
            controller : 'Manual'
        })
        .state('cli', {
            url : "/cli",
            templateUrl : "Modules/Cli/Views/cli.html",
            controller : 'Cli'
        })
        .state('route6', {
            url : "/queuelog",
            templateUrl : "Modules/Queue/Views/queue_log.html",
            controller : 'QueueLog'
        })
});
