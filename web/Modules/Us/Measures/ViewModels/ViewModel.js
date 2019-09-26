class usMeasuresViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new usMeasuresSrv());
        this.Find();
    }
}