crmUA.controller('emEmployeeStatCtrl', function($scope, $filter, Auth, $translate, $rootScope, $timeout, AclService) {

    $scope.manyAction =  new StatsViewMode($scope, $timeout, $filter, $rootScope,AclService,$translate);

	$scope.Auth = Auth.FFF;
    $scope.employees.data.shift(0);
    $scope.em = $scope.employees.data;
 
    //$scope.Xlabel = Xlabel;
    var [Xlabel,limitPoint,limitQty,blockedPoint,blockedQty,cancelPoint,cancelQty,ringingPoint,ringingQty,answeredPoint,answeredQty,failedPoint,failedQty,noAnswerPoint,noAnswerQty,busyPoint,busyQty,congestionPoint, congestionQty,formPoint,formQty,contactPoint,contactQty,paymentPoint,paymentQty,invoicePoint,invoiceQty, dealPoint, dealQty] = [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]];
    Defautl = () => {
        Xlabel = [];
        //LIMIT
        [ limitPoint, limitQty]       = [[],[]];
        //BLOCKED
         [blockedPoint, blockedQty]   = [[],[]];
        //CANCEL
        [ cancelPoint, cancelQty]     = [[],[]];
        //ringing
        [ ringingPoint, ringingQty]       = [[],[]];
        //answer
        [ answeredPoint, answeredQty]   = [[],[]];
        //failed
        [ failedPoint, failedQty]     = [[],[]];
        //no asnwer
        [ noAnswerPoint, noAnswerQty]       = [[],[]];
        //busy
        [ busyPoint, busyQty]   = [[],[]];
        //congestion
        [ congestionPoint, congestionQty]     = [[],[]];
        //form
        [ formPoint, formQty]       = [[],[]];
        //contact
        [ contactPoint, contactQty]   = [[],[]];
        //payment
        [ paymentPoint, paymentQty]     = [[],[]];
        //invoice
        [ invoicePoint, invoiceQty]     = [[],[]];
        //deal
        [ dealPoint, dealQty]     = [[],[]];
     };
    Defautl();


    var trsnsMonthNumber = [];
    $scope.shag = [{ "ID" : 1, "Name": 'byhour' }, { "ID" : 2, "Name": 'byday'}, { "ID" : 3, "Name": 'byweek'}, { "ID" : 4, "Name": 'bymonth'},{ "ID" : 5, "Name": 'byyear'} ];

    var date = new Date();

    $scope.ClearFilter = () => {
        //Default shag
        $scope.model = new emEmployeeStatModel({
                    "Step"      : 2,
                    "DateFrom"  : $filter('date')(new Date(date.getFullYear(), date.getMonth(), 1),'yyyy-MM-dd'), 
                    "DateTo"    : $filter('date')(new Date(),'yyyy-MM-dd'),
                    "dctID"     : 1
        }).postFind();
        $scope.model.emIDs =  [ { emID : Auth.FFF.emID } ];
        $scope.Save($scope.model);
    };
 
    $scope.trans = () => {
        $translate(['certificateOfComplletion',  'agreement', 'callStat', 'numberCalls', 'answered', 'busy', 'didNotAnswer', 'error',
         'congestion', 'Ringing', 'deal', 'form', 'appeal', 'payment', 'account', 
         'week','event']).then(a => {
            //shag is month
            if($scope.model.Step === 4 && $scope.chartConfig) {
                trsnsMonthNumber.forEach ((item,index) => {
                    let getMonOb = $scope.monList.filter( x => x.ID == item);
                    Xlabel[index] =  $filter('translate')(getMonOb[0].Name);
                });
                $scope.Xlabel = Xlabel;
            } else if ($scope.chartConfig === undefined) $scope.Xlabel = Xlabel;
   

            //shag is week
            if($scope.model.Step === 3 && $scope.chartConfig) {
                trsnsMonthNumber.forEach ((item,index) => {
                    Xlabel[index] = a.week + ' ' + item;
                });
            }

            //day format
            if($scope.model.Step === 2 && $scope.chartConfig) {
                Xlabel.forEach ( (item,key) => {
                    Xlabel[key] = $filter('date')(item,'yyyy-MM-dd');
                });
            }

            //hour format
            if($scope.model.Step === 1 && $scope.chartConfig) {
                Xlabel.forEach ( (item,key) => {
                    Xlabel[key] = $filter('date')(item,'HH:mm');
                });
            }

            if ($scope.chartConfig){
                //trans graph labels (X,Y)
                [$scope.chartConfig.title.text, $scope.chartConfig.yAxis.title.text] = [a.callStat, a.numberCalls];
                //trans graphs names
                [$scope.chartConfig.series[0].name, $scope.chartConfig.series[1].name, $scope.chartConfig.series[2].name, $scope.chartConfig.series[3].name, $scope.chartConfig.series[4].name,
                $scope.chartConfig.series[5].name, $scope.chartConfig.series[6].name, $scope.chartConfig.series[7].name, $scope.chartConfig.series[8].name, $scope.chartConfig.series[9].name,  $scope.chartConfig.series[10].name]=[a.answered, a.busy, a.didNotAnswer,
                a.error, a.congestion, a.Ringing, a.deal, a.form, a.appeal, a.payment, a.account];
                $scope.chartConfig.series[11].name = $filter('translate')('LIMIT');
                $scope.chartConfig.series[12].name = $filter('translate')('BLOCKED');
                $scope.chartConfig.series[13].name = $filter('translate')('CANCEL');
            }
        });
    };

    $rootScope.$on('$translateChangeSuccess', () => {
        $scope.trans();
    });

    switchData = ( discriptionArr, item ) => {
        if ( (!$scope.model.emIDs.length || $scope.model.emIDs.length > 1) && discriptionArr.length > 0) {
            let index = null;
            discriptionArr.some( (value, number) => {
                if (value.Period === item.Period) index = number;
                return index;
            });
            if(index !== null) {
                //console.log(item.QtyCall);
                discriptionArr[index].QtyCall += item.QtyCall;

            } else {
                let point = {'Period' : item.Period, 'QtyCall' : item.QtyCall};
                //console.log(`point1`);
                //console.log(point);
                discriptionArr.push(point);
            }

        } else {
            //console.log(`point2`);
            let point = {'Period' : item.Period, 'QtyCall' : item.QtyCall};
            //console.log(point);
            discriptionArr.push(point);
        }
    };

    XlabelMagic = a => {
        Xlabel.forEach( (item,index) => {
                    if(a == `cat`) item  = $scope.monList[item-1].Name; //categories[item-1];
                    if(a == `week`) Xlabel[index]  = $filter('translate')('week') + item;
                    ringingQty[index]   =  ringingQty[index]    !== undefined ?  ringingQty[index]      : 0;
                    failedQty[index]    =  failedQty[index]     !== undefined ?  failedQty[index]       : 0;
                    answeredQty[index]  =  answeredQty[index]   !== undefined ?  answeredQty[index]     : 0;
                    noAnswerQty[index]  =  noAnswerQty[index]   !== undefined ?  noAnswerQty[index]     : 0;
                    busyQty[index]      =  busyQty[index]       !== undefined ?  busyQty[index]         : 0;
                    congestionQty[index]=  congestionQty[index] !== undefined ?  congestionQty[index]   : 0;
                    dealQty[index]      =  dealQty[index]       !== undefined ?  dealQty[index]         : 0;
                    formQty[index]      =  formQty[index]       !== undefined ?  formQty[index]         : 0;
                    contactQty[index]   =  contactQty[index]    !== undefined ?  contactQty[index]      : 0;
                    paymentQty[index]   =  paymentQty[index]    !== undefined ?  paymentQty[index]      : 0;
                    invoiceQty[index]   =  invoiceQty[index]    !== undefined ?  invoiceQty[index]      : 0;
                    limitQty[index]     =  limitQty[index]      !== undefined ?  limitQty[index]        : 0;
                    blockedQty[index]   =  blockedQty[index]    !== undefined ?  blockedQty[index]      : 0;
                    cancelQty[index]    =  cancelQty[index]     !== undefined ?  cancelQty[index]       : 0;
                });

    };

    addXlabelData = periodNumber => {
        //console.log(periodNumber);
        if (periodNumber === 4 || periodNumber === 3) {
            //проверяем есть ли номер периода в оси названия периодов
            $scope.data.forEach(item => { if (Xlabel.indexOf(+item.Period) ==-1) Xlabel.push(+item.Period); });

            //console.log(Xlabel);
            Xlabel.sort( (a,b) => b - a );
            trsnsMonthNumber = Xlabel.reverse();

            Xlabel.forEach((item,index) => {
                if ((Xlabel[index + 1] - item) !== 1 && Xlabel[index + 1]  !== undefined) Xlabel.splice(index+1, 0, item + 1);
            });
            trsnsMonthNumber = Xlabel.slice();
 
            ringingPoint.forEach( item     => {let index = Xlabel.indexOf(+item.Period); ringingQty[index]      = item.QtyCall; });
            failedPoint.forEach( item      => {let index = Xlabel.indexOf(+item.Period); failedQty[index]       = item.QtyCall; });
            answeredPoint.forEach( item    => {let index = Xlabel.indexOf(+item.Period); answeredQty[index]     = item.QtyCall; });
            noAnswerPoint.forEach( item    => {let index = Xlabel.indexOf(+item.Period); noAnswerQty[index]     = item.QtyCall; });
            busyPoint.forEach( item        => {let index = Xlabel.indexOf(+item.Period); busyQty[index]         = item.QtyCall; });
            congestionPoint.forEach( item  => {let index = Xlabel.indexOf(+item.Period); congestionQty[index]   = item.QtyCall; });
            dealPoint.forEach( item        => {let index = Xlabel.indexOf(+item.Period); dealQty[index]         = item.QtyCall; });
            formPoint.forEach( item        => {let index = Xlabel.indexOf(+item.Period); formQty[index]         = item.QtyCall; });
            contactPoint.forEach( item     => {let index = Xlabel.indexOf(+item.Period); contactQty[index]      = item.QtyCall; });
            paymentPoint.forEach( item     => {let index = Xlabel.indexOf(+item.Period); paymentQty[index]      = item.QtyCall; });
            invoicePoint.forEach( item     => {let index = Xlabel.indexOf(+item.Period); invoiceQty[index]      = item.QtyCall; });
            limitPoint.forEach( item       => {let index = Xlabel.indexOf(+item.Period); limitQty[index]        = item.QtyCall; });
            blockedPoint.forEach( item     => {let index = Xlabel.indexOf(+item.Period); blockedQty[index]      = item.QtyCall; });
            cancelPoint.forEach( item      => {let index = Xlabel.indexOf(+item.Period); cancelQty[index]       = item.QtyCall; });

            if (periodNumber === 4) {
                Xlabel.forEach((item,index) => {
                    if ((Xlabel[index + 1] - item) !== 1 && Xlabel[index + 1]  !== undefined) Xlabel.splice(index+1, 0, item + 1);
                });
                trsnsMonthNumber = Xlabel.slice();

                XlabelMagic(`cat`);

            //переименование Period :Number на месяц
                var keys = Object.keys($scope.group);
                for(var i = 0; i < keys.length; i++){
                    //$scope.group[categories[keys[i]-1]] = $scope.group[keys[i]];
                    $scope.group[ $scope.monList[keys[i]-1].Name] = $scope.group[keys[i]];
                    
                    delete $scope.group[keys[i]];
                }
            }
            if (periodNumber === 3) {
                Xlabel.forEach((item,index) => {
                    if ((Xlabel[index + 1] - item) !== 1 && Xlabel[index + 1]  !== undefined) Xlabel.splice(index+1, 0, item + 1);
                });
                trsnsMonthNumber = Xlabel.slice();
                XlabelMagic(`week`);
            }
        }

        if (periodNumber !== 4 && periodNumber !== 3) {
            $scope.data.forEach(item => { if (Xlabel.indexOf(item.Period) ==-1) Xlabel.push(item.Period); });

            Xlabel.sort();
            //Задаем количество для координат
            ringingPoint.forEach( item     => {let index = Xlabel.indexOf(item.Period); if(ringingQty[index] === undefined)ringingQty[index]=0;ringingQty[index]+=item.QtyCall; });
            failedPoint.forEach( item      => {let index = Xlabel.indexOf(item.Period); if(failedQty[index] === undefined)failedQty[index]=0;failedQty[index]+=item.QtyCall; });
            answeredPoint.forEach( item    => {let index = Xlabel.indexOf(item.Period); if(answeredQty[index] === undefined)answeredQty[index]=0;answeredQty[index]+=item.QtyCall; });
            noAnswerPoint.forEach( item    => {let index = Xlabel.indexOf(item.Period); if(noAnswerQty[index] === undefined)noAnswerQty[index]=0;noAnswerQty[index]+=item.QtyCall; });
            busyPoint.forEach( item        => {let index = Xlabel.indexOf(item.Period); if(busyQty[index] === undefined)busyQty[index]=0;busyQty[index]+=item.QtyCall; });
            congestionPoint.forEach( item  => {let index = Xlabel.indexOf(item.Period); if(congestionQty[index] === undefined)congestionQty[index]=0;congestionQty[index]+=item.QtyCall; });
            dealPoint.forEach( item        => {let index = Xlabel.indexOf(item.Period); if(dealQty[index] === undefined)dealQty[index]=0;dealQty[index]+=item.QtyCall; });
            formPoint.forEach( item        => {let index = Xlabel.indexOf(item.Period); if(formQty[index] === undefined)formQty[index]=0;formQty[index]+=item.QtyCall; });
            contactPoint.forEach( item     => {let index = Xlabel.indexOf(item.Period); if(contactQty[index] === undefined)contactQty[index]=0;contactQty[index]+=item.QtyCall; });
            paymentPoint.forEach( item     => {let index = Xlabel.indexOf(item.Period); if(paymentQty[index] === undefined)paymentQty[index]=0;paymentQty[index]+=item.QtyCall; });
            invoicePoint.forEach( item     => {let index = Xlabel.indexOf(item.Period); if(invoiceQty[index] === undefined)invoiceQty[index]=0;invoiceQty[index]+=item.QtyCall; });
            limitPoint.forEach( item       => {let index = Xlabel.indexOf(item.Period); if(limitQty[index] === undefined)limitQty[index]=0;limitQty[index]+=item.QtyCall; });
            blockedPoint.forEach( item     => {let index = Xlabel.indexOf(item.Period); if(blockedQty[index] === undefined)blockedQty[index]=0;blockedQty[index]+=item.QtyCall; });
            cancelPoint.forEach( item      => {let index = Xlabel.indexOf(item.Period); if(cancelQty[index] === undefined)cancelQty[index]=0;cancelQty[index]+=item.QtyCall; });
            XlabelMagic();
        }
    };


    $scope.SaveNew = a => {
        $scope.global.Loading=true;$scope.clear();

        if(a.dctID !== 1 && a.dctID) a.disposition = null;

        $scope.Step = a.Step;
        Defautl();
        $scope.$apply(); //redrow web chart
        new emEmployeeStatSrv().getFind(a,cb => {
            cb = _.sortBy( cb, 'QtyCall');
            cb = _.sortBy( cb, 'disposition');
            cb = _.sortBy( cb, 'Period');
            

            $scope.data = cb;
            $scope.group = _.groupBy(cb, 'Period');
            $scope.group2   = _.groupBy(cb, 'disposition');
  
            if(Array.isArray(cb) && cb.length > 0) {
                //console.log($scope.group2);
                        for(let key in $scope.group2){
                        //$scope.group2.forEach( (key,item) => {
                            //console.log(item);
                            //console.log($scope.group2.ANSWERED);
                            switch(key){
                                case `LIMIT`:       $scope.group2[key].forEach( item2 => { switchData(limitPoint, item2); });       break;
                                case `BLOCKED`:     $scope.group2[key].forEach( item2 => { switchData(blockedPoint, item2); });     break;
                                case `CANCEL`:      $scope.group2[key].forEach( item2 => { switchData(cancelPoint, item2); });      break;
                                case `RINGING`:     $scope.group2[key].forEach( item2 => { switchData(ringingPoint, item2); });     break;
                                case `ANSWERED`:    $scope.group2[key].forEach( item2 => { switchData(answeredPoint, item2); });    break;
                                case `FAILED`:      $scope.group2[key].forEach( item2 => { switchData(failedPoint, item2); });      break;
                                case `NO ANSWER`:   $scope.group2[key].forEach( item2 => { switchData(noAnswerPoint, item2); });    break;
                                case `BUSY`:        $scope.group2[key].forEach( item2 => { switchData(busyPoint, item2); });        break;
                                case `CONGESTION`:  $scope.group2[key].forEach( item2 => { switchData(congestionPoint, item2); });  break;
                                case `Сделка`:      $scope.group2[key].forEach( item2 => { switchData(dealPoint, item2); });        break;
                                case `Анкета`:      $scope.group2[key].forEach( item2 => { switchData(formPoint, item2); });        break;
                                case `Обращение`:   $scope.group2[key].forEach( item2 => { switchData(contactPoint, item2); });     break;
                                case `Платеж`:      $scope.group2[key].forEach( item2 => { switchData(paymentPoint, item2); });     break;
                                case `Счет`:        $scope.group2[key].forEach( item2 => { switchData(invoicePoint, item2); });     break;
                            }
                        //});
                        } 
            }
            //console.log(answeredPoint);
                    // cb.forEach( item => {
                    //      switch(item.disposition){
                    //         case `LIMIT`:       switchData(limitPoint, item);       break;
                    //         case `BLOCKED`:     switchData(blockedPoint, item);     break;
                    //         case `CANCEL`:      switchData(cancelPoint, item);      break;
                    //         case `RINGING`:     switchData(ringingPoint, item);     break;
                    //         case `ANSWERED`:    switchData(answeredPoint, item);    break;
                    //         case `FAILED`:      switchData(failedPoint, item);      break;
                    //         case `NO ANSWER`:   switchData(noAnswerPoint, item);    break;
                    //         case `BUSY`:        switchData(busyPoint, item);        break;
                    //         case `CONGESTION`:  switchData(congestionPoint, item);  break;
                    //         case `Сделка`:      switchData(dealPoint, item);        break;
                    //         case `Анкета`:      switchData(formPoint, item);        break;
                    //         case `Обращение`:   switchData(contactPoint, item);     break;
                    //         case `Платеж`:      switchData(paymentPoint, item);     break;
                    //         case `Счет`:        switchData(invoicePoint, item);     break;
                    //     }
                    // });
                    addXlabelData(a.Step);
                    drow();
                    $scope.trans();
                    $scope.global.Loading=false;
                    $scope.$apply();
                    console.log(`done`);
        });//.then(()=>{ console.log(`done2`); $scope.global.Loading=false; $scope.$apply();});
    };
    //DEBOUNCE
    $scope.Save = debounce($scope.SaveNew);
    
    drow = () => {
        $scope.chartConfig =  {
            options: {
                chart: {
                    // renderTo: 'chart',
                    type: 'spline',
                    //renderTo: 'spline',
                }
            },
            title: {
                text: $filter('translate')('callStat'),
                style: {
                        display: 'none'
                    }
            },
            xAxis: {
                categories: Xlabel
            },
            yAxis: {
                title: {
                    text: $filter('translate')('numberCalls')
                }
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle'
            },
            tooltip: {
                shared: true
            },
            plotOptions: {
                series: {
                    pointStart: 0,
                    shadow: false,
                    animation: false
                },
                    marker: {
                        enabled: true
                    }
            },
            series: [{
                name: $filter('translate')('answered'),
                data: answeredQty,
                color: "rgba(0,166,90,"+rgba+")",
                visible:  answeredPoint.length ? true : false, //если нет данных, то не показываем этот график
                marker: { enabled: true }
            },
            {   name: $filter('translate')('busy'),
                data: busyQty,
                color: "#f39c12", //"rgba(0,192,239,"+rgba+")",
                visible: busyPoint.length ? true : false,
                marker: { enabled: true }
            },
            {   name: $filter('translate')('didNotAnswer'),
                data: noAnswerQty,
                color: "#d2d6de", //"rgba(243,156,1,"+rgba+")",
                visible: noAnswerPoint.length ? true : false, //showNoAnswerQty,
                marker: { enabled: true }
            },
            {   name: $filter('translate')('error'),
                data: failedQty,
                color: "#dd4b39", //"rgba(255,0,0,"+rgba+")",
                visible: failedPoint.length ? true : false, //showFailedQty,
                marker: { enabled: true }
            },
            {   name: $filter('translate')('congestion'),
                data: congestionQty,
                //color: "palevioletred",
                color: "#00c0ef",
                visible: congestionPoint.length ? true : false, //showCongestionQty,
                marker: { enabled: true }
            },
            {   name: $filter('translate')('Ringing'),
                data: ringingQty,
                color: "#00c0ef",//"rgba(91, 192, 222,"+rgba+")",
                visible: ringingPoint.length ? true : false, //showRingingQty,
                marker: { enabled: true }
            },
            {   name: $filter('translate')('deal'),
                data: dealQty,
                color: "#3c8dbc",//"rgba(60,141,188,"+rgba+")",
                visible: dealPoint.length ? true : false,//showDealQty,
                marker: { enabled: true }
            },
            {   name: $filter('translate')('form'),
                data: formQty,
                color: "#3c8dbc",//"rgba(181,141,188,"+rgba+")",
                visible: formPoint.length ? true : false, //showFormQty,
                marker: { enabled: true }
            },
            {   name: $filter('translate')('appeal'),
                data: contactQty,
                color: "#3c8dbc",//"rgba(60,50,188,"+rgba+")",
                visible: contactPoint.length ? true : false, //showContactQty,
                marker: { enabled: true }
            },
            {   name: $filter('translate')('payment'),
                data: paymentQty,
                color: "#3c8dbc",//"rgba(60,100,188,"+rgba+")",
                visible: paymentPoint.length ? true : false, //showPaymentQty,
                marker: { enabled: true }
            },
            {   name: $filter('translate')('account'),
                data: invoiceQty,
                color: "#3c8dbc",//"rgba(60,170,188,"+rgba+")",
                visible: invoicePoint.length ? true : false, //showInvoiceQty,
                marker: { enabled: true }
            },
            {   name: $filter('translate')('LIMIT'),
                data: limitQty,
                color: "#dd4b39", //"rgba(255,0,0,"+rgba+")",
                visible: limitPoint.length ? true : false,
                marker: { enabled: true }
            },
            {   name: $filter('translate')('BLOCKED'),
                data: blockedQty,
                color: "#dd4b39", //"rgba(255,0,0,"+rgba+")",
                visible: blockedPoint.length ? true : false,
                marker: { enabled: true }
            },
            {   name: $filter('translate')('CANCEL'),
                data: cancelQty,
                color: "#d2d6de",//"label-default",
                visible: cancelPoint.length ? true : false,
                marker: { enabled: true }
            },

            ],
            responsive: {
                rules: [{
                    condition: {
                        maxWidth: 500
                    },
                    chartOptions: {
                        legend: {
                            layout: 'horizontal',
                            align: 'center',
                            verticalAlign: 'bottom'
                        }
                    }
                }]
            }

        };
    };

    $scope.ClearFilter();
    
});