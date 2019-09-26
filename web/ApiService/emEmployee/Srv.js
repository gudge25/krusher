class emEmployeeSrv extends BaseSrv {
    constructor(options)
    {
        super(API.em.Employee.All, emEmployeeModel, 'emID', options);
    }
}