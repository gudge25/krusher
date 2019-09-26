class emEmployeeViewModel extends BaseViewModel {
    constructor($scope,$filter,AclService, $translate, $rootScope)
    {
        super($scope,$filter,new emEmployeeSrv(),$translate,AclService,$rootScope);
        $scope.model = {'status': true };

        $scope.Sip2Em = () => {
            $scope.isEdit=true;
            $scope.sip[0].sipID = $scope.em.sipID =  $scope.em.sipData;
            angular.forEach($scope.Sips.data, todo => {
                if(todo.sipID == $scope.em.sipData)  {
                    $scope.sip[0].sipName = $scope.em.sipName = todo.sipName;
                    $scope.sip[0].emID = $scope.em.emID;
                }
            });
        };

        $scope.Check = a => {
            let input = false;
            if(a.emID !== null) input = true;
            return input;
        };

        $scope.SipDel = a => {
            //console.log(`Delete SIP`);
            new astSippeersSrv().del(a.sipID, cb => {
                $scope.em.sipName   = null;
                $scope.em.sipID     = null;
                new emEmployeeSrv().upd($scope.em,() => {  $scope.GetData(); });
            });
        };

        $scope.SipClean = () => {
            //console.log(`Clean SIP`);
            $scope.sip[0].emID = null;
            $scope.em.sipName   = null;
            $scope.em.sipID     = null;
            $scope.em.sipData   = null;
            new astSippeersSrv().upd($scope.sip[0], cb => {});
            new emEmployeeSrv().upd($scope.em,() => {  $scope.sip = []; $scope.GetData(); });
        };

        $scope.CheckLogin = () => {
            $scope.existLogin = false;    
            angular.forEach($scope.employees.dataAll, todo => {
                if(todo.LoginName == $scope.em.LoginName && todo.emID != $scope.em.emID)  $scope.existLogin = true; 
            });
        };
    }
}