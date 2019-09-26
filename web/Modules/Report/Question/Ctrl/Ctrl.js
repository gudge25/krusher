crmUA.controller('QCtrl', function($scope, $filter,$translate,$rootScope) {

    $scope.manyAction =  new QReportViewMode($scope, $filter);
    
    var date = new Date();
  
    $scope.categories = [$filter('translate')('Jan'), $filter('translate')('Feb'), $filter('translate')('Mar'), $filter('translate')('Apr'), $filter('translate')('May'),
        $filter('translate')('Jun'), $filter('translate')('Jul'), $filter('translate')('Aug'), $filter('translate')('Sep'), $filter('translate')('Oct'), $filter('translate')('Nov'),
        $filter('translate')('Dec')];

    $scope.shag = [
        { "ID" : null,  },
        { "ID" : 1,     },
        { "ID" : 2,     },
        { "ID" : 3,     },
        { "ID" : 4,     },
        { "ID" : 5,     }
    ];
    var trans = () => {
        $translate(['noStep', 'byhour', 'byday', 'byweek', 'bymonth', 'byyear','Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']).then(a => {
            [$scope.shag[0].Name, $scope.shag[1].Name, $scope.shag[2].Name, $scope.shag[3].Name, $scope.shag[4].Name, $scope.shag[5].Name] = [a.noStep,
            a.byhour, a.byday, a.byweek, a.bymonth, a.byyear];
            [$scope.categories[0], $scope.categories[1], $scope.categories[2], $scope.categories[3], $scope.categories[4], $scope.categories[5], $scope.categories[6], $scope.categories[7],
            $scope.categories[8], $scope.categories[9], $scope.categories[10], $scope.categories[11]] = [a.Jan, a.Feb, a.Mar, a.Apr, a.May, a.Jun, a.Jul, a.Aug, a.Sep, a.Oct, a.Nov, a.Dec];
        });
    };
    trans();
    $rootScope.$on('$translateChangeSuccess', () => {
        trans();
    });

    $scope.stats = [];
    new fmFormTypeLookupSrv().getAll(cb =>   {
        $scope.formTypes = cb;
        if(cb.length == 1) {
            $scope.model.tpID = cb[0].tpID;
            $scope.getForms($scope.model);
        }
        $scope.$apply();
    });

    $scope.getForms = model =>{     
        if(model)
        if(model.tpID)
        {   
            $scope.global.Loading = true;
            if(model.Step === "") model.Step =null;
            new fmQuestionReportSrv().getFind( model, cb => {
                if(cb.length > 0){
                    $scope.stats = cb;

                    angular.forEach($scope.stats, todo => {
                        //model.qID = todo.qID;
                        let model2 = angular.copy(model);
                        model2 .qID = todo.qID;
                        new fmQuestionItemsReportSrv().getFind(model2, cb2 => {
                            todo.Question = cb2;
                            $scope.global.Loading = false;
                            $scope.$apply();
                        });
                    });

                    $scope.group   = _.groupBy($scope.stats, 'Period');

                    angular.forEach($scope.formTypes, todo => {
                        if(todo.tpID == model.tpID) $scope.formTypesD = todo;
                    });
                    $scope.$apply();
                }    
                else {
                    $scope.stats = [];
                    $scope.group = [];
                    $scope.formTypesD = [];
                    $scope.global.Loading = false;
                    $scope.$apply();
                }
            });
        }
    };
    //FORM EXPORT
  
    // $scope.fm = new fmExportModel({
    //     "DateFrom"  : $filter('date')(new Date(date.getFullYear(), date.getMonth(), 1),'yyyy-MM-dd'), 
    //     "DateTo"    : $filter('date')(new Date(),'yyyy-MM-dd'),
    // }).postFind();

	$scope.ExportForms = () => {
        //postFind
        //new fmExportSrv().fileDownload(ffID,ptID); //.then( (a,b,c) => { console.log(a); console.log(b); console.log(c); } );
        new fmExportSrv().download($scope.model);
    };

    $scope.billing = {
        "date"  : $filter('date')(new Date(),'yyyy-MM-dd'),
        "date2" : $filter('date')(new Date(),'yyyy-MM-dd'),
    };

    //billing
	$scope.ExportBilling = a => {
        new ccBillingSrv().fileDownload(a);
    };

    $scope.ClearFilter = () => {
        //FORM EXPORT
        $scope.fm = new fmExportModel({
            "DateFrom"  : $filter('date')(new Date(date.getFullYear(), date.getMonth(), 1),'yyyy-MM-ddT00:00:00'), 
            "DateTo"    : $filter('date')(new Date(),'yyyy-MM-ddT23:59:59'),
        }).postFind();
        //FORM Search  
        $scope.model = new fmQuestionReportModel({
            "DateFrom"  : $filter('date')(new Date(date.getFullYear(), date.getMonth(), 1),'yyyy-MM-ddT00:00:00'), 
            "DateTo"    : $filter('date')(new Date(),'yyyy-MM-ddT23:59:59'),
        }).postFind();
    };
    $scope.ClearFilter();
 
});