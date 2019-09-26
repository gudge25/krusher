class stCategoriesViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new stCategoriesSrv());

        new stCategoriesSrv().getFind({},cb => {
            $scope.data = cb;
            $scope.tree = unflatten( cb );
            $scope.$apply();
        });
    }
}