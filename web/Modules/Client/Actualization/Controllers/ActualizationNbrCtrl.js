crmUA.controller('ActualizationNbrCtrl', function( $scope, $timeout, $stateParams, $filter, ModalItems,$uibModalInstance, Auth, Autocall) {
	$scope.autocall2 = Autocall;
	$scope.autocallF = () => {
		$scope.autocall2.FFF = false;
	};

    if( ModalItems.ccName)  id = ModalItems.ccName;

	$scope.Auth = Auth.FFF;

    $scope.manyAction =  new ActualizationPreViewModel($scope, $filter, $timeout,$uibModalInstance);

	$scope.StopWhileCall = false;
	//Local storage
	$scope.Storage = a => {
		localStorage.setItem('ActualizationModal', JSON.stringify({ isOpen: a, clID: id	}));
        ModalOpen = a;
	};
    $scope.Storage(true);

    //for WS
    dWS = 0;

    $scope.example16settings    = {styleActive: false,externalIdProp: ''};
    $scope.example12settings    = {styleActive: false,buttonClasses: 'btn btn-default', displayProp: 'label', idProp : 'label'};
    $scope.example5customTexts  = { buttonDefaultText: 'поиск'    };
    $scope.example2customTexts  = { buttonDefaultText: 'Выберите' };
    $scope.example1model = [];
    $scope.example1model2 = [];

    $scope.Mylti = () => {
        let search='';
        angular.forEach($scope.example1model, todo => { search = `${search}+${todo.url}`; });
        window.open(`//google.com.ua/search?q=${search}`,"_blank");
    };

    //CONTACTS
    $scope.addContact = a => {
        var ccName;
        if(a) ccName = a; else ccName = "380";
        if(!$scope.client.phones) $scope.client.phones = [];
        var p = new crmContactModel({ ccName: ccName }).put();
        p.clID = id;
        p.ccID = lookUp(API.us.Sequence, 'ccID').seqValue;
        $scope.client.phones.push(p);
        $scope.ChekPhones();
    };

    $scope.dellCC = a => {
        new crmContactSrv().del(a.ccID);
        angular.forEach($scope.client.phones,(todo,key) => {
            if(todo.ccID == a.ccID)  $scope.client.phones.splice(key,1);
        });
    };

    $scope.CheckPost = () => {
        let ret = false;
        angular.forEach($scope.Post,todo => {
            if(todo.Name == $scope.client.post && !todo.tvID && todo.Name !== null)  ret =true;
        });
        return ret;
    };

    $scope.ChekPhones = () => {
		if( $scope.client.phones ){
            var cleaned = [];
            $scope.client.phones.forEach(itm => {
                var unique = true;
                cleaned.forEach( itm2 => {
                    if (_.isEqual(itm.ccName.substr(-8), itm2.ccName.substr(-8))) unique = false;
                });
                if (unique)
                    cleaned.push(itm);
                else
                    $scope.dellCC(itm);
            });
			cleaned.forEach( itm => {
                var unique = true;
                if (_.isEqual(itm.ccName.substr(-8),$scope.client.phoneDialer.substr(-8))) unique = false;
                if (unique) cleaned.push(itm);
                else $scope.dellCC(itm);
            });
            return cleaned;
		}
    };

    $scope.FioCheck = () => {
        if($scope.client)
        if($scope.client.fio) {
			if($scope.client.actualStatus == 101101){
				let b = $scope.client.fio;
				let a,d,c,e;
				a = $scope.client.fio.split(' ').length;
				//console.log($scope.client.dbPrefix)
				switch($scope.client.dbPrefix){
					default  :   if(b.match(/(НА|ИЧ|КЫЗЫ|ОГЛЫ|УЛЫ)$/)) d = false; else d =true;     break;
					case 'ua':   if(b.match(/(НА|ИЧ|КИЗИ|ОГЛИ|УЛИ|ІЧ)$/)) d = false; else d =true;     break;
				}
				if(a != 3 || d) e = true; else e = false;
				if($scope.ChangeSex) e = false;
				return e;
			}
        }
    };

    $scope.CopyPhone = () => {
        if($scope.client.phoneDialer) {
			let phoneDialer = angular.copy($scope.client.phoneDialer);
			$scope.client.phoneDialer = '';
            $scope.addContact(phoneDialer);
        }
    };

    $scope.CopyPhoneToPrymary = c => {
        $scope.client.phoneDialer = c.ccName;
        $scope.dellCC(c);
    };

	var debounce2;
	$scope.fixAdd = () => {
		if (typeof debounce2 === 'object') $timeout.cancel(debounce2);
		debounce2 = $timeout(() => {
		if($scope.client.adress) {
							let a = $scope.client.adress ? $scope.client.adress.replace(/\s+/g, ' ').replace(/\s*,/g, ',').replace(/,\s*/g, ', ').replace(/\s*\.\s*/g, '.') : "";
							$scope.client.adress = a;
							$scope.$apply();
		}
		}, 1500, false);
	};

    $scope.Save = a => {
         //Обновление клиента
            $scope.client.orgNoteStr = [];
            angular.forEach($scope.client.orgNote, todo => {$scope.client.orgNoteStr.push(todo.id); });
            $scope.client.orgNote   = $scope.client.orgNoteStr;

           $scope.ChangeNameFull();
 				//befo save check FIO data from morpher
			$timeout(() => {
				new nbrMorpherBDSrv().get('?country=' + $scope.client.dbPrefix + '&fio='+$scope.client.fio, cb => {

					if(a){
						if(cb.fio)      $scope.client.fio   = cb.fio;
						if(cb.famIO)    $scope.client.famIO = cb.famIO;
						if(cb.io)       $scope.client.io    = cb.io;
						if(!$scope.ChangeSex) if(cb.sex)      $scope.client.sex   = cb.sex;
                        //IF hold client
                        $scope.client.callDate = null;
					}

					new crmClientSaBDSrv().ins($scope.client, () => {
						$.when($scope.GetClient()).then( () => {
							if(a)$timeout(() => {
									new crmClientActualizeSrv().ins($scope.client,() => {
										//for WS
										dWS = 1;
										$timeout(() => {
											//IF close start autocall
                                            if(ModalItems.Type != "hand")
											if(!$scope.StopWhileCall)$scope.manyAction.ProgressStart(1);$scope.AutoHand=true;

											$uibModalInstance.dismiss('cancel');
										},500,false);
									});
							},700,false);
							else {
									$timeout(() => {
										//IF close start autocall
                                        if(ModalItems.Type != "hand")
										if(!$scope.StopWhileCall)$scope.manyAction.ProgressStart(1);$scope.AutoHand=true;
										$uibModalInstance.dismiss('cancel');
									},500,false);
							}
						});
					});
				});
			}, 700, false);
     };
});