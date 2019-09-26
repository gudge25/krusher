const langclient = { trans: ($translate,$translatePartialLoader) => {
                    //$translatePartialLoader.addPart(`${Gulp}Client/Client/Translate`);
                    $translate.refresh(); } };

const client = {
    data: { Name: `clients`, Small: ``} ,
    url: "/client",
    views: {
        "viewA": {
            templateUrl: Gulp + 'Client/Client/Views/All.html',
                controller: 'crmClientCtrlGetAll'
        }
    },
    resolve : langclient
};
const preView = {
    data: { Name: `clientCard`, Small: ``} ,
    url: "/clientPreView/{clID:[0-9]{1,10}}",
    views: {
        "viewA": {
            templateUrl: Gulp + 'Client/Client/Views/PreView/PreView.html',
                controller: 'crmClientCtrlPreView'
        }
    },
    resolve : langclient
};
const clientEdit = {
    data: { Name: `ClientEditing`, Small: ``} ,
    url: "/clientEdit/{clID:[0-9]{1,10}}",
    views: {
        "viewA": {
            templateUrl: Gulp + 'Client/Client/Views/Edit/Edit.html',
                controller: 'crmClientEditCtrl'
        }
    },
    resolve : langclient
};