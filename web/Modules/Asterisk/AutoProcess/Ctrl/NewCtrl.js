crmUA.component('autoprocessnewctrl', {
  bindings: {value: '<'},
  controller: AutoProcessNewCtrl,
  templateUrl: `${Gulp}Asterisk/AutoProcess/Views/New.html`,
});
function AutoProcessNewCtrl($scope,$filter, $translate, $translatePartialLoader, Auth) {
    $scope.manyAction =  new astAutoProcessViewModel($scope, $filter);
    $scope.new = new astAutoProcessModel('').put();
    $scope.auth = Auth;
}