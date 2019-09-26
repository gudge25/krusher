crmUA.controller('page404Ctrl',function ($scope, $timeout,$stateParams, $filter, Auth,  $translate, $translatePartialLoader) {

    $scope.manyAction =  new page404ViewModel($scope, $timeout, $stateParams ,$filter, $translate);


    $scope.authorize = Auth;
    //Define browser land


});