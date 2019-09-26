crmUA.controller('LoginController',function ($scope, $timeout,$stateParams, $filter, Auth,  $translate, $translatePartialLoader,AclService) {
    $scope.manyAction =  new loginViewModel($scope, $filter, $translate, AclService);
    $scope.authorize = Auth;
    $scope.auth = {
        Remember : true,
        USERNAME : null,
        PASSWORD : null
    };

    var a = 'en';
    var lang = window.navigator.language || navigator.userLanguage;
    if(lang.indexOf('ru') !== -1) a = `ru`;
    if(lang.indexOf('en') !== -1) a = `en`;
    if(lang.indexOf('uk') !== -1) a = `ua`;

    if (localStorage.getItem("Language") !== null) {
        $scope.lang = localStorage.getItem("Language");
    } else {
        $scope.lang = a;
        localStorage.setItem("Language", a);
    }
    $scope.manyAction.changeLanguage($scope.lang);

    $scope.Login = auth => {
        //$scope.global.Loading = true;
        USERNAME = auth.USERNAME;
        PASSWORD = auth.PASSWORD;
        AjaxSettings();
        new PrivateSrv().getAll( cb => {
            $scope.a                = cb[0];
            $scope.authorize.FFF    = $scope.a;
            if($scope.a)
                if($scope.a.emID)
                {
                    EMID = $scope.a.emID;
                    if(auth.Remember) {
                            $scope.a.PASSWORD = utoa(auth.PASSWORD);
                            if($scope.a.sipID)
                                new astSippeersSrv().getFind({sipID:$scope.a.sipID}, cb => { if(cb[0]) if(cb[0].sipLogin) { $scope.a.sipLogin = SIP = cb[0].sipLogin; if(SIP)wsStart(); }  localStorage.setItem('Auth', JSON.stringify($scope.a)); });
                            else
                                localStorage.setItem('Auth', JSON.stringify($scope.a));
                    }
                    //Bug ACL
                    // $scope.manyAction.ACL();
                    // if(last != newd){
                        $scope.manyAction.ACLRoles();

                            let user = $scope.authorize.FFF;
                            if(user){
                                switch(user.roleName){
                                    case `Admin`      : { user.getRoles  = () => ['Admin'];         break; }
                                    case `Supervisor` : { user.getRoles  = () => ['Supervisor'];    break; }
                                    case `Operator`   : { user.getRoles  = () => ['Operator'];      break; }
                                    case `Developer`  : { user.getRoles  = () => ['Developer'];     break; }
                                    case `Client`     : { user.getRoles  = () => ['Client'];        break; }
                                    case `Validator`  : { user.getRoles  = () => ['Validator'];     break; }

                                    
                                    default : {break ;}
                                }
                                AclService.setUserIdentity(user);
                            }
                    //}
                    window.location = "/#!/Dashboard";
                }
                else
                {
                        alert(`Alert ${a.statusCode}, ${a.error}!`,`${message} <br/> ${url}`,`warning`);
                        ClearAuth();
                }
            $scope.$apply();
        });
        //$scope.global.Loading = false;

    };

    if(window.location.hash == "#!/login" && Auth.FFF)  window.location  = "#!/Dashboard";
});