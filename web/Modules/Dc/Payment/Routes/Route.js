const Payment = {
    url   : "/Payment",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Dc/Payment/Views/PaymentView.html',
            controller  : 'PaymentCtrl'
        }
    }
};
const PaymentCreate = {
    url   : "/PaymentCreate/{dcID:[0-9]{1,10}}",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Dc/Payment/Views/PaymentView.html',
            controller  : 'PaymentCtrl'
        }
    }
};
const PaymentEdit = {
    url   : "/Payment/:payID",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Dc/Payment/Views/PaymentEditView.html',
            controller  : 'PaymentEditCtrl'
        }
    }
};