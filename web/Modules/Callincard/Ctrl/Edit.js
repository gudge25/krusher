// crmUA.component('callingcardEditCtrl', {
//     bindings: {value: '<'},
//     controller: ccEditCtrl,
//     templateUrl: `${Gulp}Callincard/Views/Edit.html`,
//   });
 
crmUA.controller('ccEditCtrl', function($scope, $timeout,$stateParams, $filter, $translate, $rootScope, ModalItems, ngAudio, AclService) {
    $scope.manyAction =  new ccContactViewModel($scope, $timeout, $stateParams ,$filter, $translate, $rootScope, ngAudio, AclService);

    GetDcLink = dcID => {
        new ccContactSrv().getFind({ dcIDs : [{dcID:dcID}]}, (cb,status,request) => {
            $scope.data           = cb[0]; $scope.$apply();
        });
    };
    if(ModalItems){
         if(ModalItems.dcID) GetDcLink(ModalItems.dcID);
    }
});