crmUA.controller('emEmployeeCtrlAll', function($scope, $filter, AclService, $translate, $rootScope, Auth) {

    $scope.manyAction =  new emEmployeeViewModel($scope, $filter, AclService,$translate,$rootScope);

    $scope.Auth = Auth.FFF;
    
    $scope.DeActive = () => {
        var d = false;
        angular.forEach($scope.data, todo => {
            if(todo.isChecked){
                if(todo.isActive) {
                    //Update
                    var sipID       = todo.sipID;
                    todo.sipID      = null;
                    todo.sipName    = null;
                    todo.isActive   = false;
                    new emEmployeeSrv().upd(todo,() => {
                        //DELETE SIP
                        if(sipID) new astSippeersSrv().del(sipID);
                    });
                } 
                else { 
                    todo.isActive = true;
                    new emEmployeeSrv().upd(todo);
                }
                d = true;
            }
        });
        if(!d) 
            alert($filter('translate')('chooseAnything'));
        else    
            $scope.manyAction.Find();
    };
    //$scope.model = new emEmployeeModel({isActive:true}).postFind();   
    //$scope.manyAction.Find();
 
    $scope.Filter = true;

    $scope.FilterRoled  = "";
    $scope.FilterRole   = { roleName : $scope.FilterRoled };
    $scope.$watch('FilterRoled', () => {
        if($scope.FilterRoled)
        $scope.FilterRole = { roleName : $scope.FilterRoled };
        else delete $scope.FilterRole;
    });

    $scope.ClearFilter = a =>{
        a = a ? a : {};
        a.isActive = true;
        $scope.model = new emEmployeeModel(a).postFindNotMap();
        switch($scope.Auth.roleID){
            //Operator
            case 3: { $scope.model.emID = EMID; break; }
            //Supervizor
            case 2: { $scope.model.ManageID = EMID; break; }
            //Admin
            default : break;
        }
        switch($scope.Auth.roleName){
            //Operator
            case `Operator`: { $scope.model.emID = EMID; break; }
            //Supervizor
            case `Supervisor`: { $scope.model.ManageID = EMID; break; }
            //Admin && Dev
            default : break;
        }
        //console.log($scope.Auth.coIDs);
        if($scope.Auth.coIDs)
        if($scope.Auth.coIDs.length > 0){
            $scope.model.coIDs = angular.copy($scope.Auth.coIDs);
        }

        $scope.manyAction.Find();
    };
    $scope.manyAction.ClearFilter = $scope.ClearFilter;
    
    $scope.manyAction.ClearFilter();
});