const Actualization = {
    url: "/Actualization",
    views: {
        "viewA": {
            templateUrl: Gulp + 'Client/Actualization/Views/All.html',
                controller: 'ActualizationCtrlGetAll'
        },
        'viewB@Actualization':{
            templateUrl: Gulp + 'Client/Actualization/Views/Nbr/ModalForm.html',
            controller: 'ActualizationNbrCtrl',
            resolve : {
                ModalItems:  $stateParams => {
                    return { ccName : 7596 };
                }
            }
        }
    }
};