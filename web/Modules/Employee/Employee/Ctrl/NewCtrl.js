crmUA.controller('emEmployeeCtrlNew', function($scope, $filter, AclService,$translate,$rootScope) {
    $scope.manyAction =  new emEmployeeViewModel($scope, $filter,AclService,$translate,$rootScope);

    $scope.searchclient = null;
    $scope.em       = new emEmployeeModel('').put();
    $scope.em.emID  = lookUp(API.us.Sequence, 'emID').seqValue;
    //$scope.sip      = new astSippeersModel('').put();

    $scope.Save = () => {
        //Get emID
        //$scope.sip[0].emID = $scope.em.emID ;//=lookUp(API.us.Sequence, 'emID').seqValue;
        //var ID;
        var SipExist=false;
        var model;
        if( $scope.em.sipID){
                SipExist=true;
        }
        else {
                model               = new astSippeersModel($scope.sip[0]).put();
                model.sipName       = $scope.searchclient;
                model.sipID         = $scope.em.sipID = lookUp(API.us.Sequence, 'sipID').seqValue;
                $scope.em.sipName   = model.sipName;
        }
        //Insert
        new emEmployeeSrv().ins( $scope.em, () => {
                if(SipExist){
                    new astSippeersSrv().getFind({ sipID:  $scope.em.sipID}, cb => {
                        let model2  = cb[0];
                        model2.emID = $scope.em.emID;
                        new astSippeersSrv().upd(model2, () => { window.location = "/#!/employee"; });
                    });
                }
                else
                {
                    new astSippeersSrv().ins(model, () => { window.location = "/#!/employee"; });
                }
        });
    };

    $scope.$watch('em.LoginName', (newValue, oldValue) => {
        if($scope.em.LoginName == "root") $scope.em.LoginName = $scope.em.emName = $scope.sip.sipName = null;
    });

    //GET SIP
    new astSippeersSrv().getFind({}, cb => {
            $scope.sip  = [];
            angular.forEach(cb, todo => {
                    if( $scope.em.sipID == todo.sipID) { $scope.sip.push(todo); $scope.sip_old = angular.copy(cb); }
            });
            if( $scope.sip.length <= 0 ) $scope.sip.push( new astSippeersModel($scope.em).put() );
            $scope.$apply();
    });

    $scope.Select = a => {
        if(typeof a === 'object' && a !== null){
            $scope.sip[0].selectedSip   = 1;
            $scope.sip[0].nat           = a.nat;
            $scope.sip[0].isActive      = a.isActive;
            $scope.em.sipData           = a.sipID;
            $scope.Sip2Em();
        }
    };

    $scope.Changed = () => {
        //console.log(`WORK CHANGED !!!!!!!!!!!!`);
        $scope.edit2=true;
        $scope.sip[0].selectedSip=0;
        $scope.em.sipName = $scope.em.sipID = $scope.em.sipData = null;
        $scope.sip= [ new astSippeersModel($scope.em).put() ];
       
    };
});