crmUA.controller('fmQuestionsCtrl', function($scope, $stateParams, $filter,Auth,ModalItems,$uibModal,$uibModalInstance) {
    //new crmClientSrv().get($stateParams.clID,cb =>   { $scope.client = cb; $scope.$apply(); });
    $scope.manyAction =  new fmQuestionsViewModel($scope, $uibModal);
    $scope.formTypes = [];
    $scope.undo = true;
    $scope.Clear = () => {
        $scope.model={'tpID' : null};
        $scope.client = null;
        $scope.searchclient=null;
        $scope.questions=null;
        $scope.answers = null;
        $scope.Sum = 0;
    };

    $scope.getForms = () =>{
        if($scope.model.tpID){
            //for answers
            var arr ={
                "clID"    : $scope.client.clID,
                "dcDate"  : $filter('date')(new Date(), 'yyyy-MM-dd'),
                "emID"    : Auth.FFF.emID,
                "dcNo"    : "Заполненая анкета",
                "tpID"    : $scope.model.tpID
            };
            $scope.answers = new fmFormsModel(arr).put();
            //get forms && questions
            if($scope.model.tpID)
                new fmQuestionSrv().getFind({tpID:$scope.model.tpID,"sorting" : "ASC"}, cb => {
                    $scope.questions = cb;
                    delete $scope.answers.dcComment ;
                    let qIDs = [];
                    angular.forEach($scope.questions, (todo,key) => {
                        if(todo.qID) qIDs.push(todo.qID);
                        //new fmQuestionItemsSrv().getFind({qID:todo.qID,"sorting" : "ASC"}, cb => {$scope.questions[key].Items= cb; $scope.$apply();});
                    });
                    if(qIDs.length > 0){
                         new fmQuestionItemsSrv().getFind({"qIDs":qIDs,"sorting" : "ASC"}, cb => { 
                            //$scope.questions[key].Items= cb; 
                            // angular.forEach(cb, (todo,key) => {
                            //     if(todo.qID) qIDs.push(todo.qID);
                            //     $scope.questions[key].Items= cb;
                            //  });
                            let group = _.groupBy(cb, 'qID');
 
                            angular.forEach($scope.questions, todo => {
                                 if(todo.qID) todo.Items = group[todo.qID];
                            });
                            
                            $scope.$apply();
                        });
                        //$scope.$apply();    
                    } 
                    $scope.$apply();    
                });
                else delete $scope.questions;
            $scope.Sum = 0;
            //$scope.$apply();
        } else delete $scope.questions;
    };

    $scope.GetFormTypes = ffID => {
        $scope.formTypes = [];
        angular.forEach($scope.FormType.data, todo => {
            if(ffID == todo.ffID) $scope.formTypes.push(todo);
        });
        if($scope.formTypes.length === 1) { 
            $scope.model.tpID =  $scope.formTypes[0].tpID;
            $scope.getForms($scope.model.tpID);
        }
        //$scope.$apply(); 
    };

    $scope.model={'tpID' : null};

    //if add from client
    $scope.GetDcLink = dcID => {
        new dcDocClientSrv().getFind({ dcID }, cb   => { if(cb.length > 0) { $scope.DcLink = cb[0]; /* $scope.GetFormTypes($scope.DcLink.ffID);*/   $scope.$apply();} });
    };
    $scope.GetClient = clID => { 
        if(ModalItems || $stateParams.clID) $scope.undo = false;
        
        if(!ModalItems)
            new crmClientFindSrv().getFind({ clID }, cb => { if(cb.length > 0) { $scope.client = cb[0]; $scope.GetFormTypes($scope.client.ffID);  $scope.$apply(); } });
    };
    if(ModalItems) { $scope.ModalItems = ModalItems; $scope.client = $scope.ModalItems; $scope.GetFormTypes($scope.client.ffID); }

    if(ModalItems && $stateParams.clID){
        if(ModalItems.clID) { $scope.GetClient(ModalItems.clID); }
    } 
    else {
        if(ModalItems){
            if(ModalItems.clID) { $scope.GetClient(ModalItems.clID); }
        }
        if($stateParams.clID) $scope.GetClient($stateParams.clID);
    }

    

    $scope.save = a => {
        // swal({
        //     title: 'Сохранить анкету ?',
        //     showCancelButton: true,
        //     confirmButtonText: 'Сохранить',
        //     cancelButtonText: 'Отмена',
        //     showLoaderOnConfirm: true,
        //     allowOutsideClick: false
        // }).then( text => {
        // });
        $scope.global.Loading = true;
        a.tpID = $scope.model.tpID;    
        new fmFormsSrv().ins(a, () => {
            angular.forEach(a.Items, todo => {
                if(todo){
                    todo.dcID = a.dcID;
                    todo.emID = Auth.FFF.emID;
                    todo.clID = $scope.client.clID;
                    //todo.fiID = lookUp(API.us.Sequence, 'fiID').seqValue;
                    new fmFormItemsSrv().ins(todo, cb => { /* window.location = `/#!/clientPreView/${$scope.client.clID}`;*/ $uibModalInstance.close(); $scope.global.Loading = false; });
                }
            });
        });
    };

    $scope.Int = a => isInteger(a);

    $scope.CheckAnswer = (key,data) => {
        if($scope.answers.Items === undefined) $scope.answers.Items =[];
        if($scope.answers.Items[key] !== undefined && data.qiID != null)
            delete $scope.answers.Items[key] ;
        else
            $scope.answers.Items[key] = data;
        if(data.qiAnswer == '' && data.qiID == null) delete $scope.answers.Items[key] ;
        $scope.Sum = 0;
        angular.forEach($scope.answers.Items, () => {
            $scope.Sum++;
        });
    };
});