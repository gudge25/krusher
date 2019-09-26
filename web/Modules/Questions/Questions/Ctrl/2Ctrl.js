crmUA.controller('fmQuestions2Ctrl', function($scope,  $stateParams) {
 
    $scope.askKey = 0;

    new crmClientFindSrv().getFind({ clID :$stateParams.clID }, cb => { $scope.client = cb[0]; $scope.$apply(); });
    new fmQuestionSrv().getFind( {}, cb => {
        $scope.question = cb;
        angular.forEach($scope.question, (todo,key) => {
            new fmQuestionSrv().getFind({qID: todo.qID},cb => { $scope.question[key]= cb[0]; $scope.$apply();});
        });
    });

    $scope.comment = false;
    $scope.nextQ = (id, a) => {
        var l = _.last($scope.question).qID;
            if ((id + 1) < l) {
                $scope.askKey = id + 1;
            } else {
                $scope.comment = true;
            }
        $scope.answer = a;
    };
});