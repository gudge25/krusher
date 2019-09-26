const InvoiceAdd = {
    url   : "/Invoice",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Dc/Invoice/Views/New.html',
            controller  : 'InvoiceAddCtrl'
        }
    }
};

const InvoiceEdit = {
    url   : "/Invoice/{invID:[0-9]{1,10}}",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Dc/Invoice/Views/InvoiceEditView.html',
            controller  : 'InvoiceEditCtrl'
        }
    }
};