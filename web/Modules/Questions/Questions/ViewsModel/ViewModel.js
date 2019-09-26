class fmQuestionsViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new fmQuestionSrv());
        this.Find();
        $scope.new = new fmQuestionsModel('').post();

        $scope.dele = (a, qID) => {
            swal({
                title: 'Удаления!',
                text: "Вы уверены, что хотите удалить ети вопросы?",
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Да, удалить',
                cancelButtonText: 'Отмена'
            }).then( () => {
                angular.forEach(a, (todo,key) => {
                    if(todo.isChecked){
                        new fmQuestionSrv().del(todo.qID, cb1 => {
                            new fmQuestionSrv().getFind({ qID }, cb => {
                                $scope.questions = cb;
                                    $scope.$apply();
                                });
                        });
                    }
                });
            });
        };
    }
    edit(arr, tpID){
        if(arr, tpID) {
            var id;
            angular.forEach(arr, (todo) => {
                if(todo.isChecked){
                    if(id) {
                        id = todo.qID + '&' + id;
                    }else{
                        id = todo.qID;
                    }
                }
            });
            if(id){
                window.location = `/#!/questionsEdit/${tpID}/${id}`;
            }else{
                sweetAlert(
                    'Вы ничего не выбрали!',
                    '',
                    'error'
                );
            }
        }
    }
    new(tpID){
        window.location = `/#!/questionsEdit/${tpID}/0`;
    }
}