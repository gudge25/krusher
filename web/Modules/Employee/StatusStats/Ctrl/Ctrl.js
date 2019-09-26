crmUA.controller('emEmployeeStatusStatsCtrl', function($scope, $filter, Auth, $translate, $rootScope, $timeout, AclService) {
    $scope.Auth = Auth.FFF;

    //Defaul tab show
    $scope.b = 1;
    $scope.total = {};
    $scope.total2 = {};
    $scope.total3 = {};
    $scope.total4 = {};
    $scope.total5 = {};
    $scope.additional = false;
    $scope.manyAction =  new StatusStatsViewMode($scope, $timeout, $filter, $rootScope,AclService,$translate);
   
    var coIDs;
    if($scope.Auth.coIDs)
    if($scope.Auth.coIDs.length > 0){
        coIDs = angular.copy($scope.Auth.coIDs);
    }

    //MODELS
    $scope.model = new emEmployeeStatusStatModel().postFindNotMap();
    $scope.model.isActive = true;
    $scope.manyAction.Find();
    $scope.model2 = new emEmployeeCounterModel().postFindNotMap();
    $scope.model3 = new ccDailyReportModel({coIDs}).postFindNotMap();
    $scope.model4 = new ccDailyReportCallsModel({coIDs}).postFindNotMap();
    $scope.model5 = new ccDailyReportStatusesModel({coIDs}).postFindNotMap();
    $scope.model6 = new ccAnalize1ReportModel({coIDs}).postFindNotMap();

    $scope.shag = [{ "ID" : 0, "Name": 'byhour' }, { "ID" : 1, "Name": 'byday'}];


    $scope.tabset = a => {
        $scope.b = a;
        switch(a){
            case 1  :   $scope.manyAction.Find(); break;
            case 2  :   if($scope.order2) {
                            $scope.model2.field = $scope.order2;
                            $scope.model2.sorting = $scope.reverse2? `ASC` : `DESC`;
                        }
                        new emEmployeeCounterSrv().ins($scope.model2,(cb,status,request) => { 
                            $scope.data2 = cb;
                            $scope.total2.count = request.getResponseHeader(`total-count`);
                            $scope.global.Loading = false; 
                            $scope.$apply();
                        }); 
                        break;
            case 3  :   new ccDailyReportSrv().ins($scope.model3,(cb,status,request) => { 
                            $scope.data3 = cb; 
                            $scope.total3 = {
                                att : request.getResponseHeader(`att`),
                                count : request.getResponseHeader(`total-count`),
                                aht : request.getResponseHeader(`aht`),
                                callscount : request.getResponseHeader(`callscount`),
                                lcr : request.getResponseHeader(`lcr`),
                                lostbefore20sec : request.getResponseHeader(`lostbefore20sec`),
                                lostbefore20secpercent : request.getResponseHeader(`lostbefore20secpercent`),
                                lostbefore30sec : parseInt(request.getResponseHeader(`lostbefore30sec`)),
                                lostbefore30secpercent : request.getResponseHeader(`lostbefore30secpercent`),
                                lostbefore60sec : parseInt(request.getResponseHeader(`lostbefore60sec`)),
                                lostbefore60secpercent : request.getResponseHeader(`lostbefore60secpercent`),
                                lostcalls : request.getResponseHeader(`lostcalls`),
                                receivedbefore20sec : request.getResponseHeader(`receivedbefore20sec`),
                                receivedbefore20secpercent : request.getResponseHeader(`receivedbefore20secpercent`),
                                receivedcalls : request.getResponseHeader(`receivedcalls`),
                                sl : request.getResponseHeader(`sl`),
                                receivedbefore30sec : parseInt(request.getResponseHeader(`receivedbefore30sec`)),
                                receivedbefore30secpercent : request.getResponseHeader(`receivedbefore30secpercent`),
                                receivedbefore60sec : parseInt(request.getResponseHeader(`receivedbefore60sec`)),
                                receivedbefore60secpercent : request.getResponseHeader(`receivedbefore60secpercent`),
                                receivedafter60sec : request.getResponseHeader(`receivedafter60sec`),
                                receivedafter60secpercent : request.getResponseHeader(`receivedafter60secpercent`),
                                lostafter60sec : request.getResponseHeader(`lostafter60sec`),
                                lostafter60secpercent : request.getResponseHeader(`lostafter60secpercent`)
                            };
                            $scope.global.Loading = false;
                            $scope.$apply(); 
                        }); break;
            case 4 :    new cccDailyReportCallsSrv().ins($scope.model4,(cb,status,request) => { 
                            $scope.data4 = cb; 
                            $scope.total4 = {
                                count : request.getResponseHeader(`total-count`)
                            };
                            $scope.global.Loading = false;
                            $scope.$apply(); 
                        }); break;

            case 5 :    new ccDailyReportStatusesSrv().ins($scope.model5,(cb,status,request) => { 
                            $scope.data5 = cb; 
                            $scope.group5 = _.groupBy(cb, 'status');
                            //console.log($scope.group5);
                            $scope.total5 = {
                                count : request.getResponseHeader(`total-count`)
                            };
                            $scope.global.Loading = false;
                            $scope.$apply(); 
                        }); break;
                        
            case 6  :   new ccAnalize1ReportSrv().ins($scope.model6,(cb,status,request) => { 
                            $scope.data6 = cb; 
                            $scope.total6 = {
                                att : request.getResponseHeader(`att`),
                                count : request.getResponseHeader(`total-count`),
                                aht : request.getResponseHeader(`aht`),
                                callscount : request.getResponseHeader(`callscount`),
                                lcr : request.getResponseHeader(`lcr`),
                                lostbefore5sec : request.getResponseHeader(`lostbefore5sec`),
                                LostBefore5secPercent : request.getResponseHeader(`LostBefore5secPercent`),
                                lostbefore30sec : parseInt(request.getResponseHeader(`lostbefore30sec`)),
                                lostbefore30secpercent : request.getResponseHeader(`lostbefore30secpercent`),
                                
                                lostcalls : request.getResponseHeader(`lostcalls`),
                                receivedbefore20sec : request.getResponseHeader(`receivedbefore20sec`),
                                receivedbefore20secpercent : request.getResponseHeader(`receivedbefore20secpercent`),
                                receivedcalls : request.getResponseHeader(`receivedcalls`),
                                sl : request.getResponseHeader(`sl`),
                                receivedbefore30sec : parseInt(request.getResponseHeader(`receivedbefore30sec`)),
                                receivedbefore30secpercent : request.getResponseHeader(`receivedbefore30secpercent`),
                                
                                receivedafter30sec : parseInt(request.getResponseHeader(`receivedafter30sec`)),
                                receivedafter30secpercent : request.getResponseHeader(`receivedafter30secpercent`),
                                lostafter30sec : parseInt(request.getResponseHeader(`lostafter30sec`)),
                                lostafter30secpercent : request.getResponseHeader(`lostafter30secpercent`),

                                ht : request.getResponseHeader(`ht`),
                                recalls : request.getResponseHeader(`recalls`),
                                rlcr : request.getResponseHeader(`rlcr`)
                            };
                            $scope.global.Loading = false;
                            $scope.$apply(); 
                        }); break;            

                       // Analize1
            default :   break;
        }
    };

    $scope.orderF = a => {
        $scope.order2 = a;
        $scope.reverse2 = $scope.reverse2 ? false : true;
    };

    $scope.Clear = b => {
        switch(b){
            case 1  :   $scope.model = new emEmployeeStatusStatModel().postFindNotMap();    break;
            case 2  :   $scope.model2 = new emEmployeeCounterModel().postFindNotMap();      break;
            case 3  :   $scope.model3 = new ccDailyReportModel({coIDs}).postFindNotMap();          break;
            case 4  :   $scope.model4 = new ccDailyReportCallsModel({coIDs}).postFindNotMap();     break;
            case 5  :   $scope.model5 = new ccDailyReportStatusesModel({coIDs}).postFindNotMap();  break;
            case 6  :   $scope.model6 = new ccAnalize1ReportModel({coIDs}).postFindNotMap();       break;
            default :   break;
        }    
        if(b)  $scope.tabset(b);
    };

    $scope.Export = b => {
        console.log(b);
        switch(b){
            case 1  :  new emEmployeeStatusStatExportSrv().download($scope.model);     break;
            case 2  :  new emEmployeeCounterExportSrv().download($scope.model2);       break;
            case 3  :  if($scope.data3) if($scope.data3.length > 0 ) new ccDailyReportExportSrv().download($scope.model3);           break;
            case 4  :  if($scope.data4) if($scope.data4.length > 0 ) new ccDailyCallsExportSrv().download($scope.model4);     break;
            case 5  :  if($scope.data5) if($scope.data5.length > 0 ) new ccDailyStatusesExportSrv().download($scope.model5);   break;
            case 6  :  if($scope.data6) if($scope.data6.length > 0 ) new ccAnalize1ExportSrv().download($scope.model6);        break;
            default :   break;
        }    
    };

    $scope.ExportShow = b => {
        let a = false;
        switch(b){
            case 1  :  break;
            case 2  :  break;
            case 3  :  if($scope.data3) if($scope.data3.length > 0 ) a = true; break;
            case 4  :  if($scope.data4) if($scope.data4.length > 0 ) a = true; break;
            case 5  :  if($scope.data5) if($scope.data5.length > 0 ) a = true; break;
            case 6  :  if($scope.data6) if($scope.data6.length > 0 ) a = true; break;
            default :   break;
        }    
        return a;
    };

    $scope.addClass = a => {
         $scope.statusDate = a;
    };

    $scope.removeClass = () => {
        if(!$scope.Single)
            $scope.statusDate = null;
    };
    $scope.Single = false;
    $scope.showSingle = a => {
        $scope.statusDate = a;
        $scope.Single = $scope.Single ? false : true;
        if(!$scope.Single)  $scope.statusDate = null;
    };
});