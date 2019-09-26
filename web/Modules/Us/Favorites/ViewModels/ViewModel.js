class FavoriteViewModel extends BaseViewModel {
    constructor($scope,$filter,$translate)
    {
        super($scope,$filter,new FavoritesSrv(), $translate);

	    $scope.getFavList = () => {
	      new FavoritesSrv().getFind({},cb => {
	        cb.forEach(item => item.select = false);
	        $scope.Favorites = cb;
 	        if( $scope.gridOptions !==undefined ) $scope.gridOptions.data = cb;
	        for (var i = 0; i < $scope.Favorites.length; i++) {
	          if($scope.Favorites[i].uID === $scope.uID)
	            $scope.isAdded = true;
	        }
	        $scope.$apply();
	      });
	    };
	    $scope.RemoveFavorite = () => new FavoritesSrv().del($scope.uID);
    }
}