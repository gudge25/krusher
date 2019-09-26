function NavBarCtrl($scope, $filter, Auth, Pages, Progress, $state, $translate,$translatePartialLoader,$rootScope, AclService, HotDial){
    //if(!Auth.FFF ) { GoTOAuth(); return -1; }
    
    $scope.ccMissed = [];    
    new ccMissedSrv().ins(null, cb => { if(cb.length > 0) { $scope.ccMissed = cb[0]; $scope.$apply();} });
    setInterval(() => {
       new ccMissedSrv().ins(null, cb => { if(cb.length > 0) { $scope.ccMissed = cb[0]; $scope.$apply();} });
    }, 600000);

    $scope.global = { Loading : false };

    $scope.manyAction   =  new MenuViewModel($scope, $filter, $translate, AclService);

    $scope.NowDate = (new Date()).getFullYear();
    this.filter         =  $filter;

    //console.log(AclService);
    $scope.LogoHide = false;
    $scope.Logo = a => {       
        if(!isBoolean(a)){
            if(!Boolean($scope.LogoHide))
                $scope.LogoHide = true;
            else
                $scope.LogoHide = false;   
        }
    };
    $scope.googleCount = window.location.hostname.substring(window.location.hostname.indexOf('.')+1) == `krusher.biz` ? true : false;
    
    //Xlebnue kroshki
    $scope.currState = $state;
    $scope.$watch('currState.current.name', () => {
      $scope.State = $scope.currState.current.data;
      $scope.S = $scope.currState.current.name;
    });

    [$scope.auth,$scope.Pages,$scope.Progress,$scope.HotDial] = [Auth,Pages,Progress,HotDial];

    //For ffID in autocall
    $scope.$watch('Pages.FFF', () => {
        if($scope.Pages.FFF) {
            if($scope.Pages.FFF.ffID) $scope.Progress.FFF.ffID = $scope.Pages.FFF.ffID; $scope.AutoStatus();
        }
        else $scope.Progress.FFF.ffID = null;
    });

    $scope.GetEmD = first => {
        //console.log(1111);
        // new emEmployeeSrv().getFind({ emID : EMID }, cb => { 
        //     if(cb.length > 0){ 
        //         $scope.EM = cb[0]; 
        //         if(!first){
        //             let Storage = JSON.parse(localStorage.getItem('Auth'));
        //             Storage.onlineStatus = $scope.EM.onlineStatus;
        //             localStorage.setItem('Auth', JSON.stringify(Storage));
        //         }
        //         //$scope.global.Loading = false;
        //         $scope.$apply(); 
        //     } 
        //     else 
        //         $scope.global.Loading = false;
        // });
                if(!first){
                    let Storage = JSON.parse(localStorage.getItem('Auth'));
                    Storage.onlineStatus = $scope.EM.onlineStatus;
                    localStorage.setItem('Auth', JSON.stringify(Storage));
                }
                $scope.global.Loading = false;
                $scope.$apply(); 
    };
    $scope.GetEm = debounce($scope.GetEmD);

    $scope.GetEmFirst = () => {
        new emEmployeeSrv().getFind({ emID : EMID}, cb => { 
            if(cb.length > 0){ 
                $scope.EM = cb[0]; 
                $scope.a.onlineStatus = JSON.parse(localStorage.getItem('Auth')).onlineStatus;
                $scope.EM.onlineStatus = $scope.a.onlineStatus;
                new emStatusSrv().upd($scope.EM, cb => { $scope.GetEm(); /* FactEmRun.name = null; */} );
                $scope.$apply(); 
            }
        });
    };

    $scope.UpdEm = model => {
        $scope.global.Loading = true;
        if(model.tvID != $scope.EM.onlineStatus){
            $scope.EM.onlineStatus = model.tvID;
            console.log(`updEM`); 
            // if(model.tvID != 103507)
            //     if(model.tvID == 103501)
            //         $scope.PauseAll2(false);
            //     else 
            //         $scope.PauseAll2(true);    
                    
            new emStatusSrv().upd($scope.EM, cb => { $scope.GetEm(); /* FactEmRun.name = null; */ } ); 
            $scope.global.Loading = false;
        } else $scope.global.Loading = false;   
    };

    //When pause active
    $scope.UpdEm2 = model => {
        $scope.global.Loading = true;
        if(model.tvID != $scope.EM.onlineStatus){
            $scope.EM.onlineStatus = model.tvID;
            console.log(`updEM2`); 
            //new emStatusSrv().upd($scope.EM, cb => { $scope.GetEm(); FactEmRun.name = null; } ); 
        } else $scope.global.Loading = false;  
    };

    $scope.QueueSummary = data => {
        if(data.length > 0 &&  $scope.Queues.myQueues.length  > 0){
                $scope.Queues.myQueues.forEach( e => {
                            data.forEach( e2 => {
                                if(e2.stateinterface)
                                    if(e.interface == e2.stateinterface.split("_")[0] && e2.queue == e.queID) {
                                        if(e2.event == `QueueMemberPause`)
                                            e.isPause = e2.pause;
                                        else
                                            e.isPause = e2.paused;
                                    }
                            });
                });
                $scope.PauseSingl();
                $scope.$apply();
        }
    };

    $scope.Pause = { AllBtn : false };
    
    $scope.PauseAllD = a => {
        angular.forEach($scope.Queues.myQueues,todo => {
            if(isBoolean(a)) $scope.Pause.AllBtn = isBoolean(a) ? Boolean(a) : true; 
            todo.isPause = $scope.Pause.AllBtn; 
            $scope.manyAction.AMI('QueuePause',todo);
        });
        
        // if($scope.Pause.AllBtn)
        //     $scope.UpdEm2({ "tvID" : 103502});
        // else
        //     $scope.UpdEm2({ "tvID" : 103501}); 
    };
    $scope.PauseAll = debounce($scope.PauseAllD);

    $scope.PauseAll2 = a => {
        angular.forEach($scope.Queues.myQueues,todo => {
            if(isBoolean(a)) $scope.Pause.AllBtn = isBoolean(a) ? Boolean(a) : true; 
            todo.isPause = $scope.Pause.AllBtn; 
            $scope.manyAction.AMI('QueuePause',todo);
        });
    };

    $scope.PauseSingl = param => {
        $scope.global.Loading = true;
        if(param) {
            $scope.manyAction.AMI('QueuePause',param); 
        }
        let Qty = 0;
        angular.forEach($scope.Queues.myQueues,todo => {
            if(todo.isPause) Qty++;
        });
        if(Qty == $scope.Queues.myQueues.length)  $scope.Pause.AllBtn = true;
        if(Qty == 0)   $scope.Pause.AllBtn = false;
        // if(param) {
        //     if(param.isPause) 
        //         $scope.UpdEm2({ "tvID" : 103502 });
        //     else {
        //         if($scope.Pause.AllBtn ) 
        //             $scope.global.Loading = false;
        //         else 
        //             $scope.UpdEm2({ "tvID" : 103501 }); 
                    
        //     }
        // } else $scope.global.Loading = false;
        $scope.global.Loading = false;
    };

    $scope.HotDial.FFF = {
        ccName :null,
        coID:null,
        isDial: false,
        isBridge: false
    };

    setTimeout(() => {
            //$scope.manyAction.AMI('ExtensionState',todo);
            $scope.manyAction.AMI('DeviceStateList');
            angular.forEach($scope.Queues.myQueues,todo => {
                 $scope.manyAction.AMI('QueueSummary',todo);
            });
    }, 3000);

    $scope.CallEnd = () => {
        console.log(`CallEnd`);
        $scope.HotDial.FFF.isDial   = false;
        $scope.HotDial.FFF.isBridge = false;
        $scope.$apply();
    };

    $scope.CallBridge = () => {
        $scope.HotDial.isBridge = true;
        $scope.$apply();
    };

    $scope.dell = false;
    $scope.DialPad = a => {
        if(!$scope.HotDial.FFF.isDial && (a || a == 0)){
            if(!$scope.HotDial.FFF.ccName) $scope.HotDial.FFF.ccName = '';
            $scope.HotDial.FFF.ccName = `${$scope.HotDial.FFF.ccName}${a}`;
            $scope.ClearPhone();
        }
    };

    $scope.DialPadDelLast = () => {
        if($scope.HotDial.FFF.ccName)
           $scope.HotDial.FFF.ccName =  $scope.HotDial.FFF.ccName.slice(0, -1);
    };

    $scope.ClearPhone = () => {
        if($scope.HotDial.FFF.ccName ) {
            $scope.HotDial.FFF.ccName.trim();
            $scope.HotDial.FFF.ccName = $scope.HotDial.FFF.ccName.replace(/\D/g, "");
            if($scope.HotDial.FFF.ccName.length == 10) if($scope.HotDial.FFF.ccName.substring(0,1) == parseInt(0) && HotDial.FFF.ccName.substring(1,2) != parseInt(0)) $scope.HotDial.FFF.ccName = `38${$scope.HotDial.FFF.ccName}`;
            if($scope.HotDial.FFF.ccName.substring(0,3) == parseInt(380)) $scope.HotDial.FFF.ccName = $scope.HotDial.FFF.ccName.substring(0,12);
        }
    };

    window.onbeforeunload = e => {
        console.log(`Close Event`);
        if(eventSource){ eventSource.close();eventSource=null; }
        if(ws) ws.loguot();
        //Auto change status to logoff
        if($scope.EM.onlineStatus !== 103507) { $scope.EM.onlineStatus = 103507; new emStatusSrv({async: false}).upd($scope.EM); }
    };

    $scope.devicestatechanges = a => {
        $scope.devicestatechange = a;
        if(a == `RINGING`) notify('SIP',a);
        $scope.$apply();
    };

    $scope.AmiEvents = e => {
        if(e)if(e.calleridnum)
        //new crmClientSrv().get('find/' + e.calleridnum, cb => {
                new crmClientSrv().get('find/' + e.calleridnum, cb => {
                    if(payload.length > 0){
                        let clName  = cb[0].clName ? cb[0].clName : null;
                        let clID    = cb[0].clID ? cb[0].clID : null;
                        let title   = `${$filter('translate')('calling')} ${$filter('translate')('from2')} ${e.calleridnum} ${$filter('translate')('na')} ${e.destcalleridnum}`;
                        let body    =  `${$filter('translate')('source')}: ${e.source}, ${$filter('translate')('client')}: ${clName}` ;
                        notify( title ,body, clID);
                    } else {
                        let title   = `${$filter('translate')('calling')} ${$filter('translate')('from2')} ${e.calleridnum} ${$filter('translate')('na')} ${e.destcalleridnum}`;
                        let body    =  `${$filter('translate')('source')}: ${e.source}`;
                        notify( title ,body, null);
                    }
                 });
        //});
    };

    $scope.AutoStatus = () => {
        $scope.AutoProcess = [];
        $scope.Play = false;
        if($scope.Progress.FFF.id_scenario){
            new astAutoProcessSrv().getFind({ id_scenario: $scope.Progress.FFF.id_scenario, ffID: $scope.Progress.FFF.ffID , limit: 3, sorting: `DESC`, field: `id_autodial` },cb => {
                $scope.AutoProcess = cb;

                // angular.forEach(cb,todo => {
                //     if(todo.id_scenario == $scope.Progress.FFF.id_scenario && todo.ffID == $scope.Progress.FFF.ffID /*&& (todo.process == 101601 || todo.process == 101602)*/) $scope.AutoProcess.push(todo);
                // });
                angular.forEach($scope.AutoProcess,todo => {
                    if(todo.process == 101602) {
                        $scope.Play = true;
                        if($scope.Progress.FFF.id_autodial === undefined) {
                            $scope.Progress.FFF.id_autodial         = todo.id_autodial;
                            $scope.Progress.FFF.ffID                = todo.ffID;
                            $scope.Progress.FFF.emID                = todo.emID;
                            $scope.Progress.FFF.Aid                 = todo.Aid;
                            $scope.Progress.FFF.called              = todo.called;
                            $scope.Progress.FFF.targetCalls         = todo.targetCalls;
                            $scope.Progress.FFF.targetCalls         = todo.targetCalls;
                            $scope.Progress.FFF.errorDescription    = todo.errorDescription;
                            $scope.Progress.FFF.description         = todo.description;
                            $scope.Progress.FFF.TimeBegin           = todo.TimeBegin;
                            $scope.Progress.FFF.TimeUpdated         = todo.TimeUpdated;
                        }
                    }
                });
                $scope.$apply();
            });
        }
        else{
            if($scope.Progress.FFF.ffID)
            new astAutoProcessSrv().getFind({  },cb => {
                angular.forEach(cb,todo => {
                    if(todo.ffID == $scope.Progress.FFF.ffID && (todo.process == 101601 || todo.process == 101602)) $scope.AutoProcess.push(todo);
                });
                $scope.$apply();
            });
        }
    };

    var IfAuth = JSON.parse(localStorage.getItem('Auth'));
    if(IfAuth) $scope.auth.FFF = IfAuth;

    let sx;
    $scope.Start = (last,newd) => {
        if($scope.auth.FFF && !sx)
        {
            $scope.AutoStatus();

            if( last !== undefined || newd !== undefined ){
                //For ROLES
                sx = true;
                $scope.manyAction.ACL();
                if(last != newd){
                        let user = $scope.auth.FFF;
                        if(user){
                            switch(user.roleName){
                              case `Admin`      : { user.getRoles  = () => ['Admin'];       break; }
                              case `Supervisor` : { user.getRoles  = () => ['Supervisor'];  break; }
                              case `Operator`   : { user.getRoles  = () => ['Operator'];    break; }
                              case `Developer`  : { user.getRoles  = () => ['Developer'];   break; }
                              case `Client`     : { user.getRoles  = () => ['Client'];   break; }
                              case `Validator`  : { user.getRoles  = () => ['Validator'];   break; }
                              default : {break ;}
                            }
                            AclService.setUserIdentity(user); 
                        }
                }
                //CAN
                $scope.can = AclService.can;
                //DataPOOLSetter
                FactCountriesRun.name  = null;
                FactEmRun.name         = null;
                FactEnumRun.name       = null;
                FactFileRun.name       = null;
                FactIVRRun.name        = null;
                FactOperatorRun.name   = null;
                FactPrefixRun.name     = null;
                FactQueuesRun.name     = null;
                FactRecordRun.name     = null;
                FactScenarioRun.name   = null;
                FactTrunkRun.name      = null;
                FactSIPRun.name        = null;
                FactBasesRun.name      = null;
                FactTagRun.name        = null;
                FactRoleRun.name       = null;
                FactDocsTypesRun.name  = null;
                FactProccessRun.name   = null;
                FactTTSRun.name        = null;
                FactRegionsRun.name    = null;
                FactTrunkPoolRun.name  = null;
                FactCustomDestenationRun.name     = null;
                FactTimeGroupRun.name  = null;
                FactCallBackRun.name   = null;
                FactCompanyRun.name    = null;
                FactRouteOutRun.name   = null;
                FactConferenceRun.name = null;
                FormTypeRun.name       = null;
                FactMarketPlaceRun.name = null;


                var language;
                $rootScope.$on('$translateChangeSuccess', (a,b) => {
                    if(b.language !== language){
                        language = b.language;
                        var arr = [
                            {tvID: 102314, tyID: 1023, Name: "cz"},
                            {tvID: 102313, tyID: 1023, Name: "lv"},
                            {tvID: 102312, tyID: 1023, Name: "ja"},
                            {tvID: 102311, tyID: 1023, Name: "pl"},
                            {tvID: 102310, tyID: 1023, Name: "lt"},
                            {tvID: 102309, tyID: 1023, Name: "it"},
                            {tvID: 102308, tyID: 1023, Name: "fr"},
                            {tvID: 102307, tyID: 1023, Name: "de"},
                            {tvID: 102306, tyID: 1023, Name: "pt"},
                            {tvID: 102305, tyID: 1023, Name: "es"},
                            {tvID: 102304, tyID: 1023, Name: "en"},
                            {tvID: 102303, tyID: 1023, Name: "be"},
                            {tvID: 102302, tyID: 1023, Name: "ua"},
                            {tvID: 102301, tyID: 1023, Name: "ru"}
                        ];
                        arr.forEach( e => {
                                             if( e.Name == b.language ) FactCountriesRun.name  = e.tvID;
                        });
                    }
                });

                $scope.GetEm(true);
            }


            $scope.manyAction.Mod();
            new PrivateSrv().getAll( cb => {

                $scope.GetEmFirst();
               

                $scope.a                = cb[0];
                //console.log($scope.a.onlineStatus); 
                    $scope.auth.FFF    = $scope.a;
                    if($scope.a)
                        if($scope.a.emID)
                        {
                            EMID = $scope.a.emID;
                                    $scope.a.PASSWORD = btoa(PASSWORD);
                                    if($scope.a.sipID)
                                        new astSippeersSrv().getFind({sipID:$scope.a.sipID}, cb => { if(cb[0]) if(cb[0].sipLogin) $scope.a.sipLogin = SIP = cb[0].sipLogin; localStorage.setItem('Auth', JSON.stringify($scope.a));  });
                                    else
                                        localStorage.setItem('Auth', JSON.stringify($scope.a));
                        }
                    

                    $scope.$apply();
            });

            if(ReconnectingEventSource)
            eventSource = new ReconnectingEventSource('/events',{ withCredentials: true });

            if(eventSource){
                eventSource.addEventListener('api', evt => {
                    //{"event":"update","data":{"route":"/api/ast/autodial/process","data":[{"$Aid":10}]}}
                    let data = JSON.parse(evt.data);
                    switch(data.event){
                        case "ping"   : { break;}
                        case "create" : { /*Count(`create`,data);*/ break;}
                        case "update" : {
                                            switch(data.data.route)
                                            {
                                                case API.ast.Scenario       : { console.log(`Scenario update`); break;}
                                                case API.ast.AutoProcess    : {
                                                    //console.log(`Update auto procces ${data.payload.process} ${$scope.auth.FFF.emID} == ${data.payload.emID}`);
                                                    if( $scope.auth.FFF.emID == data.payload.emID) {
                                                        if(data.payload.process == 101603 && data.payload.process == 101604)
                                                            alert(`Автообзвон завершен, ИД:${data.payload.id_autodial}, errorDescription: ${data.payload.errorDescription}`);
                                                        $scope.AutoStatus();
                                                        var scope   = angular.element(document.getElementById('AutoProcess')).scope(); if(scope) if(scope.manyAction) scope.manyAction.Find();
                                                    }
                                                break;}

                                                //101603
//{"event":"update","data":{"route":"/api/ast/autodial/process"},"payload":{"isActive":true,"id_autodial":249,"process":101602,"ffID":896,"id_scenario":15,"emID":3,"factor":1,"called":2,"targetCalls":null,"errorDescription":"FOR EMPTY QUEUES = TRUE LOGIC Queue hold 82, exten 718, context db_queue_10, id_autodial 249","description":null,"planDateBegin":"2018-12-12T15:05:00.000Z","HIID":1544703578189213}}


                                                //case API.ast.Scenario : { console.log(`Scenario update`); break;}
                                                //case API.ast.Scenario : { console.log(`Scenario update`); break;}
                                                //case API.ast.Scenario : { console.log(`Scenario update`); break;}
                                                //case API.ast.Scenario : { console.log(`Scenario update`); break;}
                                                //case API.ast.Scenario : { console.log(`Scenario update`); break;}

                                            }
                                           // if(data.data.route == `/api/ast/autodial/process` ){ console.log(`Update auto procces`);  alert(`Автообзвон обновлен или завершен`); $scope.AutoStatus(); }/*Count(`update`,data);*/
                                        break;}
                        case "delete" : { break;}
                        default       : { break;}
                    }
                });

                eventSource.onerror = event => {
                        if (event.eventPhase == EventSource.CLOSED) {
                            eventSource.close();
                            console.log("Event Source Closed");
                        }
                };

            }
        }
    };

    $scope.$watch('auth.FFF', (last,newd) =>  {
       $scope.Start(last,newd);
    });

    $scope.ACall = a => {
        $scope.autocall=a;
        $scope.$apply();
    };

    $scope.trans = () => {
            $translate('title').then(a => { document.title = a; });
    };

    $rootScope.$on('$translateChangeSuccess', () => {
        $scope.trans();
        if ($scope.Enums.data !== undefined) {
            $scope.Enums.data.forEach( item => {
                if(item)
                if(item.NameT)
                switch (item.NameT){
                    case "Телефон"                              :   item.Name  = this.filter('translate')('phone');                              break;
                    case "Тел.Доп"                              :   item.Name  = this.filter('translate')('addedPhone');                         break;
                    case "Наименование полное"                  :   item.Name  = this.filter('translate')('fullName');                           break;
                    case "Телеф дозвона"                        :   item.Name  = this.filter('translate')('phoneDialer');                        break;
                    case "Комментарий"                          :   item.Name  = this.filter('translate')('Comment');                            break;
                    case "Адрес"                                :   item.Name  = this.filter('translate')('address');                            break;
                    case "Наименование краткое"                 :   item.Name  = this.filter('translate')('shortName');                          break;
                    case "Руков Пол"                            :   item.Name  = this.filter('translate')('headSex');                            break;
                    case "Руков Должность"                      :   item.Name  = this.filter('translate')('headPosition');                       break;
                    case "Руков ФИО"                            :   item.Name  = this.filter('translate')('headFullName');                       break;
                    case "Руков ФамИО"                          :   item.Name  = this.filter('translate')('headNameSur');                        break;
                    case "Руков Имя Отч"                        :   item.Name  = this.filter('translate')('headPatronymicName');                 break;
                    case "Телеф код города"                     :   item.Name  = this.filter('translate')('phoneAreaCode');                      break;
                    case "Оператор"                             :   item.Name  = this.filter('translate')('operator');                           break;
                    case "Область"                              :   item.Name  = this.filter('translate')('region');                             break;
                    case "Примечание Адрес"                     :   item.Name  = this.filter('translate')('noteAddress');                        break;
                    case "Переговоры"                           :   item.Name  = this.filter('translate')('conversation');                       break;
                    case "Закрыта удачно"                       :   item.Name  = this.filter('translate')('closedSuccessfully');                 break;
                    case "Переговоры или отзыв"                 :   item.Name  = this.filter('translate')('conversReview');                      break;
                    case "Ценовое предложение"                  :   item.Name  = this.filter('translate')('priceOffer');                         break;
                    case "Анализ ситуации"                      :   item.Name  = this.filter('translate')('analysisSituation');                  break;
                    case "Поиск принимающих решение"            :   item.Name  = this.filter('translate')('searchMaker');                        break;
                    case "Предложение"                          :   item.Name  = this.filter('translate')('offer');                              break;
                    case "Нуждается в анализе"                  :   item.Name  = this.filter('translate')('needsAnalysis');                      break;
                    case "Оценка"                               :   item.Name  = this.filter('translate')('mark');                               break;
                    case "Закрыта неудачно"                     :   item.Name  = this.filter('translate')('closedUnsuccessfully');               break;
                    case "Выполнен"                             :   item.Name  = this.filter('translate')('completed');                          break;
                    case "Заплонирован"                         :   item.Name  = this.filter('translate')('scheduled');                          break;
                    case "Отменен"                              :   item.Name  = this.filter('translate')('canceled');                           break;
                    case "Просрочен"                            :   item.Name  = this.filter('translate')('overdue');                            break;
                    case "Приход"                               :   item.Name  = this.filter('translate')('coming');                             break;
                    case "Расход"                               :   item.Name  = this.filter('translate')('consumption');                        break;
                    case "Безналичный расчет"                   :   item.Name  = this.filter('translate')('cashlessPayments');                   break;
                    case "Наличные"                             :   item.Name  = this.filter('translate')('cash');                               break;
                    case "Аналитик"                             :   item.Name  = this.filter('translate')('analyst');                            break;
                    case "Конкурент"                            :   item.Name  = this.filter('translate')('competitor');                         break;
                    case "Клиент"                               :   item.Name  = this.filter('translate')('client');                             break;
                    case "Интегратор"                           :   item.Name  = this.filter('translate')('integrator');                         break;
                    case "Инвестор"                             :   item.Name  = this.filter('translate')('investor');                           break;
                    case "Партнер"                              :   item.Name  = this.filter('translate')('partner');                            break;
                    case "Пресса"                               :   item.Name  = this.filter('translate')('press');                              break;
                    case "Перспективный"                        :   item.Name  = this.filter('translate')('perspective');                        break;
                    case "Посредник"                            :   item.Name  = this.filter('translate')('mediator');                           break;
                    case "Другое"                               :   item.Name  = this.filter('translate')('other');                              break;
                    case "Основной"                             :   item.Name  = this.filter('translate')('main');                               break;
                    case "Рабочий"                              :   item.Name  = this.filter('translate')('working');                            break;
                    case "Другой"                               :   item.Name  = this.filter('translate')('ather');                              break;
                    case "В наличии"                            :   item.Name  = this.filter('translate')('inStock');                            break;
                    case "На складе"                            :   item.Name  = this.filter('translate')('inWarehouse');                        break;
                    case "Под заказ"                            :   item.Name  = this.filter('translate')('underOrder');                         break;
                    case "Новый"                                :   item.Name  = this.filter('translate')('new');                                break;
                    case "Бу"                                   :   item.Name  = this.filter('translate')('used');                               break;
                    case "Нет в наличии"                        :   item.Name  = this.filter('translate')('notAvailable');                       break;
                    case "Ожидается"                            :   item.Name  = this.filter('translate')('expected');                           break;
                    case "Заблокирован"                         :   item.Name  = this.filter('translate')('blocked');                            break;
                    case "вне зоны"                             :   item.Name  = this.filter('translate')('outZone');                            break;
                    case "номер отключен"                       :   item.Name  = this.filter('translate')('numberDeactivated');                  break;
                    case "Автоответчик"                         :   item.Name  = this.filter('translate')('answeringMachine');                   break;
                    case "больше не звонить"                    :   item.Name  = this.filter('translate')('notCall');                            break;
                    case "не номер клиента"                     :   item.Name  = this.filter('translate')('notCustomerNumber');                  break;
                    case "ИСПОЛНИТЕЛЬНОМУ ДИРЕКТОРУ"            :   item.Name  = this.filter('translate')('TOEXECUTIVEDIRECTOR');                break;
                    case "КОММЕРЧЕСКОМУ ДИРЕКТОРУ"              :   item.Name  = this.filter('translate')('COMMERCIALDIRECTOR');                 break;
                    case "ФИНАНСОВОМУ ДИРЕКТОРУ"                :   item.Name  = this.filter('translate')('FINANCIALDIRECTOR');                  break;
                    case "ЗАМЕСТИТЕЛЮ ДИРЕКТОРА"                :   item.Name  = this.filter('translate')('DEPUTYDIRECTOR');                     break;
                    case "ЗАМЕСТИТЕЛЮ ГЕНЕРАЛЬНОГО ДИРЕКТОРА"   :   item.Name  = this.filter('translate')('DEPUTYDIRECTORGENERAL');              break;
                    case "ИО ДИРЕКТОРА"                         :   item.Name  = this.filter('translate')('ACTINGDIRECTOR');                     break;
                    case "ИО ГЕНЕРАЛЬНОГО ДИРЕКТОРА"            :   item.Name  = this.filter('translate')('actingCeo');                          break;
                    case "ВРИО ДИРЕКТОРА"                       :   item.Name  = this.filter('translate')('TEMPORARILYACTINGDIRECTOR');          break;
                    case "ВРИО ГЕНЕРАЛЬНОГО ДИРЕКТОРА"          :   item.Name  = this.filter('translate')('TEMPORARILYactingCeo');               break;
                    case "ПРЕДСЕДАТЕЛЮ ПРАВЛЕНИЯ"               :   item.Name  = this.filter('translate')('CHAIRMANMANAGEMENTBOARD');            break;
                    case "ПРЕДСЕДАТЕЛЮ"                         :   item.Name  = this.filter('translate')('CHAIRPERSON');                        break;
                    case "ИО ПРЕДСЕДАТЕЛЯ"                      :   item.Name  = this.filter('translate')('ACTINGDICHAIRPERSON');                break;
                    case "ВРИО ПРЕДСЕДАТЕЛЯ"                    :   item.Name  = this.filter('translate')('TEMPORARILYACTINGDICHAIRPERSON');     break;
                    case "ГЛАВЕ"                                :   item.Name  = this.filter('translate')('CHAPTER');                            break;
                    case "ГЛАВЕ ПРАВЛЕНИЯ"                      :   item.Name  = this.filter('translate')('CHIEFMANAGEMENTBOARD');               break;
                    case "УЧРЕДИТЕЛЮ"                           :   item.Name  = this.filter('translate')('FOUNDER');                            break;
                    case "ЗАВЕДУЮЩЕМУ"                          :   item.Name  = this.filter('translate')('head');                               break;
                    case "РЕКТОРУ"                              :   item.Name  = this.filter('translate')('RECTOR');                             break;
                    case "РУКОВОДИТЕЛЮ"                         :   item.Name  = this.filter('translate')('toHead');                             break;
                    case "ГЛАВНОМУ ВРАЧУ"                       :   item.Name  = this.filter('translate')('MAINDOCTOR');                         break;
                    case "ПРЕЗИДЕНТУ"                           :   item.Name  = this.filter('translate')('PRESIDENT');                          break;
                    case "УПРАВЛЯЮЩЕМУ"                         :   item.Name  = this.filter('translate')('MANAGER');                            break;
                    case "ДИРЕКТОРУ"                            :   item.Name  = this.filter('translate')('toDirector');                         break;
                    case "ГЕНЕРАЛЬНОМУ ДИРЕКТОРУ"               :   item.Name  = this.filter('translate')('toCeo');                              break;
                    case "ВИКОНАВЧОМУ ДИРЕКТОРУ"                :   item.Name  = this.filter('translate')('TOEXECUTIVEDIRECTOR');                break;
                    case "КОМЕРЦІЙНОМУ ДИРЕКТОРУ"               :   item.Name  = this.filter('translate')('COMMERCIALDIRECTOR');                 break;
                    case "ФІНАНСОВОМУ ДИРЕКТОРУ"                :   item.Name  = this.filter('translate')('FINANCIALDIRECTOR');                  break;
                    case "ЗАСТУПНИКУ ДИРЕКТОРА"                 :   item.Name  = this.filter('translate')('DEPUTYDIRECTOR');                     break;
                    case "ЗАСТУПНИКУ ГЕНЕРАЛЬНОГО ДИРЕКТОРА"    :   item.Name  = this.filter('translate')('DEPUTYDIRECTORGENERAL');              break;
                    case "ВО ДИРЕКТОРА"                         :   item.Name  = this.filter('translate')('ACTINGDIRECTOR');                     break;
                    case "ВО ГЕНЕРАЛЬНОГО ДИРЕКТОРА"            :   item.Name  = this.filter('translate')('actingCeo');                          break;
                    case "ТВО ДИРЕКТОРА"                        :   item.Name  = this.filter('translate')('TEMPORARILYACTINGDIRECTOR');          break;
                    case "ТВО ГЕНЕРАЛЬНОГО ДИРЕКТОРА"           :   item.Name  = this.filter('translate')('TEMPORARILYactingCeo');               break;
                    case "ГОЛОВІ"                               :   item.Name  = this.filter('translate')('CHAPTER');                            break;
                    case "ГОЛОВІ ПРАВЛІННЯ"                     :   item.Name  = this.filter('translate')('CHIEFMANAGEMENTBOARD');               break;
                    case "ВО ГОЛОВИ ПРАВЛІННЯ"                  :   item.Name  = this.filter('translate')('ACTINGCHAIRMAN');                     break;
                    case "ТВО ГОЛОВИ ПРАВЛІННЯ"                 :   item.Name  = this.filter('translate')('TEMPORARILYACTINGCHAIRMAN');          break;
                    case "ЗАСНОВНИКУ"                           :   item.Name  = this.filter('translate')('FOUNDER');                            break;
                    case "ЗАВІДУЮЧОМУ"                          :   item.Name  = this.filter('translate')('head');                               break;
                    case "КЕРІВНИКУ"                            :   item.Name  = this.filter('translate')('toHead');                             break;
                    case "НАЧАЛЬНИКУ"                           :   item.Name  = this.filter('translate')('toChief');                            break;
                    case "ГОЛОВНОМУ ЛІКАРЮ"                     :   item.Name  = this.filter('translate')('MAINDOCTOR');                         break;
                    case "КЕРУЮЧОМУ"                            :   item.Name  = this.filter('translate')('MANAGER');                            break;
                    case "ДОЗВОН"                               :   item.Name  = this.filter('translate')('dialer');                             break;
                    case "НЕДОЗВОН"                             :   item.Name  = this.filter('translate')('notDialer');                          break;
                    case "ЗВОНИЛ"                               :   item.Name  = this.filter('translate')('called');                             break;
                    case "ИСКАЛ"                                :   item.Name  = this.filter('translate')('searched');                           break;
                    case "БЕЗ АДРЕСА"                           :   item.Name  = this.filter('translate')('nonAddress');                         break;
                    case "БАЗА"                                 :   item.Name  = this.filter('translate')('baza');                               break;
                    case "Директор"                             :   item.Name  = this.filter('translate')('Director');                           break;
                    case "Ген. Директор"                        :   item.Name  = this.filter('translate')('сeo');                                break;
                    case "Руководитель отдела продаж"           :   item.Name  = this.filter('translate')('рeadSalesDepartment');                break;
                    case "Бухгалтер"                            :   item.Name  = this.filter('translate')('accountant');                         break;
                    case "Менеджер"                             :   item.Name  = this.filter('translate')('manadzer');                           break;
                    case "Инженер"                              :   item.Name  = this.filter('translate')('engineer');                           break;
                    case "Тех. специалист"                      :   item.Name  = this.filter('translate')('techSpecialist');                     break;
                    case "IТ Директор"                          :   item.Name  = this.filter('translate')('itDirector');                         break;
                    case "Руководитель проекта"                 :   item.Name  = this.filter('translate')('projectManager');                     break;
                    case "Маркетолог"                           :   item.Name  = this.filter('translate')('marketer');                           break;
                    case "Отдел HR"                             :   item.Name  = this.filter('translate')('departmentHR');                       break;
                    case "ANSWERED"                             :   item.Name  = this.filter('translate')('answered');                           break;
                    case "NO ANSWER"                            :   item.Name  = this.filter('translate')('didNotAnswer');                       break;
                    case "BUSY"                                 :   item.Name  = this.filter('translate')('busy');                               break;
                    case "FAILED"                               :   item.Name  = this.filter('translate')('fail');                               break;
                    case "CONGESTION"                           :   item.Name  = this.filter('translate')('congestion');                         break;
                }
            });
        }
    });

    $scope.trans();

    //Define browser land
    var a = 'en';
    var lang = window.navigator.language || navigator.userLanguage;
    if(lang.indexOf('ru') !== -1) a = `ru`;
    if(lang.indexOf('en') !== -1) a = `en`;
    if(lang.indexOf('uk') !== -1) a = `ua`;

    if (localStorage.getItem("Language") !== null) {
        $scope.lang = localStorage.getItem("Language");
    } else {
        $scope.lang = a;
        localStorage.setItem("Language", a);
    }

    //Save state Language from lacal storage
    // $scope.lang = localStorage.getItem("Language");
    $translatePartialLoader.addPart(`General`);//.addPart(`${Gulp}Menu/Translate`);
    $scope.manyAction.changeLanguage($scope.lang);
    $translate.refresh();



//data":{"route":"/api/ast/autodial/process","data":[{"$Aid":3}]}}
    // $scope.ESource = {
    //     C : {
    //         cc          : 0,
    //         //client      : Math.floor(Math.random() * 100),
    //         process     : 0,
    //         scenario    : 0,
    //     },
    //     U : {
    //         cc          : 0,
    //         //client      : Math.floor(Math.random() * 100),
    //         process     : 0,
    //         scenario    : 0,
    //     },
    //     All: 0,
    //     countSee: 0
    // };
    // function All(){
    //     $scope.ESource.All = 0;
    //     angular.forEach($scope.ESource,todo => {
    //         angular.forEach(todo,(todo2,key2) => {
    //             $scope.ESource.All =  $scope.ESource.All + todo[key2];
    //         });
    //     });
    // }
    // All();

    // function Count(type,data){
    //     function Plus(){
    //         $scope.ESource.countSee++;
    //     }
    //     arr = data.data.route.split('/');
    //     if( arr.indexOf("contacts") >= 0 )  { if(type == 'create')$scope.ESource.C.cc++;
    //                                           if(type == 'update')$scope.ESource.U.cc++; Plus(); }
    //     if( arr.indexOf("process") >= 0 )   { if(type == 'create')$scope.ESource.C.process++;
    //                                           if(type == 'update')$scope.ESource.U.process++;Plus(); }
    //     if( arr.indexOf("scenario") >= 0 )  { if(type == 'create')$scope.ESource.C.scenario++;
    //                                           if(type == 'update')$scope.ESource.U.scenario++;Plus(); }
    //     All();
    //     $scope.$apply();
    // }


    // $scope.reNull = a => {
    //     switch(a){
    //         case "C.cc"         : { $scope.ESource.C.cc         = 0; break;}
    //         case "U.cc"         : { $scope.ESource.U.cc         = 0; break;}
    //         case "C.process"    : { $scope.ESource.C.process    = 0; break;}
    //         case "U.process"    : { $scope.ESource.U.process    = 0; break;}
    //         case "C.scenario"   : { $scope.ESource.C.scenario   = 0; break;}
    //         case "U.scenario"   : { $scope.ESource.U.scenario   = 0; break;}

    //         default             : { $scope.ESource.countSee     = 0; break;}
    //     }
    //     All();
    //  };
}

crmUA.component('navbarCtrl', {
  bindings: {value: '='},
  controller: NavBarCtrl,
  scope: {}
});
crmUA.controller('NavBarCtrl', NavBarCtrl);

 //"event":"create","data":{"route":"/api/cc/contacts/create","data":{"fieldCount":0,"affectedRows":0,"insertId":0,"serverStatus":34,"warningCount":0,"message":"","protocol41":true,"changedRows":0}}}