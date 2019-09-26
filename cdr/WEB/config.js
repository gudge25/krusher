
app.config(function($datepickerProvider) {
    angular.extend($datepickerProvider.defaults, {
        dateFormat: 'dd/MM/yyyy',
        weekStart: 1,
        dateType: 'iso'
    });
})

app.config(function($modalProvider) {
    angular.extend($modalProvider.defaults, {
        html: true
    });
})

    .config(function($alertProvider) {
        angular.extend($alertProvider.defaults, {
            animation: 'am-fade-and-slide-top',
            placement: 'top',
            type: 'info', show: true
        });
    })


    .config(function($popoverProvider) {
        angular.extend($popoverProvider.defaults, {
            html: true
        });
    })

    .config(function($sceProvider) {
        // Completely disable SCE.  For demonstration purposes only!
        // Do not use in new projects.
        $sceProvider.enabled(false);
    });
