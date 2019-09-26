crmUA.controller('crmClientCtrlManyEdit', function($scope, $uibModalInstance, items,$filter) {
    $scope.items = items;

    $scope.manyAction =  new crmClientNewViewModel($scope, $filter);

    $scope.g = new crmResponsibleListModel().post();
    $scope.ok = a => {
        //Array for mass update
        a.clID =[];

        if(a !== undefined) {
            angular.forEach($scope.items, todo => {
                //Comment update
                /*if (value.comment != undefined) {
                 todo.Comment = value.comment;
                 new crmClientSrv().upd_new(todo);
                 }*/
                //Select client id for update
                a.clID.push(parseInt(todo.clID));
            });
        }
        let c = false;
        let b = false;
        //CallDate update
        if(a.CallDate) c = new crmClientExListSrv().ins(a);

        //Responsible update
        if(a.emID)     b = new crmResponsibleListSrv().ins(a);

        $.when(c,b).done( () => { $scope.cancel(); });
    };

    $scope.cancel = () => {
        $uibModalInstance.dismiss('cancel');
    };
});