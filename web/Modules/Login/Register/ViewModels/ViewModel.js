class RegisterViewModel extends BaseViewModel {
    constructor($scope,$timeout,$stateParams,$filter,$translate)
    {
        super($scope,$filter,new emEmployeeClientsSrv(), $translate);

        $scope.enums = [
            {tvID: 101701, tyID: 1017, Name: "Telefony"},
            {tvID: 101702, tyID: 1017, Name: "Telefony+Stat"},
            {tvID: 101703, tyID: 1017, Name: "CRM"},
            {tvID: 101704, tyID: 1017, Name: "Krusher5"},
            {tvID: 101705, tyID: 1017, Name: "Krusher10"},
            {tvID: 101706, tyID: 1017, Name: "Krusher20"},
            {tvID: 101707, tyID: 1017, Name: "Krusher50"},
            {tvID: 101708, tyID: 1017, Name: "Krusher100"},
            {tvID: 101709, tyID: 1017, Name: "Krusher+"}
        ];

        $scope.cur   =[
            {tvID: 101801, tyID: 1018, Name: "USD"},
            {tvID: 101802, tyID: 1018, Name: "EUR"},
            {tvID: 101803, tyID: 1018, Name: "UAH"},
            {tvID: 101804, tyID: 1018, Name: "RUB"}
        ];

        // angular.forEach(Enums, value => {
        //     if(value.tyID == 1017) $scope.enums.push(value);
        //     if(value.tyID == 1018) $scope.cur.push(value);
        // });
    }
}