crmUA.controller('QuestionCtrl', function($scope, $filter, Auth) {
    $scope.auth = Auth;
    $scope.new = { Comment : null };
    $scope.manyAction = new QuestionsViewModel($scope, $filter);

    $scope.Save = () => {
            var model = {
                "icon_emoji":":rotating_light:",
                "text": `Новый вопрос\n Пользователь: @sales\n Контакт: ${$scope.new.name} \n Телефон: ${$scope.new.Phone}`,
                "attachments":[{
                        "title":` Контрагент: ${$scope.auth.FFF.client_name}`,
                        "title_link":`http://crm.asterisk.biz.ua/index.php?module=Accounts&view=Detail&record=${$scope.auth.FFF.vTigerID}`,
                        "text":`Описание: ${$scope.new.Comment}`,
                        "color":"#764FA5"}]
            };
            $scope.manyAction.Support(model);
            alert( $filter('translate')('thankforquestion') );
    };
});