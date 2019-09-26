crmUA.controller('fmFormsAllCtrl', function($scope,$translate,$rootScope,$filter) {

    $scope.manyAction = new fmFormViewModel($scope,$filter,$translate,$rootScope);
    $scope.comment = {};
    $scope.COMM = [];
    $scope.contact = [];
  //   let tempDoc = new dcDocsSearchModel('').post();
 	// tempDoc.dctID = 4;
  //   $scope.model = angular.copy(tempDoc);
    $scope.model = new dcDocsSearchModel({ dctID : 4 }).postFind();
    $scope.manyAction.Find();
    
    $scope.$watch('data', (last,newd) =>  {
        if($scope.data.length > 0){
            $scope.data.forEach( item => {
                if (item.dcComment !== null) $scope.COMM.push(item);
                if ($scope.contact.indexOf(item.clName) == -1) $scope.contact.push(item.clName);
            }); 
        }
    });
     


    // new dcDocsSearchSrv().ins( $scope.model,cb   => {
    // 	$scope.data = angular.copy(cb);
    // 	$scope.forms = angular.copy(cb);
    // 	$scope.forms.unshift( $scope.model);
    // 	cb.forEach( item => {
    // 		if (item.dcComment !== null) $scope.COMM.push(item);
    // 		if ($scope.contact.indexOf(item.clName) == -1) $scope.contact.push(item.clName);
    // 	});
    // 	trans();
    // 	$scope.$apply();
    // });
    //new fmFormTypesSrv().getFind({},cb => { $scope.formTypes = cb; $scope.$apply();});

    // $scope.FindNew = () => {
    // 	$scope.data = [];
    // 	// if ($scope.model.dcComment !== undefined && $scope.model.dcComment !== ''){
	   //  // 	$scope.COMM.forEach( item => {if (item.dcComment.toLowerCase().indexOf($scope.model.dcComment.toLowerCase()) !== -1) $scope.data.push(item); });
	   //  // 	return;
    // 	// }
    //  //   	if ($scope.model.dcComment	!== undefined && $scope.model.dcComment === '') 		$scope.model.dcComment 	= undefined;
    //  //   	if ($scope.model.dcNo	!== undefined && $scope.model.dcNo.indexOf('-')   !== -1) 	$scope.model.dcNo 		= undefined;
    // 	// if ($scope.model.clName	!== undefined && $scope.model.clName.indexOf('-') !== -1) 	$scope.model.clName 	= undefined;
    // 	// if ($scope.model.emID	=== 0 ) 	$scope.model.emID = undefined;
    // 	new dcDocsSearchSrv().ins($scope.model,cb => {
	   //  	$scope.data = cb;
    //         $scope.global.Loading=false;
	   //  	$scope.$apply();
	   //  });
    // };
    // //DEBOUNCE
    // $scope.Find = debounce($scope.FindNew);

    // var trans = () => {
    // 	$translate(['named','responsible','contact','Comment']).then(a => {

    // 		if ($scope.employees.data !== undefined) $scope.employees.data[0].emName 	= '- ' + a.responsible + ' -';
    // 		if ($scope.formTypes !== undefined) $scope.formTypes[0].tpName 	= '- ' + a.named + ' -';
    // 		if ($scope.contact !== undefined) 	$scope.contact[0]	 		= '- ' + a.contact + ' -';
    // 		if ($scope.forms!== undefined)		$scope.forms[0].dcComment 	= '- ' + a.Comment + ' -';
    // 	});
    // };
    // $rootScope.$on('$translateChangeSuccess', () => {
    // 	trans();
    // });
});