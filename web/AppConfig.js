crmUA.config( ($sceProvider,msdElasticConfig,$translateProvider,uiSelectConfig,momentPickerProvider,$uibTooltipProvider) => {
    $sceProvider.enabled(false);
    //ДЛЯ техтарее
    // msdElasticConfig.append = '\n';
    $translateProvider.useSanitizeValueStrategy('escapeParameters');
    $translateProvider.useLoader('$translatePartialLoader', {
      urlTemplate: '{part}/{lang}.json'
    });

    //delete 20.05.2019 uibDatepickerPopupConfig,uibDatepickerConfig,$modalProvider
    //for DatePicker options
    //uibDatepickerConfig.showWeeks = true;
    //for DatePickerPopup options
    // uibDatepickerPopupConfig.closeText= 'Close222';
    // uibDatepickerPopupConfig.placement = 'auto bottom';
    
    //// $modalProvider.options.backdrop  = 'static';
    // $modalProvider.options.keyboard  = true;
    // $modalProvider.options.animation = false;
    // $modalProvider.options.size      = 'lg';

    uiSelectConfig.theme            = 'bootstrap';
    uiSelectConfig.resetSearchInput = true;
    uiSelectConfig.appendToBody     = false;

    //Moment default config
    momentPickerProvider.options({
            format:"YYYY-MM-DD HH:mm:ss",
            today:true,
            locale:"ru",
            startView:"month"
    });

    angular.lowercase = angular.$$lowercase;
    
    
    $uibTooltipProvider.options({ appendToBody: true, popupDelay: 1000,animation : true }); 


    //$qProvider.errorOnUnhandledRejections(false);
});
crmUA.config(['$qProvider', function ($qProvider) {
    $qProvider.errorOnUnhandledRejections(false);
}]);
 
// Пригодится при отладке
// crmUA.run( $rootScope => {
//     //'$stateChangeStart' '$stateChangeSuccess' '$stateChangeError'
//     $rootScope.$on('$stateChangeStart',(event, toState, toParams, fromState, fromParams, options) => {
//         //console.log(event, toState, toParams, fromState, fromParams, options);
//     });
// });

// crmUA.config( $qProvider => {
//     $qProvider.errorOnUnhandledRejections(false);
// });