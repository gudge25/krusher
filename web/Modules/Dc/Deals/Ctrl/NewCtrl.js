crmUA.controller('DealNewCtrl', function($scope, $filter, $stateParams,Auth,ModalItems,$translate,$rootScope) {
    $scope.manyAction =  new slDealViewModel($scope,$filter,$translate,$rootScope);

    $scope.new.dcDate   = $filter('date')(new Date(),'yyyy-MM-dd');
    $scope.new.dcStatus = 6001;
    $scope.new.emID     = Auth.FFF.emID;

    $scope.new.dcID     = lookUp(API.us.Sequence, 'dcID').seqValue;
    $scope.new.dcNo     = 'СД-'+$scope.new.dcID;


    //if add from client
    GetDcLink = () => {
        //new dcDocClientSrv().getFind({ dcID : $scope.new.dcLink},cb   => { $scope.DcLink = cb[0]; $scope.$apply(); });
        if($scope.new.dcLink)  
                    new ccContactSrv().getFind({ dcIDs : [{dcID:$scope.new.dcLink}]}, cb => {
                        $scope.DcLink = cb; $scope.$apply();
                    });
    };
    GetClient = () => {
        new crmClientFindSrv().getFind({ clID : $scope.new.clID }, cb    => { $scope.client = cb[0]; $scope.$apply(); });
    };

    if( $stateParams.clID){
        $scope.new.clID = $stateParams.clID;
        GetClient();
    }

    if($stateParams.dcID) {
        $scope.new.dcLink = $stateParams.dcID;
        GetDcLink();
    }

    if(ModalItems){
        if(ModalItems.clID){
            $scope.new.clID = ModalItems.clID;
            GetClient();
        }

        if(ModalItems.dcID){
            $scope.new.dcLink = ModalItems.dcID;
            GetDcLink();
        }
    }

    new slDealItemsSrv().getFind({ dcID : $scope.new.dcID },cb   => { $scope.upd2 = cb; $scope.$apply();   });

    $scope.$watch('searchclient', () => {
        if($scope.searchclient) {
            $scope.new.clID = $scope.searchclient.clID;
            setTimeout(() => {
                $scope.$apply();
            }, 100);
        }
    });

    $scope.addItems = () =>{
        $scope.showTab = true;
        if(!$scope.upd2) $scope.upd2 = [];
        var p = new slDealItemsModel('').put();
        p.dcID = $scope.new.dcID;
        $scope.upd2.push(p);
        $scope.Sum();
    };

    $scope.formatLabel = model => {
        for (var i=0; i< $scope.products.length; i++) {
            if (model === $scope.products[i].psID) {
                return $scope.products[i].psName;
            }
        }
    };

    $scope.newProduct = new stProductModel('').post();

    $scope.Find = model => {new stProductFindSrv().getFind(model ,cb => { $scope.Products = cb; }); };
    $scope.Find('');
});