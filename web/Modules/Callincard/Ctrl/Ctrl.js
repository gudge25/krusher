crmUA.component('callingcardCtrl', {
  bindings: {value: '<'},
  controller: CallingcardCtrl,
  templateUrl: `${Gulp}Callincard/Views/All.html`,
});
function CallingcardCtrl($scope, $timeout,$stateParams, $filter,$sce, $interval, Auth, $compile, $translate, $rootScope, $translatePartialLoader, ngAudio, HotDial, AclService) {
    $scope.manyAction =  new ccContactViewModel($scope, $timeout, $stateParams ,$filter, $translate, $rootScope, ngAudio, AclService);

    $scope.manyAction.showSMS();

    $scope.htmlPopover = a => {
        var [ContactStatus,Comment] = ["",""];
        if(a.ContactStatus) ContactStatus = `<span ng-if="a.ContactStatus"> <b>${$filter('translate')('status')}</b> : ${$filter('translate')(  $filter('enums')(a.ContactStatus)  )} </span> <br/>`;
        if(a.Comment) Comment = `<span ng-if="a.Comment"> <b>${$filter('translate')('note')}</b> : ${a.Comment}</span>`;
        return $sce.trustAsHtml(`${ContactStatus} ${Comment}`);
    };

    $scope.htmlPopover2 = a => {
        var [scenario,process] = ["",""];
        if(a.id_scenario) scenario = `<span ng-if="a.ContactStatus"> <b>${$filter('translate')('scenario')}</b> : ${ a.id_scenario } </span> <br/>`;
        if(a.id_autodial) process = `<span ng-if="a.Comment"> <b>${$filter('translate')('process')}</b> : ${a.id_autodial}</span>`;
        return $sce.trustAsHtml(`${scenario} ${process}`);
    };

    $scope.htmlPopover3 = a => {
        var [talkTime,duration,expectation,serviceLevel] = ["","","",""];
        if(a.billsec)       talkTime = `<span ng-if="a.billsec">            <b>${$filter('translate')('talkTime')}</b> :    <span class="float-right"> ${ a.billsec }</span> </span> <br/>`;
        if(a.duration)      duration = `<span ng-if="a.duration">           <b>${$filter('translate')('duration')}</b> :    <span class="float-right"> ${a.duration}</span> </span> <br/>`;
        if(a.serviceLevel)  expectation = `<span ng-if="a.serviceLevel">    <b>${$filter('translate')('expectation')}</b> : <span class="float-right"> ${a.serviceLevel}</span> </span> <br/>`;
        if(a.holdtime)      serviceLevel = `<span ng-if="a.holdtime">       <b>${$filter('translate')('Hold')}</b> :        <span class="float-right">${a.holdtime}</span></span>`;
        return $sce.trustAsHtml(`${talkTime} ${duration} ${expectation} ${serviceLevel}`);
    };

    //$scope.manyAction.order('Created');
    $scope.reverse = false;

    $scope.MOD = TRIFF;
    $scope.global = {
                    checkAll: false,
                    Loading: false
                };

    $scope.SearchClient = a => {
        if(a) $scope.manyAction.SearchClient(a).then( a => { $scope.ClientData = a; $scope.$apply(); });
    };

    $scope.Pagintion = a => {
                $scope.oldPage = $scope.CurrentPage;
                $scope.CurrentPage = $scope.model.CurrentPage;
                $scope.model.offset = ($scope.model.CurrentPage * $scope.model.limit) - $scope.model.limit ;
                $scope.NextPage = ($scope.model.offset + $scope.model.limit ) / $scope.model.limit ; 
                if($scope.NextPage != $scope.oldPage){
                    $scope.global.Loading = true;
                    $scope.Find($scope.model);
                }
    };
    //$scope.limitList = [{ Name: "10"},{ Name:"15"},{ Name: "20"},{ Name:"25"},{ Name: "50"},{ Name:"75"},{ Name: "100"}];

    var ccCallingCardModel = JSON.parse(localStorage.getItem('ccCallingCardModel'));
    if(ccCallingCardModel){
            $scope.ModelA           = ccCallingCardModel;
            $scope.ModelA.DateFrom  = new Date().toString("yyyy-MM-ddT00:00:00") ;
            $scope.ModelA.DateTo    = null;    
            $scope.ModelA.DateTo    = null;
            $scope.CurrentPage      = $scope.ModelA.CurrentPage;
        if($scope.ModelA.clID)
                new crmClientSrv().get($scope.ModelA.clID, cb => { $scope.searchclient = {}; $scope.searchclient = cb.clName; $scope.$apply();});
    }
    else
        $scope.ModelA ={};

	$scope.Auth = Auth.FFF;
    $scope.HotDial = HotDial;

    $scope.model            = new ccContactModel($scope.ModelA).postFindNotMap();
    $scope.model.isMissed   = false;
    $scope.data             = [];

    $scope.Clear = () => { 
        let coIDs;
        if($scope.Auth.coIDs)
                if($scope.Auth.coIDs.length > 0){
                    coIDs = angular.copy($scope.Auth.coIDs);
                }
                console.log(coIDs);
                console.log($scope.Auth);
        $scope.model = new ccContactModel({coIDs}).postFindNotMap();  $scope.model.limit = 15; 
        $scope.model.convertFormat = 104003;
    };

    $scope.FindNew = a => {
        //console.log(`Find`)
            $timeout(() => {
                $scope.global.Loading=true;
                $scope.$apply();
            },0);
            switch ($scope.model.select){
                case "missed" : 
                case "isMissed"     : { $scope.model.isMissed = true;   $scope.model.isUnique = false;  break; }
                case "isUnique"     : { $scope.model.isMissed = false;  $scope.model.isUnique = true;   break; }
                default             : { [$scope.model.isMissed,$scope.model.isUnique] = [false,false];  break; }
            }

            if(a == `button`) { $scope.CurrentPage = $scope.model.CurrentPage = 1; $scope.model.offset = ($scope.model.CurrentPage * $scope.model.limit) - $scope.model.limit; }

            switch($scope.Auth.roleID){
                //Operator
                case 3: { $scope.model.emIDs = [{emID : EMID }]; break; }
                //Supervizor
                case 2: { if($scope.model.ManageIDs) $scope.model.ManageIDs = [{emID : EMID }]; break; }
                //Admin
                default : break;
            }
            switch($scope.Auth.roleName){
                //Operator
                case `Operator`: { $scope.model.emIDs = [{emID : EMID }]; break; }
                //Supervizor
                case `Supervisor`: { if($scope.model.ManageIDs) $scope.model.ManageIDs = [{emID : EMID }]; break; }
                //Admin && Dev
                default : break;
            }

            if($scope.Auth.coIDs)
                if($scope.Auth.coIDs.length > 0){
                    $scope.model.coIDs = angular.copy($scope.Auth.coIDs);
                }

            if($scope.order)    {
                $scope.model.field = $scope.order;
                $scope.model.sorting = $scope.reverse? `ASC` : `DESC`;
            }

            new ccContactSrv().getFind($scope.model, (cb,status,request)   => {
                $scope.data           = cb;
                $scope.model.CurrentPage    = $scope.CurrentPage;

                localStorage.setItem('ccCallingCardModel', JSON.stringify( $scope.model ));
                //test sum status
                /*$scope.tags = cb.reduce((tags, item) => {
                    tags[item.dcStatusName] = tags[item.dcStatusName] || 0;
                    tags[item.dcStatusName]++;
                 return tags;
                }, {});

                $scope.res = Object.entries($scope.tags).map( value => value );*/
                // $scope.gridOptions.api.setRowData($scope.cc_Contact);
                // $scope.gridOptions.api.sizeColumnsToFit();
                $scope.total_count      = request.getResponseHeader(`total-count`);
                $scope.total_avgmin     = request.getResponseHeader(`total-avgmin`);
                $scope.total_avgwait    = request.getResponseHeader(`total-avgwait`);
                $scope.total_summin     = request.getResponseHeader(`total-summin`);
                $scope.total_avgbill    = request.getResponseHeader(`total-avgbill`);
                $scope.total_avghold    = request.getResponseHeader(`total-avghold`);
                //$scope.total_avghold    = $scope.total_avghold ? $scope.total_avghold : "00:00:00"; 
                //COLUMNS
                    $scope.ColTarget = false;
                    $scope.ColRecord = false;
                    $scope.ColemName = false;
                    $scope.ColBillsec = false;
                    $scope.data.forEach( todo => {
                            if(todo.emName)             $scope.ColemName = true;
                            if(todo.target)             $scope.ColTarget = true;
                            if(todo.dcStatus == 7001 || todo.dcStatus == 7011 || todo.dcStatus == 7012 ||todo.dcStatus == 7013 || todo.dcStatus == 7014 || todo.dcStatus == 7015 || todo.dcStatus == 7016)   $scope.ColRecord = true;
                            if(todo.billsec != '00:00')             $scope.ColBillsec = true;
                    });

                $timeout(() => {
                    $scope.global.Loading=false;
                    $scope.$apply();
                },10);
            });
    };
    $scope.Find = debounce($scope.FindNew);
    //$scope.Find =  $scope.FindNew;
    $scope.global.Loading=true;
    $scope.Find();

    $scope.Esettings =  { idProp: 'tvID', displayProp: 'disposition', externalIdProp: 'tvID'};  // template: '{{option}}',

    $scope.trans = () => {
        $scope.f = [
            { "type" : "ANSWERED"   , "disposition" : $filter('translate')('answered'),         "color" : "badge-success" , tvID: 7001 },
            { "type" : "FAILED"     , "disposition" : $filter('translate')('error'),            "color" : "badge-danger"  , tvID: 7004 },
            { "type" : "BUSY"       , "disposition" : $filter('translate')('busy'),             "color" : "badge-warning" , tvID: 7003 },
            { "type" : "CONGESTION" , "disposition" : $filter('translate')('noavailable'),      "color" : "badge-info"    , tvID: 7005 },
            { "type" : "NO ANSWER"  , "disposition" : $filter('translate')('didNotAnswer'),     "color" : "badge-default" , tvID: 7002 },
            { "type" : "UP"         , "disposition" : $filter('translate')('Up'),               "color" : "badge-default" , tvID: 7007 },
            { "type" : "Ringing"    , "disposition" : $filter('translate')('Ringing'),          "color" : "badge-default" , tvID: 7006 },
            { "type" : "LIMIT"      , "disposition" : $filter('translate')('LIMIT'),            "color" : "badge-default" , tvID: 7008 },
            { "type" : "BLOCKED"    , "disposition" : $filter('translate')('BLOCKED'),          "color" : "badge-default" , tvID: 7009 },
            { "type" : "CANCEL"    ,  "disposition" : $filter('translate')('CANCEL'),           "color" : "badge-default" , tvID: 7010 }
        ];
        $scope.callType = [{ Name: $filter('translate')('missed'), NameT:'isMissed'}, { Name: $filter('translate')('unique') , NameT: 'isUnique'}];
    };
    $scope.trans();
    $rootScope.$on('$translateChangeSuccess', () => {
        $scope.trans();
    });

    $scope.ClearPhone = () => {
        if($scope.model.ccNames.length > 0) {
                $scope.CurrentPage = $scope.model.CurrentPage = 1; $scope.model.offset = ($scope.model.CurrentPage * $scope.model.limit) - $scope.model.limit;
                $scope.model.ccNames.forEach( (x,key) => {
                        x.trim();
                        x = x.replace(/\D/g, "");
                        if(x.length == 10) x = `38${x}`;
                        $scope.model.ccNames[key] = x;
                });
        }
    };
    $scope.addClass2 = a => {
        $timeout(() => {
            $scope.Hover = a;
        },500);
    };
    $scope.addClass  = debounce($scope.addClass2);


   $scope.removeClass = () => {
        $scope.Hover = null;
   };
}