var Stream = {
    url   : "/Stream",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Stream/Views/All.html',
            controller: 'StreamCtrl'
        }
    },
    resolve : {
        trans: ($translate,$translatePartialLoader) => {$translatePartialLoader.addPart(`${Gulp}Stream/Translate`);$translate.refresh(); }
    }
};
var StreamDetail = {
    url   : "/StreamDetail/:emID",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Stream/Views/All.html',
            controller: 'StreamDetailCtrl'
        }
    },
    resolve : {
        trans: ($translate,$translatePartialLoader) => {$translatePartialLoader.addPart(`${Gulp}Stream/Translate`);$translate.refresh(); }
    }
};