const callingcard = {
		data: { Name: `appeal`, Small: `callsSmsEmail`} ,
        url     : "/callingcard",
        views   : {
            "viewA": {
                component: 'callingcardCtrl'
            }
        },
        resolve : {
            trans: ($translate,$translatePartialLoader) => { $translatePartialLoader.addPart(`${Gulp}Callincard/Translate`); $translate.refresh(); }
        }
};

