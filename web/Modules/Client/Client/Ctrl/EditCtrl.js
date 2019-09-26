crmUA.controller('crmClientEditCtrl', function( $scope, $timeout, $stateParams, $filter, $translate,$rootScope) {
    var id = $stateParams.clID;

    $scope.manyAction =  new crmClientPreViewModel($scope, $filter, id, `Edit`, $translate, $rootScope);

    $scope.Cancel = a => { $scope.contacts.splice(a, 1); };

    $scope.load = false;

    /* ***     Tags     *** */
    $scope.tags = { data : []  };
    new crmTagListSrv().getFind({clID : id}, cb => { $scope.tags.data = cb ? cb : []; $scope.tags_old = angular.copy($scope.tags.data); $scope.$apply(); });

    new crmContactSrv().getFind({ clID : id, DateFrom: null, DateTo: null}, cb => { $scope.contacts = cb; $scope.contacts_old = angular.copy(cb);
                        $scope.Emails   = [];
                        $scope.CallPhone= [];
                        angular.forEach($scope.contacts, todo => {
                            if(todo.ccType == 37)  $scope.Emails.push(todo);
                            if(todo.ccType == 36)  $scope.CallPhone.push(todo);
                        });
                        $scope.$apply();
                    });
                    //new ccContactSrv().getFind( { clIDs :  [ { clID : id} ]   }, cb => { $scope.cc_contacts = cb; $scope.cc_contacts_old = angular.copy(cb); });

    $scope.GoTo = () =>{ window.location = '/#!/clientPreView/' + id; };

    //Linkovka
    $scope.link         = [];
    $scope.input        = [];
    $scope.input2       = [];
    angular.forEach($scope.contacts, todo => {
        $scope.input.push(new crmClientSrv().get('find/' + todo.ccName,() => {
            angular.forEach($scope.input,todo2 => { $scope.input2.push(todo2); $scope.$apply(); });
        }));

    });
    $scope.link = $scope.input2[0];

    $scope.status = [
        {"ID" : 101, "Name" : 'Прозвон'},
        {"ID" : 102, "Name" : 'Номер на проверку'},
        {"ID" : 103, "Name" : 'Хлам'},
    ];
    trans = () => {
        $translate(['ringing','numberCheck','trash']).then(a => {
            $scope.status.forEach( item => {
                switch(item.ID) {
                    case 101 : item.Name = a.ringing; break;
                    case 102 : item.Name = a.numberCheck; break;
                    case 103 : item.Name = a.trash; break;
                }
            });
        });
    };
    trans();
    $rootScope.$on('$translateChangeSuccess', () => {
        trans();
    });

    // if(crmResponsible != null){
    //     $scope.crmResponsible = crmResponsible;
    // }else{
    //     $scope.crmResponsible = [];
    //     $scope.crmResponsible.push({'emID' : null});
    // }

    // $scope.editRe = (emID,clID) => {
    //     if (emID != undefined) {
    //         new crmResponsibleSrv().get(clID,cb => {
    //             var reNew = cb;
    //             if(reNew != null) {
    //                 reNew[0].emID = emID;
    //                 new crmResponsibleSrv().upd(reNew[0]);
    //             }else{
    //                 reNew =[];
    //                 reNew.emID = emID;
    //                 reNew.clID = clID;
    //                 new crmResponsibleSrv().ins(reNew);
    //             }
    //             new crmResponsibleSrv().get(clID,cb => { $scope.crmResponsible = cb; $scope.$apply(); });
    //         });
    //     }
    // };

    //CRM CONTACTS
    $scope.addContact = () => {
        if(!$scope.contacts) $scope.contacts = [];
        let p = new crmContactModel({ clID: id,ccID: lookUp(API.us.Sequence, 'ccID').seqValue }).put();
        $scope.contacts.push(p);
     };
    $scope.dellCC = a => {
        new crmContactSrv().del(a.ccID);
        angular.forEach($scope.contacts,(todo,key) => {
            if(todo.ccID == a.ccID)  $scope.contacts.splice(key,1);
        });
    };

    //PERSONS
    // $scope.addPersons = () => {
    //     if(!$scope.persons) $scope.persons = [];
    //     var p = new crmPersonModel('').put('');
    //     p.clID = id;
    //     p.pnID = lookUp(API.us.Sequence, 'pnID').seqValue;
    //     $scope.persons.push(p);
    // };
    // $scope.dellPersons = a => {
    //     new crmPersonSrv().del(a.pnID);
    //     angular.forEach($scope.persons, (todo,key) => {
    //         if(todo.pnID == a.pnID)  $scope.persons.splice(key,1);
    //     });
    // };

    //Address
    $scope.addAddress = () => {
        if(!$scope.address) $scope.address = [];
        var p   = new crmAddressModel('').put();
        p.clID  = id;
        p.adtID = $scope.Enums.group[13].tvID; // adressTypes[0].tvID;
        p.adsID = lookUp(API.us.Sequence, 'adsID').seqValue;
        $scope.address.push(p);
    };
    $scope.dellAddress = a => {
        new crmAddressSrv().del(a.adsID);
        angular.forEach($scope.address, (todo,key) => {
            if(todo.adsID == a.adsID)  $scope.address.splice(key,1);
        });
    };

    $scope.CheckBeforeSave = () =>{
        var res = true;

        if (!angular.equals($scope.client_old, $scope.client)) {
            if (!($scope.client.clName)) {
                alert('Вы не заполнили поле "Контрагент" на закладке "Инфо о контакте"!');
                res = false;
            }
         }

        if (!angular.equals($scope.contacts_old, $scope.contacts)) {
            angular.forEach($scope.contacts, todo => {
                if (!((todo.ccName) && (todo.ccType)) && res) {
                    alert('Вы не заполнили все поля на закладке "Контакты"!');
                    res = false;
                }
            });
        }

        if (!angular.equals($scope.address_old, $scope.address)) {
            angular.forEach($scope.address, todo => {
                if (!((todo.adsName) && (todo.Postcode) && (todo.adtID)) && res) {
                    alert('Вы не заполнили все поля на закладке "Адрес"!');
                    res = false;
                }
                if ((todo.Postcode.toString().length < 5 || todo.Postcode.toString().length > 10)  && res) {
                    alert('Поле "Индекс" на закладке "Адрес" должно быть не менее 5 и не более 10ти знаков!');
                    res = false;
                }
            });
        }


        // if (!angular.equals($scope.persons_old, $scope.persons)) {
        //     angular.forEach($scope.persons, todo => {
        //         if (!((todo.pnName) && (todo.Post)) && res) {
        //             alert('Вы не заполнили все поля на закладке "Сотрудники"!');
        //             res = false;
        //         }
        //     });
        // }
        return res;
    };

    $scope.SaveWithCheck = (client,crmResponsible) => {
        if ($scope.CheckBeforeSave()) $scope.Save(client, crmResponsible);
    };

    $scope.updObjList = (oldObj,newObj,compareFieldName,applySrv) => {
        if (!angular.equals(oldObj, newObj)) {
            let i = newObj.length;
            myLoop = () => {
               setTimeout( () => {
                    if (!newObj[i-1][compareFieldName])
                        new applySrv().ins(newObj[i-1]);
                    else
                        new applySrv().upd(newObj[i-1]);
                  if(--i) myLoop();
               }, 200);
            };
            myLoop();
        }
    };

    $scope.Save = (client, crmResponsible) => {
        //TagS crmTagSrv
        if(!angular.equals($scope.tags_old, $scope.tags.data)) {
            insTagData = {"clID" : id, "tags" : []};
            angular.forEach($scope.tags.data, todo => {insTagData.tags.push(parseInt(todo.tagID)); });
            new crmTagListSrv().ins(insTagData);
        }

        //Обновление контактов
        $scope.updObjList($scope.contacts_old, $scope.contacts, "HIID", crmContactSrv);

        //Address
        $scope.updObjList($scope.address_old, $scope.address, "HIID", crmAddressSrv);

        //Persons
        // $scope.updObjList($scope.persons_old, $scope.persons, "HIID", crmPersonSrv);

        //Обновление клиента
        if (!angular.equals($scope.client_old, $scope.client)) {
            if (($scope.client.clStatus != $scope.client_old.clStatus) || ($scope.client.isFixed != $scope.client_old.isFixed)) {
                a               = new StatusModel('').put();
                a.clID          = $scope.client.clID;
                a.clStatus      = $scope.client.clStatus;
                a.isFixed       = $scope.client.isFixed;
                new StatusSrv().upd(a);
            }
            new crmClientSrv().upd($scope.client);
        }

        //Обновление ORG
        // console.log(`$scope.Org1`);
        //     console.log($scope.Org);
        //     console.log($scope.Org_old);
        //if($scope.client.isPerson)
        if ((!angular.equals($scope.Org_old, $scope.Org))) {
            // console.log(`$scope.Org2`);
            // console.log($scope.Org);
            if ($scope.Org.HIID)
                new orgSrv().upd($scope.Org);
            else
                new orgSrv().ins($scope.Org);
        }

        //Ответственный
        // var emID = client.emID;
        // if (emID) {
        //     reNew = {
        //         "clID" : [client.clID],
        //         "emID" : emID
        //     };
        //     new crmResponsibleListSrv().ins(reNew);
        // }

        //Set CallDate
        $scope.CallDateSave();
        setTimeout( () => {
                    $scope.gotoClientPreView();
        }, 500);

    };

    $scope.gotoClientPreView = () => {
        if($scope.crmClientExSrvDone) {
            window.location = '/#!/clientPreView/' + id;
        }
    };

    $scope.CallDateSave = () =>{
        $scope.crmClientExSrvDone = true;
        //if($scope.client.CallDate || $scope.client.ttsText || $scope.client.sum || $scope.client.curID || $scope.client.lengID) {
            $scope.crmClientExSrvDone = false;
            new crmClientExSrv().getFind({ clID : $scope.client.clID }, cb => {
                if(cb.length > 0){
                    let copy = Object.assign({}, $scope.client);
                    copy.HIID = cb[0].HIID;
                    new crmClientExSrv().upd(copy, cb => { $scope.crmClientExSrvDone = true; $scope.gotoClientPreView();});
                } else {
                     new crmClientExSrv().ins($scope.client, cb => { $scope.crmClientExSrvDone = true; $scope.gotoClientPreView();});
                }
            });
        //}
    };

});