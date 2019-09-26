const Role = {
    data: { Name: `roles`, Small: ``} ,
    url   : "/Role",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Employee/Role/Views/All.html',
            controller  : 'emEmployeeRoleAllCtrl'
        }
    }
};
const RoleNew = {
    data: { Name: `role`, Small: ``} ,
    url   : "/RoleNew",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Employee/Role/Views/New.html',
            controller  : 'emEmployeeRoleNewCtrl'
        }
    }
};
const RoleEdit = {
    data: { Name: `role`, Small: ``} ,
    url   : "/edit/RoleEdit/{roleID:[0-9]{1,10}}",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Employee/Role/Views/Edit.html',
            controller  : 'emEmployeeRoleEditCtrl'
        }
    }
};