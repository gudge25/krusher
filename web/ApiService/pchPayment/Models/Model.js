class pchPaymentModel extends BaseModelDC {
    constructor(p) {
        p = p ? p : {};
        super(p);
        this.p = p;
        this.dcNo           = 'ПЛ-' + this.dcID;
        this.PayType        = p.PayType     ? p.PayType     : null ;
        this.PayMethod      = p.PayMethod   ? p.PayMethod   : null ;
    }
}