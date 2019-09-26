const CompletionAdd = {
    url   : "/Completion",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Dc/Completion/Views/CompletionAddView.html',
            controller  : 'CompletionAddCtrl'
        }
    }
};

const CompletionEdit = {
    url   : "/Completion/{dcID:[0-9]{1,10}}",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Dc/Completion/Views/CompletionEditView.html',
            controller  : 'CompletionEditCtrl'
        }
    }
};