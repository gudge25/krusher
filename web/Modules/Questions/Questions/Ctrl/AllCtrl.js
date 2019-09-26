crmUA.controller('fmQuestionsAllCtrl', function($scope, $timeout, $filter, $uibModal) {
    $scope.manyAction =  new fmQuestionsViewModel($scope, $uibModal);
    $scope.model = new fmQuestionsModel('').postFind();

    $scope.CheckName = id => {
            let a;
                angular.forEach($scope.data, todo => {
                    if(todo.qID == id) {   a = todo.qName;  }
                });
            return a;
    };
});