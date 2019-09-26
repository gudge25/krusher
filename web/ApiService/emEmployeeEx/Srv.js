class emEmployeeExSrv extends BaseSrv {
    constructor()
    {
        super(API.em.Employee.Ex, emEmployeeCallsModel, 'emID');
    }
}