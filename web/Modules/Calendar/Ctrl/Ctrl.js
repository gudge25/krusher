crmUA.controller('CalendarCtrl', function($scope, $filter) {
    $scope.manyAction =  new CalendarViewModel($scope, $filter);
});