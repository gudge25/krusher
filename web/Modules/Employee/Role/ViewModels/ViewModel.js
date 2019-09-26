class emEmployeeRoleViewModel extends BaseViewModel {
    constructor($scope,$filter,$translate)
    {
        super($scope,$filter,new emEmployeeRoleSrv(),$translate);
        this.Find();
    }
}