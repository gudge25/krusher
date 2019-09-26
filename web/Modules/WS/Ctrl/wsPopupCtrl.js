crmUA.controller('wsPopupCtrl', ($scope, $uibModal, $translate, $translatePartialLoader, $rootScope,serv) => {

	const Client  = angular.element(document.getElementById('wsPopupCtrl')).scope();

	$scope.clientList = [];
 	$scope.open = ev => {
			console.log(ev);
		 	if(ev){
				//mapping for phone
				ev.phone  = clearnum(ev.phone);
				ev.clients = [];
				ev.CALLINGCARD = { ContactStatus: null, Comment: null }; ev.CALLINGCARD_old = angular.copy(ev.CALLINGCARD); 
				//Auto pause if bridge
				//if(ev.dcStatusName == `UP`) Client.PauseAll(true);   
				angular.forEach($scope.clientList, todo => {
					if(todo.phone == ev.phone){
						todo.dcStatusName = ev.dcStatusName;
						todo.source = ev.source;
						todo.ccID = ev.ccID;
						todo.clID = ev.clID;
						todo.coID = ev.coID;
						todo.dcID = ev.dcID;
						todo.emID = ev.emID;
						todo.ffID = ev.ffID;
					}
				});
										
				if( $scope.clientList.findIndex(x => x.phone === ev.phone) == -1 ) {
						$scope.clientList.push(ev);           
						//get Client
						console.log(ev);
						if(ev.clID){
							new crmClientSrv().getFind({clID: ev.clID, ffID: ev.ffID, isActive: true, limit: 1}, cb => {
								//console.log(cb);
											if(cb.length > 0) 
												ev.clients = cb;
											console.log(`start open CLID`);	
											$scope.openClient();
											$scope.$apply();
							});
						}
						else
							new crmClientSrv().get('find/' + ev.phone, cb => {
											if(cb.length > 0) 
												ev.clients = cb;
											console.log(`start open PHONE`);	
											$scope.openClient();
											$scope.$apply();
							});
				}
			}
	};

	// $scope.openRinging = ev => { 
	// 		ev.dcStatusName=`RINGING`;
	// 		$scope.open(ev);
	// };
	
	// $scope.openBridge = ev => { 
	// 		ev.dcStatusName=`UP`;
	// 		$scope.open(ev);
	// };

	//For autocloce when ringing end
	$scope.Cancel = evt =>  { 
			//console.log(`Cloce window WSS`); 
			if(uibModalInstance2){ 
				angular.forEach($scope.clientList, (todo,key) => {
					 	if(todo.phone == evt.phone && todo.dcStatusName == `RINGING`)
							 $scope.clientList.splice(key, 1);
						if(todo.phone == evt.phone && todo.dcStatusName != `RINGING`) { 
							todo.dcStatusName = `Finished`;
						}
				});
				if($scope.clientList.length === 0)
					uibModalInstance2.dismiss('cancel'); 
			}
	};


	//DEFAULT
	var uibModalInstance2;
	$scope.openClient = () => {

		if(uibModalInstance2 === undefined)
		{	
 			uibModalInstance2 = $uibModal.open({
				templateUrl: 'Modules/WS/Views/PreViewsContact.html',
				controller: 'wsModalCtr',
				resolve: {
					contact: () => $scope.clientList
				},
				size : `lg`,
				keyboard  : false,
				backdrop: 'static',
				animation: false,
				 // openedClass:'green',
				//  windowClass:'modal-content2',
				// windowTopClass:'green'
				// ariaLabelledBy: 'modal-title',
				// ariaDescribedBy: 'modal-body',

			});
			uibModalInstance2.result.then( () => { console.log(`When all close 1 `); }, () => { if($scope.clientList.length === 0) {  console.log(`When all close 2`); console.log($scope.clientList);  $scope.clientList = []; uibModalInstance2=undefined; document.title = `KrusherCRM - система для автоматического обзвона баз клиентов`;} });
		}
		// else
		// {
		// 	console.log(`Second time & ....`);
		// }
    };
	// animation: $ctrl.animationsEnabled,
	// ariaLabelledBy: 'modal-title',
	// ariaDescribedBy: 'modal-body',
	// templateUrl: 'myModalContent.html',
	// controller: 'ModalInstanceCtrl',
	// controllerAs: '$ctrl',
	// size: size,
	// appendTo: parentElem,
	// resolve: {
	//   items: function () {
	// 	return $ctrl.items;
	//   }
	// }

		 	// setTimeout($scope.openBridge({"event":"Newstate","sip":"500_10","phone":"380978442044","source":null,"coID":null,"channelstatedesc":"Up","channelstate":"5"}),1000);
    		//  setTimeout($scope.openRinging({"event":"Newstate","sip":"500_10","phone":"380501459708","source":null,"coID":null,"channelstatedesc":"Ringing","channelstate":"5"}),1000);
			//  setTimeout($scope.openRinging({"event":"Newstate","sip":"500_10","phone":"380501459707","source":null,"coID":null,"channelstatedesc":"Ringing","channelstate":"5"}),1000);
			// setTimeout($scope.openBridge({"event":"Newstate","sip":"500","phone":"380689523926","source":"t817","coID":null,"channelstatedesc":"Up","channelstate":"5"}),1000);
		 	// setTimeout($scope.openRinging({"event":"Newstate","sip":"500","phone":"380689523924","source":"t817","coID":null,"channelstatedesc":"Ringing","channelstate":"5"}),1000);

		
		// setTimeout($scope.open({ phone: 380978442043, source : '0443649633' }),2220);
		//{"event":"Newstate","sip":"500_10","phone":"380978442044","source":null,"coID":null,"channelstatedesc":"Ringing","channelstate":"5"}	

		//setTimeout($scope.openRinging({"event":"Newstate","sip":"500_10","phone":"0978442044","source":null,"coID":null,"channelstatedesc":"Ringing","channelstate":"5"}),1000);
		//  setTimeout($scope.openRinging({"event":"Newstate","sip":"500_10","phone":"978442045","source":null,"coID":null,"channelstatedesc":"Ringing","channelstate":"5"}),1000);
		// setTimeout($scope.openRinging({"event":"Newstate","sip":"500_10","phone":"+380978442044","source":null,"coID":null,"channelstatedesc":"Ringing","channelstate":"5"}),1000);
		// setTimeout($scope.openRinging({"event":"Newstate","sip":"500_10","phone":"380978442044","source":null,"coID":null,"channelstatedesc":"Ringing","channelstate":"5"}),1000);
});