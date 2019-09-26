class sfInvoiceSrv extends BaseSrv {
    constructor()
    {
        super(API.sf.Invoice, sfInvoiceModel,'dcID');
    }
}