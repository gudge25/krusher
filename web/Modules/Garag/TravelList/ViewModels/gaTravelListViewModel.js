class gaTravelListViewModel extends BaseViewModel {
    constructor(v)
    {
        super(v.scope,v.filter,new gaTravelistSrv);

        new gaTravelistSrv().getAll(cb =>   { v.scope.data      = cb; v.scope.$apply();});
        new gaCarSrv().getAll(cb =>         { v.scope.Car       = cb; v.scope.$apply();});
        new gaDriverSrv().getAll(cb =>      { v.scope.Driver    = cb; v.scope.$apply();});
        new stProductSrv().getAll(cb =>     { v.scope.Product   = cb; v.scope.$apply();});
        new emEmployeeSrv().getFind({},cb =>    { v.scope.employees = cb; v.scope.$apply();});
        new slDealSrv().getFind({},cb =>        { v.scope.Deals     = cb; v.scope.$apply();});
        new gaPointSrv().getAll(cb =>       { v.scope.Points    = cb; v.scope.$apply();});

        v.scope.new = new gaTravellistModel('').post();
    }
}