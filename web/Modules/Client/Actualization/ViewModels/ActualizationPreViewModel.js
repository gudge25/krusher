class ActualizationPreViewModel extends BaseViewModel {
        constructor($scope, $filter, $timeout,$uibModalInstance) {
            super($scope, $filter, new crmClientSaBDSrv);
            this.scope      = $scope;

            $scope.ccCommentNBR = [
                {"id" : 1, "label" : "ФИО ВЕРНО"},
                {"id" : 2, "label" : "ФИО НЕ СКЛОНЯТЬ"},
                {"id" : 3, "label" : "АДРЕС ВЕРНО"},
                {"id" : 4, "label" : "НАЗВАНИЕ ВЕРНО"},
                {"id" : 5, "label" : "ПЕРЕИМЕНОВАЛИСЬ"},
               // {"id" : 6, "label" : "М"},
               // {"id" : 7, "label" : "Ж"},
                {"id" : 8, "label" : "КВЭД"}
            ];

            var debounce;
            $scope.ErrorCheck = () => {
                if($scope.client.actualStatus) {
                    if (typeof debounce === 'object') $timeout.cancel(debounce);

                    if($scope.client.actualStatus == 101101 && $scope.client.adress !== undefined)
                    debounce = $timeout(() => {
                        new nbrErrorCheckSrv().get(`?country=${$scope.client.dbPrefix}&adress=${$scope.client.adress}`, cb => {
                            if (cb.adress) {
                                $scope.Error = true;
                                $scope.ErrorMess = cb.adress;
                                $scope.ErrorCrit = cb.critical;
                                $scope.$apply();
                            } else {
                                $scope.Error = false;
                                delete $scope.ErrorMess;
                                delete $scope.ErrorCrit;
                                delete $scope.ChangeAdress;
                                $scope.$apply();
                            }
                        });
                    }, 50, false);
					else {
								$scope.Error = false;
                                delete $scope.ErrorMess;
                                delete $scope.ErrorCrit;
                                delete $scope.ChangeAdress;
                                $scope.$apply();

					}

                    if($scope.client.actualStatus != 101101) $scope.CopyPhone();
                }
            };

            $scope.GetClient = () => {
                new crmClientSaBDSrv().get(id, cb => {
					if(cb.inn === undefined) {
						$uibModalInstance.dismiss('cancel');
					}
                    $scope.client = cb;
                    $scope.client_old = angular.copy(cb);

					//Clean phone if dublicate
					$scope.ChekPhones();

					if($scope.client.actualStatus == 101102) $scope.CopyPhone();

                    //PATTERNS
                    $scope.patternEmail = /^[a-z]+[a-z0-9._-]+@[a-z]+\.[a-z.]{2,7}$/;
                    $scope.patternPhone2 = /^\d{12,13}$/;
                    $scope.patternLeng = str => {
                        let a = false;
                        if(str) {
                            switch ($scope.client.dbPrefix) {
                                case `ua`       :   $scope.patternLen = /[ЫыЭэЁёЪъ]/;  break;
                                default         :   $scope.patternLen = /[іІЇїЄє]/;    break;
                            }

                            if (str)if (str.match($scope.patternLen)) {
                                a = true;
                            }
                        }
                        return a;
                    };

                    $scope.patternPhone = str => {
                        let a = false;
                        if(str)if(!str.match(/^[0-9]{12,13}$/)) { a = true;}
                        return a;
                    };

                    $scope.headPost = { ua : [], ru : [] };
                    $scope.crmClientStatus = [];
                    angular.forEach(Enums, todo => {
                        if(todo.tyID == 1009)  $scope.headPost.ua.push(todo);
                        if(todo.tyID == 1008)  $scope.headPost.ru.push(todo);
                        if(todo.tyID == 1011)  $scope.crmClientStatus.push(todo);
                    });
                    $scope.crmClientStatus.push({tvID: null, Name: `Выберите статус`});

                    if($scope.client.dbPrefix == 'kz') $scope.Post =  $scope.headPost['ru'];
                        else
                    $scope.Post =  $scope.headPost[$scope.client.dbPrefix];
                        switch($scope.client.dbPrefix){
                            case 'kz': $scope.Post =  $scope.headPost['ru'];    $scope.INN="БИН";       break;
                            case 'ru': $scope.headPost[$scope.client.dbPrefix]; $scope.INN="ОКПО";      break;
                            case 'ua': $scope.headPost[$scope.client.dbPrefix]; $scope.INN="ЄДРПОУ";    break;
                            //default: break;
                        }

                    $scope.FioCheck();

                    if($scope.Post) if(_.isEmpty($filter('filter')($scope.Post, { "Name": $scope.client.post }, true))) $scope.Post.push( {"Name" : $scope.client.post});

                    $scope.contacts = $scope.client.phones ;
                    $scope.example1data = [
                        {id: 1, label: "Наименование",      url: $scope.client.nameShort},
                        {id: 2, label: "ИНН",               url: $scope.client.inn },
                        {id: 3, label: "Адрес",             url: $scope.client.adress },
                        {id: 4, label: "ФИО руководителя",  url: $scope.client.fio }
                    ];

                    new nbrSimpleBDSrv().get(`?country=${cb.dbPrefix}&inn=${cb.inn}`,cb => {
                        $scope.nbrSimple = cb;
                        //Diff phoness
                        if($scope.nbrSimple.phones){
                            $scope.nbrSimple.phones     = $scope.nbrSimple.phones.split(",").map( a => { return a; });
                            $scope.client.phonesMap     = $scope.client.phones.map( a => { return a.ccName; });
                            $scope.client.phonesMap.push($scope.client.phoneDialer);
                            $scope.nbrSimple.phonesMap  = _.difference($scope.nbrSimple.phones,$scope.client.phonesMap);
                        }
                        //Diff full,fio,Kved

                        if($scope.nbrSimple.nameFull)
                            if ($scope.client.nameFull != $scope.nbrSimple.nameFull) //Полное наименование не совпадает
                            {
                                $scope.client.nameFull = $scope.nbrSimple.nameFull;
                                $scope.nbrSimple.nameFullChange = true;
                            }

                        if($scope.nbrSimple.fio)
                            if( $scope.client.fio != $scope.nbrSimple.fio)              $scope.client.fio       = $scope.nbrSimple.fio;

                        if($scope.nbrSimple.kvedCode)
                        if( $scope.client.kvedCode != $scope.nbrSimple.kvedCode) {
                            $scope.client.kvedCode  = $scope.nbrSimple.kvedCode;
                            $scope.client.kvedDescr = $scope.nbrSimple.kvedDescr;
                        }

                        if($scope.nbrSimple.nameShort || $scope.client.nameShort === null) $scope.client.nameShort = $scope.nbrSimple.nameShort;

                        $scope.$apply();
                    });

                    $scope.ccContactStatus = [
                        {"Name" : "ОШИБКА"},
                        {"Name" : "НЕПР"},
                        {"Name" : "НЕОТ"},
                        {"Name" : "ПОЧТА"},
                        {"Name" : "АКИМАТ"},
                        {"Name" : "С\С"},
                        {"Name" : "О\О"},
                        {"Name" : "АДМИН"},
                        {"Name" : "ОТКАЗ"},
                        {"Name" : "Свой Вариант"}
                    ];
                    angular.forEach($scope.client.phones, todo => {
                        if(todo.ccComment) if(_.isEmpty($filter('filter')($scope.ccContactStatus, {Name: todo.ccComment}, true))) $scope.ccContactStatus.push( {"Name" : todo.ccComment});
                    });
                    $scope.$apply();
                });
            };

            $scope.GetClient();

            $scope.ChangeNameFull = () => {
				if($scope.nbrSimple)
                if($scope.nbrSimple.nameFullChange || $scope.nameFullChange ){
                    if($scope.nbrSimple.nameFull !== $scope.client.nameFull)
                    {
                        var test = new nbrFull2ShortBDSrv().get(`?country=${$scope.client.dbPrefix}&nameFull=${$scope.client.nameFull}`,cb => { return cb; });
                                                $timeout(() => {
                                                if(test.responseText){
                                                        let testJson = JSON.parse(test.responseText);
                                                        $scope.client.nameShort = testJson.nameShort;
                                                }
                                                }, 500, false);
                   }

               }
            };

            $scope.Get_cc_contacts = () => {
                new ccContactSrv().get(id, cb  => { $scope.cc_contacts = cb; });
            };
            $scope.Get_cc_contacts();
        }
}