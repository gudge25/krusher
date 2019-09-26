crmUA.controller('fmFormEditCtrl', function($scope, $uibModal,$filter,$translate) {
    //$scope.manyAction =  new fmFormViewModel($scope, $uibModal);
    $scope.manyAction =  new fmQuestionsViewModel($scope, $uibModal);

    $scope.ItemsSrv     = new fmQuestionSrv();
    $scope.ItemsModel   = fmQuestionsModel;

    $scope.isEdit = false; $scope.newShow = false;
    // $scope.new_old = []; $scope.new = [];

    $scope.tpID = null;
    $scope.Clear =() => {
        $scope.tpID = null;
        $scope.model.tpID = null;
        sessionStorage.setItem('Form', $scope.tpID);
        $scope.Form = null;
        $scope.newShow = false;
    };
    $scope.ClearS =() => {
        console.log(`clear`);
        $scope.sID = null;
    };

    $scope.NewCreate =() => {
        $scope.newShow=true;
        $scope.Items = [];
        $scope.tpID = null;
        $scope.newForm = new fmFormTypesModel().put();
        $scope.newForm_old = angular.copy($scope.newForm);
    };

    $scope.model = new fmFormTypesModel().postFind();
    
    $scope.getForms = form => { //tpID
        console.log(); $scope.newShow = false;
        if(!$scope.tpID || $scope.sID){
            
            $scope.tpID = form.tpID;
            $scope.Form=form; $scope.Form_old = angular.copy(form);
            $scope.modelItems = { tpID : $scope.tpID, limit : 15 };
            sessionStorage.setItem('Form', $scope.tpID);
            $scope.manyAction.Find($scope.ItemsSrv);
        }
        else $scope.Clear();
    };

    $scope.Check_upd_old = () => {
        return angular.equals($scope.Form_old, $scope.Form) ? true : false;
    };
    $scope.Check_upd_old2 = () => {
        return angular.equals($scope.newForm_old, $scope.newForm) ? true : false;
    };

    $scope.$watch('model.isActive', (last,newd) =>  {
        if($scope.model)
        $scope.getFormsAll();
    });

    $scope.sID = sessionStorage.getItem('Form');
    $scope.getFormsAll =() => {
        new fmFormTypesSrv().getFind($scope.model,cb =>   { 
            $scope.formTypes = cb; 
            if( $scope.sID && $scope.sID != 'null' ) { $scope.tpID = sessionStorage.getItem('Form');
                angular.forEach($scope.formTypes, e => {  if(e.tpID == $scope.tpID) $scope.getForms(e); });
            }
            $scope.$apply();
            $scope.isEdit = false;
        });
    };

    $scope.getFormsAll();
    //$scope.manyAction.Find();

    $scope.addFt = a => {
        if(a) new fmFormTypesSrv().ins(a, () => { $scope.getFormsAll(); $scope.newShow=false; $scope.isEdit2=false; });
    };

    $scope.delT = f => {
        swal({
            title: $filter('translate')('Removal') + '!',
            text: $filter('translate')('delForm')  +' '+ f.tpName+"?",
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: $filter('translate')('yesDel'),
            cancelButtonText: $filter('translate')('cancel')
        }).then( () => {
            f.isActive = false;
            new fmFormTypesSrv().upd(f, cb =>   {
                $scope.getFormsAll();
            });
        });
    };

    $scope.EditForm = data => {
        new fmFormTypesSrv().upd(data, () => { $scope.Clear(); $scope.getFormsAll(); });
    };
});