crmUA.controller('DealCtrl', function($scope,$filter,$translate,$rootScope,Auth,AclService) {
    $scope.manyAction =  new slDealViewModel($scope,$filter,$translate,$rootScope,AclService);
    $scope.Auth = Auth.FFF;
    $scope.model = new slDealModel('').postFind();
    switch($scope.Auth.roleID){
        //Operator
        case 3: { $scope.model.emID = EMID; break; }
        //Admin
        default : break;
    }
    $scope.manyAction.Find();
});