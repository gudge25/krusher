class regCountryViewModel extends BaseViewModel {
	constructor($scope,$filter,$translate,$rootScope)
	{
		super($scope,$filter,new regCountrySrv(),$translate);
		this.Find();
		$scope.new = new regCountryModel('').post();
	}
}