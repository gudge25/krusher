crmUA.component('autoprocesseditctrl', {
  bindings: {value: '<'},
  controller: AutoProcessEditCtrl,
  templateUrl: `${Gulp}Asterisk/AutoProcess/Views/Edit.html`,
});
function AutoProcessEditCtrl($scope, $filter, $stateParams, $translate, $translatePartialLoader) {
    $scope.manyAction =  new astAutoProcessViewModel($scope, $filter);
    var id = $stateParams.id_autodial;
    new astAutoProcessSrv().getFind({  id_autodial: id },cb => { if(cb.length > 0){ $scope.upd = cb[0]; $scope.upd_old = angular.copy(cb[0]); $scope.$apply(); } else  window.location = "#!/page404"; });
}