const formsAll = {
    data  : { Name: `forms`, Small: `holdingCustomerQuestionnaires`} ,
    url: "/formsAll",
    views: {
        "viewA": {
            templateUrl: Gulp + 'Questions/Forms/Views/All.html',
            controller: 'fmFormsAllCtrl'
        }
    }
};
const formEdit = {
    data  : { Name: `forms`, Small: `crEdit`} ,
    url: "/formEdit",
    views: {
        "viewA": {
            templateUrl: Gulp + 'Questions/Forms/Views/FormEdit.html',
            controller: 'fmFormEditCtrl'
        }
    }
};
const form = {
    data  : { Name: `forms`, Small: `conductCustomQuest`} ,
    url: "/form/:dcID",
    views: {
        "viewA": {
            templateUrl: Gulp + 'Questions/Forms/Views/PreView.html',
            controller: 'fmFormCtrl'
        }
    }
};