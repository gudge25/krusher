crmUA.component('fsnewctrl', {
  bindings: {value: '<'},
  controller: fsNewCtrl,
  templateUrl: `${Gulp}Fs/Priority/Views/New.html`,
});
function fsNewCtrl($scope, $filter) {
    $scope.manyAction =  new fsViewModel($scope, $filter);
	$scope.new 	= new fsFileModel('').put();
}