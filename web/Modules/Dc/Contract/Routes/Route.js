const Contract = {
    url   : "/Contract",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Dc/Contract/Views/ContractView.html',
            controller  : 'ContractCtrl'
        }
    }
};

const ContractEdit = {
    url   : "/Contract/{dcID:[0-9]{1,10}}",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Dc/Contract/Views/ContractEditView.html',
            controller  : 'ContractEditCtrl'
        }
    }
};