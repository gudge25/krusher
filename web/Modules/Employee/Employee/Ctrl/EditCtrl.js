crmUA.controller('emEmployeeCtrlEdit', function($scope,  $filter, $stateParams,Auth,AclService, $translate,$rootScope) {
    $scope.manyAction =  new emEmployeeViewModel($scope,$filter,AclService,$translate,$rootScope);
    $scope.Auth = Auth;
    var id = $stateParams.emID;
    $scope.isEdit = false;
    //GET emPloyees
    $scope.GetData = () => {
        new emEmployeeSrv().getFind({ emID :id}, cb => {
            if(cb.length > 0){
                $scope.em       = cb[0];
                $scope.em_old   = angular.copy($scope.em);
                $scope.sip      = [];
                //GET SIP
                if($scope.em.sipID)
                    new astSippeersSrv().getFind({ sipID: $scope.em.sipID},cb2 => {
                        $scope.sip.push(cb2[0]);
                        $scope.$apply();
                    });
                else
                if( $scope.sip.length <= 0 ) $scope.sip = [ new astSippeersModel('').put() ];

                if($scope.sip === null)
                {
                    $scope.sip = [new astSippeersModel('').post()];
                    $scope.type = "new";
                }
                else
                    $scope.type = "exist";

                $scope.$apply();
            } else  window.location = "#!/page404";
        });
    };
    $scope.GetData();

    $scope.Save = EmArr => {
        //let SIP = $scope.sip[0];
        let EM = 0;
        //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Проверить этот кусок кода !!!!!!!!!!!!!!
        //SIP update
        // if(!angular.equals($scope.sip_old, $scope.sip))
        //     if(SIP)
        //         if(SIP && SIP.sipName !== ""){
        //                 angular.forEach($scope.Sips.data, todo => {
        //                     if(SIP.sipID == todo.sipID ) {
        //                         todo.emID = EmArr.emID;
        //                         new astSippeersSrv().upd(todo);
        //                     }
        //                     if($scope.em.emID == todo.emID && SIP.sipID != todo.sipID ) { console.log(todo); todo.emID = null; new astSippeersSrv().upd(todo); }
        //                 });
        //         }
      
        //Em update
        if(!angular.equals($scope.em_old, $scope.em)){
            EM = 1;
            new emEmployeeSrv().upd(EmArr,() => {
                IfAuth = JSON.parse(localStorage.getItem('Auth'));

                //If CHANGE OURSELF USER
                if(IfAuth.emID == EmArr.emID){
                    IfAuth.roleID   = EmArr.roleID;
                    IfAuth.sipID    = EmArr.sipID;
                    IfAuth.sipName  = EmArr.sipName;
                    angular.forEach($scope.role, row => {
                          if(row.roleID == IfAuth.roleID) {
                                IfAuth.roleName     = EmArr.roleName    = row.roleName;
                                IfAuth.Permission   = EmArr.Permission  = row.Permission;
                            }
                    });
                    localStorage.setItem('Auth', JSON.stringify(IfAuth));
    				if(IfAuth) $scope.Auth.FFF =IfAuth;
                    if(EmArr.Password)$scope.LogOut();
                }
			});
		}
        //IF CHANGE PASS GO TO LOGIN
        setTimeout(() => {
                 if(IfAuth.emID == EmArr.emID && EmArr.Password) { } else  window.location = "/#!/employee";
        }, 500);
    };
});