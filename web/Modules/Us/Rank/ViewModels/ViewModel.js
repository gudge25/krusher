class usRankViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new usRankSrv);
        this.scope = $scope;
    }

    Save(data) { return this.scope.manyActionComments.service.ins(data, alert(`Ваш комментарий добавлен`,`Уведомление!`));}
}