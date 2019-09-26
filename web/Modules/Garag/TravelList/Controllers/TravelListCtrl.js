crmUA.controller('TravelListCtrl', function($scope, $filter ) {
    var v = {
        scope: $scope,
        filter: $filter
    };

    $scope.manyAction =  new gaTravelListViewModel(v);
});