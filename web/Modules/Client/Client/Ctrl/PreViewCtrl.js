crmUA.controller('crmClientCtrlPreView', function($scope,$filter, $timeout,$stateParams, $translate, $rootScope, i18nService, HotDial, $sce) {
    $scope.HotDial = HotDial;
    $scope.clID = $stateParams.clID;
    $scope.manyAction =  new crmClientPreViewModel($scope, $filter, $scope.clID, `PreView`, $translate, $rootScope);

    new crmTagListSrv().getFind({clID : $scope.clID },cb => { if( cb.length > 0)  $scope.TagList = cb;  $scope.TagList_old = angular.copy(cb); $scope.$apply();});


    if(window.location.hostname == '185.41.249.46' ) $scope.DZO = true;
    //contacts group
    new crmContactSrv().getFind({ clID : $scope.clID},cb =>   { $scope.contactsL    = _.groupBy(cb, 'ccType'); $scope.linkovka(); $scope.$apply(); });        //Сделки
    // docs deals
    new dcDocsClientSrv().getFind({ clID : $scope.clID},cb =>  { $scope.deals      =  _.groupBy(cb, 'dctID'); trans(); $scope.keysOfDeals = Object.keys($scope.deals); });                           //Сделки

    var trans = () => {
        $translate(['conversation', 'closedSuccessfully', 'conversReview', 'priceOffer', 'analysisSituation', 'searchMaker', 'offer', 'needsAnalysis', 'mark', 'closedUnsuccessfully',
         'completed', 'scheduled', 'canceled', 'overdue']).then(a => {
            for (let value in $scope.deals) {
                if (value !== "Контакт") {
                    $scope.deals[value].forEach(item => {
                        switch (item.dcStatusName){
                            case "Переговоры"                : item.dcStatus = $filter('translate')('conversation');         break;
                            case "Закрыта удачно"            : item.dcStatus = $filter('translate')('closedSuccessfully');   break;
                            case "Переговоры или отзыв"      : item.dcStatus = $filter('translate')('conversReview');        break;
                            case "Ценовое предложение"       : item.dcStatus = $filter('translate')('priceOffer');           break;
                            case "Анализ ситуации"           : item.dcStatus = $filter('translate')('analysisSituation');    break;
                            case "Поиск принимающих решение" : item.dcStatus = $filter('translate')('searchMaker');          break;
                            case "Предложение"               : item.dcStatus = $filter('translate')('offer');                break;
                            case "Нуждается в анализе"       : item.dcStatus = $filter('translate')('needsAnalysis');        break;
                            case "Оценка"                    : item.dcStatus = $filter('translate')('mark');                 break;
                            case "Закрыта неудачно"          : item.dcStatus = $filter('translate')('closedUnsuccessfully'); break;
                            case "Выполнен"                  : item.dcStatus = $filter('translate')('completed');            break;
                            case "Заплонирован"              : item.dcStatus = $filter('translate')('scheduled');            break;
                            case "Отменен"                   : item.dcStatus = $filter('translate')('canceled');             break;
                            case "Просрочен"                 : item.dcStatus = $filter('translate')('overdue');              break;
                        }
                    });
                }
            }
        });
    };
    $rootScope.$on('$translateChangeSuccess', () => {
        trans();
    });

    // var lang = $translate.use();
    i18nService.setCurrentLang('en');

    //Linkovka
    $scope.linkovka = () => {
        $scope.link  = [];
        angular.forEach($scope.contactsL, todo => {
            //check only phone & email
                angular.forEach(todo, todo3 => {
                    if (todo3.ccType ==36 ) //|| todo3.ccType == 37 //email
                    new crmClientSrv().get('find/' + todo3.ccName, cb => {
                        angular.forEach(cb, todo2 => {
                            if( $scope.clID != todo2.clID && !$scope.link.includes(todo2)) {
                                todo2.ccName = todo3.ccName;
                                $scope.link.push(todo2); $scope.$apply();
                            }
                        });
                    });
                });
        });
        $scope.$apply();
    };

    $scope.status = [
        {"ID" : "101", "Name" : "Прозвон"},
        {"ID" : "102", "Name" : "Номер на проверку"},
        {"ID" : "103", "Name" : "Хлам"}
    ];

    $scope.ClientDelete = a => {
        new crmClientSrv().del(a.clID,() => { window.location = '/#!/client';});
    };

    $scope.CheckPhone = a => {
        if(a.length > 3) {
            if (typeof debounce === 'object') {
                $timeout.cancel(debounce);
            }
            debounce = $timeout(() => {
                new regPhoneSrv().get(a, cb => {
                    $scope.phone = cb;
                    $scope.$apply();
                });
            }, 500, false);
        }
        else  { $timeout.cancel(debounce); delete $scope.phone; $scope.$apply();}
    };

    $scope.htmlPopover = a => {
        var [ContactStatus,Comment] = ["",""];
        if(a.ContactStatus) ContactStatus = `<span ng-if="a.ContactStatus"> <b>${$filter('translate')('status')}</b> : ${$filter('translate')(  $filter('enums')(a.ContactStatus)  )} </span> <br/>`;
        if(a.Comment) Comment = `<span ng-if="a.Comment"> <b>${$filter('translate')('note')}</b> : ${a.Comment}</span>`;
        return $sce.trustAsHtml(`${ContactStatus} ${Comment}`);
    };

    $scope.htmlPopover2 = a => {
        var [scenario,process] = ["",""];
        if(a.id_scenario) scenario = `<span ng-if="a.ContactStatus"> <b>${$filter('translate')('scenario')}</b> : ${ a.id_scenario } </span> <br/>`;
        if(a.id_autodial) process = `<span ng-if="a.Comment"> <b>${$filter('translate')('process')}</b> : ${a.id_autodial}</span>`;
        return $sce.trustAsHtml(`${scenario} ${process}`);
    };

    $scope.htmlPopover3 = a => {
        var [talkTime,duration,expectation,serviceLevel] = ["","","",""];
        if(a.billsec)       talkTime = `<span ng-if="a.billsec">            <b>${$filter('translate')('talkTime')}</b> :    <span class="float-right"> ${ a.billsec }</span> </span> <br/>`;
        if(a.duration)      duration = `<span ng-if="a.duration">           <b>${$filter('translate')('duration')}</b> :    <span class="float-right"> ${a.duration}</span> </span> <br/>`;
        if(a.serviceLevel)  expectation = `<span ng-if="a.serviceLevel">    <b>${$filter('translate')('expectation')}</b> : <span class="float-right"> ${a.serviceLevel}</span> </span> <br/>`;
        if(a.holdtime)      serviceLevel = `<span ng-if="a.holdtime">       <b>${$filter('translate')('Hold')}</b> :        <span class="float-right">${a.holdtime}</span></span>`;
        return $sce.trustAsHtml(`${talkTime} ${duration} ${expectation} ${serviceLevel}`);
    };


});