crmUA.controller('RegisterCtrl',function ($scope, $timeout,$stateParams, $filter, Auth,  $translate, $translatePartialLoader) {

    $scope.manyAction =  new RegisterViewModel($scope, $timeout, $stateParams ,$filter, $translate);

 

    $scope.authorize = Auth;
    //Define browser land
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

    // new emEmployeeClientsSrv

    if(window.location.hash == "#!/Register" && Auth.FFF)  window.location = "#!/Dashboard";

    function extractDomain(url) {
        var domain;
        //find & remove protocol (http, ftp, etc.) and get domain
        if (url.indexOf("://") > -1) {
            domain = url.split('/')[2];
        } else {
            domain = url.split('/')[0];
        }
        //find & remove port number
        domain = domain.split(':')[0];
        let dom = domain.split('.')
        if(dom.length == 3)
            domain = `.${dom[1]}.${dom[2]}`;
        return domain;
    }

    $scope.model = new emEmployeeClientsModel().post();
    $scope.model.exDomain = extractDomain(window.location.hostname);

    $scope.ClearPhone = () => {
        if($scope.model.Phone ) {
            console.log( $scope.model.Phone.substring(1,2) );
            $scope.model.Phone.trim();
            $scope.model.Phone = $scope.model.Phone.replace(/\D/g, "");
            if($scope.model.Phone.length == 10) 
                if($scope.model.Phone.substring(0,1) == parseInt(0) && $scope.model.Phone.substring(1,2) != parseInt(0)) $scope.model.Phone = `38${$scope.model.Phone}`;
            if($scope.model.Phone.substring(0,3) == parseInt(380)) $scope.model.Phone = $scope.model.Phone.substring(0,12);
        }
    };

});