var Qreport = {
	data: { Name: `statistics`, Small: `byForms`} ,
    url   : "/Qreport",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Report/Question/Views/Report.html',
            controller  : 'QCtrl'
        }
    }
};