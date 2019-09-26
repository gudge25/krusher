class emStatusSrv extends BaseSrv {
    constructor(options)
    {
        super(API.em.Employee.Status, emStatusModel, 'emID', options);
    }
}