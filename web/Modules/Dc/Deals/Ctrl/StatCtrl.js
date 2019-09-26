crmUA.controller('DealStatCtrl', function($scope, $filter, $stateParams, $translate, $rootScope, serv) {

    let id;

    let data = serv.getData();

    if (data === null) $scope.fullWidth = true;

    $scope.dcTVID = {};

    $scope.docsStatus = [
    {Name: "Выбрать все", tvID: null },
    {Name: "Переговоры", tvID: 6001 },
    {Name: "Закрыта удачно", tvID: 6002},
    {Name: "Переговоры или отзыв", tvID: 6003},
    {Name: "Ценовое предложение", tvID: 6004},
    {Name: "Анализ ситуации", tvID: 6005},
    {Name: "Поиск принимающих решение", tvID: 6006},
    {Name: "Предложение", tvID: 6007, },
    {Name: "Нуждается в анализе", tvID: 6008,},
    {Name: "Оценка", tvID: 6009, tyID: 6},
    {Name: "Закрыта неудачно", tvID: 6010},
    ];

    $scope.dcTVID.tvID = $scope.docsStatus[0].tvID;

    $scope.getDealProd = () => {
        $scope.hideGraph = false;

        new slDealChartSrv().ins({ "clID": id,"dcStatus": $scope.dcTVID.tvID }, cb => {
            if ( cb.length === 0 ) {
                $scope.hideGraph = true;
                return;
            }
            if(cb){
                $scope.data = cb.map( item => [item.psName,item.qty,false]);
                $scope.data.sort( (a,b) => a[1]-b[1] );
                let lengh = $scope.data.length;
                $scope.data[lengh - 1].pop();
                $scope.data[lengh - 1].push(true, true);
                drow();
                trans();
            }
        });
    };

    if (data !== null) {
        new crmClientSrv().get('find/' + data.phone, cb => {
            if (cb.length === 0 ) {
                id = $stateParams.clID;
            } else id = cb[0].clID;
            $scope.getDealProd();
        });
    } else {
        if ($stateParams && $stateParams.clID) {
            id = $stateParams.clID;
            $scope.getDealProd();
        }
    }

    serv.setData(null);

    function drow () {
        $scope.chartConfig = {
            title: {
                text: null
            },
            series: [{
                type: 'pie',
                allowPointSelect: true,
                keys: ['name', 'y', 'selected', 'sliced'],
                data: $scope.data,
                showInLegend: true,
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                }
            }]
        };
    }

    var trans = () => {
        $translate(['conversation', 'closedSuccessfully', 'conversReview', 'priceOffer', 'analysisSituation', 'searchMaker', 'offer', 'needsAnalysis', 'mark',
            'closedUnsuccessfully', 'selectAll']).then(a => {
                $scope.docsStatus.forEach ( item => {
                    switch (item.Name){
                        case "Выбрать все"               : item.NameT = $filter('translate')('selectAll');            break;
                        case "Переговоры"                : item.NameT = $filter('translate')('conversation');         break;
                        case "Закрыта удачно"            : item.NameT = $filter('translate')('closedSuccessfully');   break;
                        case "Переговоры или отзыв"      : item.NameT = $filter('translate')('conversReview');        break;
                        case "Ценовое предложение"       : item.NameT = $filter('translate')('priceOffer');           break;
                        case "Анализ ситуации"           : item.NameT = $filter('translate')('analysisSituation');    break;
                        case "Поиск принимающих решение" : item.NameT = $filter('translate')('searchMaker');          break;
                        case "Предложение"               : item.NameT = $filter('translate')('offer');                break;
                        case "Нуждается в анализе"       : item.NameT = $filter('translate')('needsAnalysis');        break;
                        case "Оценка"                    : item.NameT = $filter('translate')('mark');                 break;
                        case "Закрыта неудачно"          : item.NameT = $filter('translate')('closedUnsuccessfully'); break;
                    }
                });
            });
        };
        $rootScope.$on('$translateChangeSuccess', () => {
            trans();
        });
    });