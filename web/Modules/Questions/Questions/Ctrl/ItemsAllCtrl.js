crmUA.controller('fmQuestionsItemsAllCtrl', function($scope,  $stateParams) {
    $scope.qID = $stateParams.qID;
    new fmQuestionItemsSrv().getFind( { qID : $stateParams.qID }, cb => { $scope.upd = cb; $scope.upd_old = angular.copy(cb); $scope.$apply();});

    $scope.new = () => {
        if($scope.upd === null)$scope.upd = [];
        let arr = new fmQuestionItemsModel({isActive:true , qID:$stateParams.qID}).put();
        $scope.upd.push(arr);
    };

    $scope.save = a => {
        angular.forEach(a, todo => {
            todo.qID = $stateParams.qID;
             if(todo.HIID){
                if(todo.isDeleted)
                    new fmQuestionItemsSrv().del(todo.qiID);
                else
                    new fmQuestionItemsSrv().upd(todo);

            }else{
                if(!todo.isDeleted)  new fmQuestionItemsSrv().ins(todo);
            }
            window.location = `/#!/formEdit`;
        });
    };

    $scope.Check_upd_old = () => {
        return angular.equals($scope.upd_old, $scope.upd) ? true : false;
    };

    $scope.slice = index => {
        $scope.upd.splice(index, 1);
    };

    $scope.model = new fmQuestionsModel({qID:$stateParams.qID}).postFind();
    new fmQuestionSrv().getFind($scope.model,cb => { $scope.form = cb[0]; $scope.$apply(); });
});