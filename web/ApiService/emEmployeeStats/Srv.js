class emEmployeeStatSrv extends BaseSrv {
    constructor()
    {
        super(API.em.Employee.Stat, emEmployeeStatModel, 'emID');
    }
}