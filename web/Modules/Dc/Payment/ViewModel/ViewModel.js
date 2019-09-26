class PaymentViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new pchPaymentSrv());

        $scope.dcStatusEnum 	= $scope.EnumsGroup[10];
   		$scope.payTypeEnum  	= $scope.EnumsGroup[11];
    	$scope.payMethodEnum 	= $scope.EnumsGroup[12];
    }
}