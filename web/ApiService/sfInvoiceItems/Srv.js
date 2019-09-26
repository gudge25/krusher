class sfInvoiceItemsSrv extends BaseSrv {
    constructor()
    {
        super(API.sf.InvoiceItems, sfInvoiceItemsModel, 'iiID');
    }
}