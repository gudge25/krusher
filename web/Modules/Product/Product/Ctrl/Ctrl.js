crmUA.controller('ProductCtrl', function($scope ,$filter, $translate, $rootScope, $uibModal, $translatePartialLoader) {
    $scope.manyAction =  new stProductViewModel($scope,$filter,$translate,$rootScope);

    $scope.model = {};

    $scope.Find = model => {
        new stProductFindSrv().getFind(model ,cb => {
            cb.forEach( item => {
                let Name;
                $scope.enums.some( value => {
                    if (item.psState === value.tvID)  Name = value.Name;
                });
                item.statusName = Name;
            });
            $scope.data = cb;
            // $scope.tree = _.groupBy(cb, 'pctName');
            $scope.$apply();
        });
    };

    $scope.Find('');

    $scope.open = psID => {
        var modalInstance = $uibModal.open({
            templateUrl:  `${Gulp}Product/Product/Views/ProductEdit.html`,
            controller: 'ProductEditCtrl',
            windowClass : ``,
            resolve     : {
                ModalItems: () => {
                  return {"psID": psID};
              }
          }
      });
        modalInstance.result.then( item => {
                    $scope.Find({});
                });
    };

    addClass = (that) => {
        that.children[1].children[0].classList.add('success');
        that.children[1].children[1].classList.add('success');
    };

    removeClass = (that) => {
        that.children[1].children[0].classList.remove('success');
        that.children[1].children[1].classList.remove('success');
    };
});