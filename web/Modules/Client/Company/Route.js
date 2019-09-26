const Company = {
    data: { Name: `companys`, Small: ``} ,
    url   : "/Company",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Client/Company/Views/All.html',
            controller: 'crmCompanyCtrl'
        }
    }
};
const CompanyNew = {
    data: { Name: `companys`, Small: ``} ,
    url   : "/CompanyNew",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Client/Company/Views/New.html',
            controller: 'crmCompanyNewCtrl'
        }
    }
};
const CompanyEdit = {
    data: { Name: `companys`, Small: ``} ,
    url   : "/CompanyEdit/{coID:[0-9]{1,10}}",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Client/Company/Views/Edit.html',
            controller: 'crmCompanyEditCtrl'
        }
    }
};