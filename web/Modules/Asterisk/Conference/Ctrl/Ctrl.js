crmUA.controller('ConferenceCtrl', function($scope, $filter, $translate, $translatePartialLoader,$rootScope) {
    $scope.manyAction =  new astConferenceViewModel($scope,$filter,$translate,$rootScope);
    $scope.model = new astConferenceModel('').postFind();
    $scope.manyAction.Find();
});