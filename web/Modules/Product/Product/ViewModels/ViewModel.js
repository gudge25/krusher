class stProductViewModel extends BaseViewModel {
    constructor($scope,$filter,$translate,$rootScope)
    {
        super($scope,$filter,new stProductSrv(),$translate);

        new stCategoriesSrv().getFind({},cb => { $scope.Categories = cb; $scope.Categories.unshift({tvID:null, pctName:'selectCategory'}); trans(); $scope.$apply();});
        new stBrandsSrv().getFind({},cb => { $scope.Brands = cb; $scope.Brands.unshift({bID:null, bName:'selectBrand'});  trans(); $scope.$apply();});
        new usMeasuresSrv().getFind({},cb => { $scope.Measures = cb; $scope.$apply();});
        $scope.enums = $scope.EnumsGroup[14];

        var trans = () => {
            $translate(['selectStatus','selectCategory','selectBrand']).then(a => {
                $scope.enums[0].Name                                 = a.selectStatus;
                if ($scope.Categories) $scope.Categories[0].pctName  = a.selectCategory;
                if ($scope.Brands) $scope.Brands[0].bName            = a.selectBrand;
            });
        };
        $rootScope.$on('$translateChangeSuccess', () => {
            trans();
        });
    }
}