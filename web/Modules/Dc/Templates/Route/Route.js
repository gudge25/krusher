const Templates = {
    url   : "/Templates",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Dc/Templates/Views/All.html',
            controller: 'TemplatesCtrl'
        }
    }
};
const TemplatesNew = {
    url   : "/TemplatesNew",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Dc/Templates/Views/New.html',
            controller: 'TemplatesNewCtrl'
        }
    }
};
const TemplatesEdit = {
    url   : "/TemplatesEdit/{dctID:[0-9]{1,10}}/{dtID:[0-9]{1,10}}",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Dc/Templates/Views/Edit.html',
            controller: 'TemplatesEditCtrl'
        }
    }
};