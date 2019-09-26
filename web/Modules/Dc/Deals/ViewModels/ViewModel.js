class slDealViewModel extends BaseViewModel {
    constructor($scope,$filter,$translate, $rootScope, AclService)
    {
        super($scope,$filter,new slDealSrv(),$translate,AclService);
        

        new stProductFindSrv().getFind('' , cb =>  { $scope.products   = cb; $scope.$apply();});

        $scope.new          = new slDealModel('').post();

        //Add Items
        $scope.dellItems = a =>{
            angular.forEach($scope.upd2, (todo,key) => {
                if(key == a)  {
                    $scope.upd2.splice(key,1);
                    if(todo.diID) new slDealItemsSrv().del(todo.diID);
                }
            });
        };

        $scope.psName = e => {
            angular.forEach($scope.products, todo => {
                if(todo.psID == e.psID)   e.psName = todo.psName;
            });
        };

        $scope.ItemsEdit = a => {
            angular.forEach(a, row => {
                if(row.diID){
                    new slDealItemsSrv().upd(row, () => { if($scope.new.clID){  window.location = `/#!/clientPreView/${$scope.new.clID}`; } });
                }else{
                    new slDealItemsSrv().ins(row, () => { if($scope.new.clID){  window.location = `/#!/clientPreView/${$scope.new.clID}`; } });
                }
            });
        };

        $scope.Sum = () =>{
            $scope.sum = 0;
            angular.forEach($scope.upd2,todo => {
                if(todo.iPrice > 0 && todo.iQty > 0) $scope.sum = $scope.sum+(todo.iPrice*todo.iQty);
            });

            if($scope.upd)$scope.upd.dcSum = $scope.sum;
            if($scope.new)$scope.new.dcSum = $scope.sum;
        };
    }
}