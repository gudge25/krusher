const Queue = {
    data: { Name: `queues`, Small: ``} ,
    url   : "/Queue",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Asterisk/Queue/Views/All.html',
            controller: 'QueueCtrl'
        }
    }
};
const QueueNew = {
    data: { Name: `queue`, Small: ``} ,
    url   : "/QueueNew",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Asterisk/Queue/Views/New.html',
            controller: 'QueueNewCtrl'
        }
    }
};
const QueueEdit = {
    data: { Name: `queue`, Small: ``} ,
    url   : "/QueueEdit/{queID:[0-9]{1,10}}",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Asterisk/Queue/Views/Edit.html',
            controller: 'QueueEditCtrl'
        }
    }
};