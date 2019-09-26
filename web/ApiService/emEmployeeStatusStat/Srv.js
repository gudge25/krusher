class emEmployeeStatusStatSrv extends BaseSrv {
    constructor()
    {
        super(API.em.Employee.NewStatus, emEmployeeStatusStatModel, '');
    }
}