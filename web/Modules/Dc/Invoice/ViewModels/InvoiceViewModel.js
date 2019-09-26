class InvoiceViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new sfInvoiceSrv());
    }
}