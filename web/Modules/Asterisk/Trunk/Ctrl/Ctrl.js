crmUA.controller('TrunkCtrl', function($scope, $filter, $translate, $translatePartialLoader) {
    $scope.manyAction =  new TrunkViewModel($scope, $filter);
	$scope.model = new astTrunkModel().postFind();
	$scope.manyAction.Find();



	$scope.AmiEvents  = evt => {
		//evt = Object.values(evt);
		evt = Object.assign({}, evt);// Object.keys(evt).map(key => evt[key]);
		if($scope.data){
			if(evt.event == 'PeerStatus')
				$scope.data.forEach(  e => {
					if( e.trName.includes( evt.peer ) ) {
						e.peerstatus = evt.peerstatus;
						e.address = evt.address;
					}
				});
			//console.log(evt);
			if(evt.event == 'Registry')
				$scope.data.forEach(  e => {
					// console.log(e.host);
					// console.log(evt.domain);
					if(e.defaultuser)
					if( e.defaultuser.includes( evt.username ) && e.host == evt.domain) {
						e.regstatus = evt.status;
						e.address = evt.address;
					}
				});
				$scope.$apply();
		}
	};
});
//

//if(error)contains = data.trName.includes('connect ECONNREFUSED');