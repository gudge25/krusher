crmUA.controller('ConferenceNewCtrl', function($scope, $filter, $translate, $translatePartialLoader,$rootScope) {
    $scope.manyAction =  new astConferenceViewModel($scope,$filter,$translate,$rootScope);
    $scope.new = new astConferenceModel('').put();
});