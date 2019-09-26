const employee = {
    data: { Name: `user`, Small: ``} ,
    url: "/employee",
    views: {
        "viewA": {
            templateUrl: Gulp + 'Employee/Employee/Views/All.html',
            controller: 'emEmployeeCtrlAll'
        }
    }
};
const emEmployeeNew = {
    data: { Name: `Создание пользователя`, Small: ``} ,
    url: "/employeetNew",
    views: {
        "viewA": {
            templateUrl: Gulp + 'Employee/Employee/Views/New.html',
            controller: 'emEmployeeCtrlNew'
        }
    }
};
const emEmployeeEdit =  {
    data: { Name: `editUser`, Small: ``} ,
    url: "/edit/employee/{emID:[0-9]{1,10}}",
    views: {
        "viewA": {
            templateUrl: Gulp + 'Employee/Employee/Views/Edit.html',
            controller: 'emEmployeeCtrlEdit'
        }
    }
};