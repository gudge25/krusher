var TapeViewRoute = {
    url   : "/stream",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Tape/Views/TapeView.html',
            controller: 'TapeCtrl',
            resolve     : {
                            trans: ($translate,$translatePartialLoader) => { $translatePartialLoader.addPart(`${Gulp}Stream/Translate`); $translate.refresh(); }
            }
        }
    }
};
 
