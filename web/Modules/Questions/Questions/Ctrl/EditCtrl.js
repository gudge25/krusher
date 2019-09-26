crmUA.controller('fmQuestionsEditCtrl', function($scope, $stateParams ,$filter) {
    $scope.manyAction =  new fmQuestionsViewModel($scope, $filter);

    new fmQuestionSrv().getFind({ qID : $stateParams.qID },cb => {
        $scope.upd = cb[0]; $scope.upd_old = angular.copy(cb[0]); 
        // if(!questions){questions = cb; console.log(questions);}
        // if($stateParams.id&&$stateParams.id!=0) {
        //     var arr =[];
        //     var and = new RegExp("&");
        //     if(and.test($stateParams.id)){
        //         arr = $stateParams.id.split("&");
        //     }else{
        //         arr.push($stateParams.id);
        //     }
        //     angular.forEach(arr, todo => {
        //         angular.forEach(questions, todo2 => {
        //             if(todo == todo2.qID){
        //                 $scope.questions.push(todo2);
        //             }
        //         });
        //     });
        // }else{
        //     var a = [];
        //     a.tpID=$stateParams.tpID;
        //     a.isActive=true;
        //     questions =[];
        //     questions.push(new fmQuestionsModel(a).post());
        //     $scope.questions = questions;
        // }
        $scope.$apply();
    });
    $scope.save = () => {
             if($scope.upd.HIID){
                new fmQuestionSrv().upd($scope.upd,cb => { window.location = `/#!/formEdit`; });
            }else{
                new fmQuestionSrv().ins($scope.upd,cb => { window.location = `/#!/formEdit`; });
            }
         
    };
});