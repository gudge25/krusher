const AutoProcess = {
    data: { Name: `StartAutoProcess`, Small: ``} ,
    url   : "/AutoProcess",
    views : {
        "viewA": { //component: 'autoprocessctrl'
            controller: `AutoProcessCtrl`,
            templateUrl: `${Gulp}Asterisk/AutoProcess/Views/All.html`,
    }
    }
};
const AutoProcessNew = {
    data: { Name: `StartAutoProcess`, Small: ``} ,
    url   : "/AutoProcessNew",
    views : {
        "viewA": { component: 'autoprocessnewctrl' }
    }
};
const AutoProcessEdit = {
    data: { Name: `StartAutoProcess`, Small: ``} ,
    url   : "/AutoProcessEdit/{id_autodial:[0-9]{1,10}}",
    views : {
        "viewA": { component: 'autoprocesseditctrl' }
    }
};