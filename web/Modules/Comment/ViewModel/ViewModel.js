class ccCommentViewModel extends BaseViewModel {
    constructor($scope, $filter) {
        super($scope, $filter, new ccCommentListSrv());

        $scope.new = new ccCommentModel('').post();
    }
}