crmUA.directive('createQuestion', $uibModal => {
    return {
        link: (scope, element) => {
            element.on('click', () => {
                var uibModalInstance = $uibModal.open({
                    templateUrl : 'build/Support/Views/All.html',
                    controller  : 'QuestionCtrl',
                    keyboard    : false,
                    backdrop    : 'static',
                    animation   : false
                    //windowClass : `lg-dialog`
                });
            });
        },
        template: `<i class="fa fa-question nav-icon"></i> <p>{{"question" | translate}}</p>`,
    };
});

crmUA.directive('createClient', $uibModal => {
    return {
        link: (scope, element, attrs) => {
            element.on('click', () => {
                var uibModalInstance = $uibModal.open({
                    templateUrl : 'build/Client/Client/Views/NewModal.html',
                    controller  : 'crmClientCtrlNew',
                    size        : ``,
                    resolve     : {
                                    ModalItems: () => {
                                        return {"ccName" : attrs.data};
                                    }
                                  },
                    keyboard    : false,
                    backdrop    : 'static',
                    animation   : false
                });

                uibModalInstance.result.then( () => {
                            if(scope)if(scope.$parent) if(scope.$parent.GetClient)setTimeout( () => { scope.$parent.GetClient(); } , 1000);
                }, () => {
                            //Refresh status base
                            if(scope)if(scope.$parent)if(scope.$parent.$parent)if(scope.$parent.$parent.$parent)scope.$parent.$parent.$parent.GetStatus();
                });
            });
        },
        template: `<a href uib-tooltip="{{'addClient' | translate}}"><nobr><i class="fa fa-building"></i> {{"client" | translate}}</nobr></a>`,
    };
});

crmUA.directive('createPayment', $uibModal => {
    return {
        link: (scope, element) => {
            element.on('click', () => {
                var uibModalInstance = $uibModal.open({
                    templateUrl : 'build/Dc/Payment/Views/PaymentView.html',
                    controller  : 'PaymentCtrl',
                    keyboard    : false,
                    backdrop    : 'static',
                    animation   : false
                });
            });
        },
        template: `<span uib-tooltip="{{'createPayment' | translate}}" style="cursor:pointer;"><i class="fa fa-plus"></i> {{"payment" | translate}}</span>`,
    };
});

crmUA.directive('createInvoice', $uibModal => {
    return {
        link: (scope, element) => {
            element.on('click', () => {
                 var uibModalInstance = $uibModal.open({
                    templateUrl : 'build/Dc/Invoice/Views/New.html',
                    controller  : 'InvoiceAddCtrl',
                    keyboard    : false,
                    backdrop    : 'static',
                    animation   : false,
                    windowClass : 'xx-dialog',

                    //size        : `lg`,
                });
            });
        },
        template: `<a href uib-tooltip="{{'createAccount' | translate}}"><nobr><i class="fa fa-plus"></i> {{"account" | translate}}</nobr></a>`,

        // template: `<span uib-tooltip="{{'createAccount' | translate}}" style="cursor:pointer;"><i class="fa fa-plus"></i> {{"account" | translate}}</span>`,
    };

    // return {
    //     link: (scope, element) => {
    //         element.on('click', () => {
    //             var uibModalInstance = $uibModal.open({
    //                 templateUrl : 'build/Support/Views/All.html',
    //                 controller  : 'QuestionCtrl',
    //                 keyboard    : false,
    //                 backdrop    : 'static',
    //                 animation   : false
    //                 //windowClass : `lg-dialog`
    //             });
    //         });
    //     },
    //     template: `<i uib-tooltip="{{'createAccount' | translate}}" class="fa fa-plus nav-icon"></i> <p>{{"account" | translate}}</p>`,
    // };

});

crmUA.directive('createDeal', $uibModal => {
    return {
        link: (scope, element, attrs) => {
            element.on('click', () => {
                var uibModalInstance = $uibModal.open({
                    templateUrl: 'build/Dc/Deals/Views/DealNew.html',
                    controller: 'DealNewCtrl',
                    windowClass : 'xx-dialog',
                    resolve     : {
                                    ModalItems: () => {
                                        if(attrs.data) return JSON.parse(attrs.data);
                                    }
                                  },
                    keyboard    : false,
                    backdrop    : 'static',
                    animation   : false
                });
                uibModalInstance.result.then( () => {
                    //setTimeout( () => { console.log(scope); window.location = `/#!/DealEdit/${scope.new.id}`;   /*scope.F();*/ } , 1000);
                });
            });
        },
        template: `<a href uib-tooltip="{{'createDeal' | translate}}"><nobr><i class="fa fa-briefcase"></i> {{"deal" | translate}}</nobr></a>`,
     };
});

crmUA.directive('createForm', $uibModal => {
    return {
        link: (scope, element, attrs) => {
            element.on('click', () => {
                var uibModalInstance = $uibModal.open({
                    templateUrl: `${Gulp}Questions/Questions/Views/Questions.html`,
                    controller: 'fmQuestionsCtrl',
                    windowClass : 'xx-dialog',
                    resolve     : {
                                    ModalItems: () => {
                                        if(attrs.data) return JSON.parse(attrs.data);
                                    }
                                  },
                    keyboard    : false,
                    backdrop    : 'static',
                    animation   : false
                });
            });
        },
        template: `<a href uib-tooltip="{{'createForm' | translate}}"><nobr><i class="fa fa-check-square"></i> {{"form" | translate}}</nobr></a>`,
    };
});


crmUA.directive('createCompletion', $uibModal => {
    return {
        link: (scope, element) => {
            element.on('click', () => {
                var uibModalInstance = $uibModal.open({
                    templateUrl : 'build/Dc/Completion/Views/CompletionAddView.html',
                    controller  : 'CompletionAddCtrl',
                    keyboard    : false,
                    backdrop    : 'static',
                    animation   : false
                });
            });
        },
        template: `<span uib-tooltip="{{'createAct' | translate}}" style="cursor:pointer;"><i class="fa fa-plus"></i> {{"certificateOfComplletion" | translate}}</span>`,
    };
});

crmUA.directive('createContract', $uibModal => {
    return {
        link: (scope, element, attrs) => {
            element.on('click', () => {
                var uibModalInstance = $uibModal.open({
                    templateUrl : 'build/Dc/Contract/Views/ContractView.html',
                    controller  : 'ContractCtrl',
                    keyboard    : false,
                    backdrop    : 'static',
                    animation   : false
                });
            });
        },
        template: `<span uib-tooltip="{{'createAgreement' | translate}}" style="cursor:pointer;"><i class="fa fa-plus"></i> {{"agreement" | translate}}</span>`,
    };
});

crmUA.directive('createEmployee', $uibModal => {
    return {
        link: (scope, element) => {
            element.on('click', () => {
                var uibModalInstance = $uibModal.open({
                    templateUrl : 'build/Employee/Employee/Views/New.html',
                    controller  : 'emEmployeeCtrlNew',
                    size        : ``,
                    keyboard    : false,
                    backdrop    : 'static',
                    animation   : false
                    //windowClass : `lg-dialog`
                });
                uibModalInstance.result.then( () => {
                    const Ctrl = angular.element(document.getElementById('EMAll')).scope();
                    if(Ctrl) if(Ctrl.manyAction) Ctrl.manyAction.Find();
                });
            });
        },
        template: `<a href uib-tooltip="{{'createUser' | translate}}"><nobr><i class="fa fa-user"></i> {{"user" | translate}}</nobr></a>`,
    };
});

crmUA.directive('createProduct', $uibModal => {
    return {
        link: (scope, element, attrs) => {
            element.on('click', () => {
                var uibModalInstance = $uibModal.open({
                    templateUrl : `${Gulp}/Product/Product/Views/New.html`,
                    controller  : 'ProductNewCtrl',
                    size        : ``,
                    keyboard    : false,
                    backdrop    : 'static',
                    animation   : false
                });
                uibModalInstance.result.then( i => {
                    let s = scope.$parent.$parent;
                    if(s && i && attrs.data){
                        s.ProductNames.push(i.psName);
                        s[attrs.data][s[attrs.data].length -1].psName   = i.psName;
                        s[attrs.data][s[attrs.data].length -1].psID     = i.psID;
                    }
                });
            });
        },
        template: `<a href uib-tooltip="{{'createProduct' | translate}}"><nobr><i class="fa fa-shopping-cart"></i> {{"newProduct" | translate}}</nobr></a>`,
     };
});
//----------
crmUA.directive('openDocsLinkSearch', ($uibModal,$filter) => {
    return {
        link: (scope, element, a) => {
            element.on('click', () => {
                var uibModalInstance = $uibModal.open({
                    templateUrl: `${Gulp}Search/Views/searchDocumentsModalView.html`,
                    controller: 'SearchDocumentsCtrl',
                    keyboard    : false,
                    backdrop    : 'static',
                    animation   : false
                });
                uibModalInstance.result.then( i => {
                    let s = scope;
                    if(s && i && a.data){
                        function f(){
                             [s[a.data].dcTypeL, s[a.data].dcNoL, s[a.data].dcDateL, s[a.data].dcLink] = [i.dcType, i.dcNo, i.dcDate, s.dcID];
                                                s[a.data].dcDisplayLink = ( (s[a.data].dcTypeL ? s[a.data].dcTypeL+' ' : '') + (s[a.data].dcNoL ? ' №'+ s[a.data].dcNoL : '') + (s[a.data].dcDateL ? (' от '+ ($filter('date')(s[a.data].dcDateL,'dd.MM.yyyy HH:mm:ss'))) : ''));
                        }
                        switch(a.data){
                            case "invoice"      : { f(); break;}
                            case "Completion"   : { f(); break;}
                            case "payment"      : { s[a.data].dcLink = i.dcID; break;}
                         }

                    }
                });
            });
        },
        template: '<button class="form-control"><i class="fa fa-search" aria-hidden="true"></i></button>',
    };
});

crmUA.directive('openClientSearch', $uibModal => {
    return {
        link: (scope, element, attrs) => {
            element.on('click', () => {
                var uibModalInstance = $uibModal.open({
                    templateUrl : `${Gulp}Search/Views/searchClientsModalView.html`,
                    controller  : 'SearchClientsCtrl',
                    keyboard    : false,
                    backdrop    : 'static',
                    animation   : false
                });
                uibModalInstance.result.then( i => {
                    let s = scope;
                    if(s && i && attrs.data) [s[attrs.data].clID, s[attrs.data].clName] = [ i.clID, i.clName];
                });
            });
        },
        template: '<button class="form-control"><i class="fa fa-search" aria-hidden="true"></i></button> ',
    };
});

crmUA.directive('createTrunk', $uibModal => {
    return {
        link        : (scope, element) => {
                        element.on('click', () => {
                            var uibModalInstance = $uibModal.open({
                                templateUrl : 'build/Asterisk/Trunk/Views/New.html',
                                controller  : 'TrunkCtrlNew',
                                size        : ``,
                                keyboard    : false,
                                backdrop    : 'static',
                                animation   : false
                            });
                            uibModalInstance.result.then( () => {
                                const Ctrl = angular.element(document.getElementById('TrunkAll')).scope();
                                if(Ctrl) if(Ctrl.manyAction) Ctrl.manyAction.Find();
                            });

                        });
                      },
        template: `<a href uib-tooltip="{{'createTrunk' | translate}}"><nobr><i class="fa fa-phone"></i> {{"trunk" | translate}}</nobr></a>`,
    };
});

crmUA.directive('createSip', $uibModal => {
    return {
        link        : (scope, element) => {
                        element.on('click', () => {
                            var uibModalInstance = $uibModal.open({
                                templateUrl : 'build/Asterisk/SIP/Views/New.html',
                                controller  : 'SIPCtrlNew',
                                size        : ``,
                                keyboard    : false,
                                backdrop    : 'static',
                                animation   : false
                                //windowClass : `lg-dialog`
                            });
                            uibModalInstance.result.then( () => {
                                const Ctrl = angular.element(document.getElementById('SIPAll')).scope();
                                if(Ctrl) if(Ctrl.manyAction) Ctrl.manyAction.Find();
                            });
                        });
                      },
        template: `<a href uib-tooltip="{{'createSIP' | translate}}"><nobr><i class="fa fa-plus"></i> {{"new" | translate}}</nobr></a>`,
    };
});

//Need to fix zhdanov
crmUA.directive('createFavorite', ($uibModal,$stateParams,$timeout) => {
    return {
        controller  : ($scope, $element,$attrs,$timeout) => {
            var uID;
            existInFav = (cb, uID) => {
                cb.some(item => { if(item.uID === uID) $scope.isAdded = true; });
                $timeout(() => { $scope.$apply(); }, 0);
            };

            if(Boolean($stateParams.clID))  new crmClientFindSrv().getFind({clID : $stateParams.clID},  cb => { if(cb.length > 0){ uID = cb[0].uID; new FavoritesSrv().getFind({uID}, cb => {   existInFav (cb,uID); }); } });
            if(Boolean($stateParams.dcID))  new slDealSrv().getFind({dcID : $stateParams.dcID},         cb => { if(cb.length > 0){ uID = cb[0].uID; new FavoritesSrv().getFind({uID}, cb => {   existInFav (cb,uID); }); } });
            if(Boolean($stateParams.psID))  new stProductSrv().getFind({psID : $stateParams.psID},      cb => { if(cb.length > 0){ uID = cb[0].uID; new FavoritesSrv().getFind({uID}, cb => {   existInFav (cb,uID); }); } });
            if(Boolean($stateParams.invID)) new sfInvoiceSrv().getFind({invID : $stateParams.invID},    cb => { if(cb.length > 0){ uID = cb[0].uID; new FavoritesSrv().getFind({uID}, cb => {   existInFav (cb,uID); }); } });
            if(Boolean($stateParams.payID)) new pchPaymentSrv().getFind({payID : $stateParams.payID},   cb => { if(cb.length > 0){ uID = cb[0].uID; new FavoritesSrv().getFind({uID}, cb => {   existInFav (cb,uID); }); } });

            $scope.RemoveFavorite = () => {
                 new FavoritesSrv().del(uID, cb => isAdded(false));
            };

            $scope.openFavoritesModal = () => {
                var modalInstance = $uibModal.open({
                    templateUrl: Gulp + 'Us/Favorites/Views/FavoritesModalView.html',
                    controller: 'FavoritesNewCtrl',
                    size        : `sm`,
                    backdrop    : 'static'
                    //size: 'md'
                });
                modalInstance.result.then( item => {
                    if (item !== undefined){
                        if(Boolean($stateParams.clID))  new crmClientFindSrv().getFind({clID : $stateParams.clID},  cb => { item.uID = cb[0].uID; new FavoritesSrv().ins(item,cb => isAdded(true));});
                        if(Boolean($stateParams.dcID))  new slDealSrv().getFind({dcID : $stateParams.dcID},         cb => { item.uID = cb[0].uID; new FavoritesSrv().ins(item,cb => isAdded(true));});
                        if(Boolean($stateParams.psID))  new stProductSrv().getFind({psID : $stateParams.psID},      cb => { item.uID = cb[0].uID; new FavoritesSrv().ins(item,cb => isAdded(true));});
                        if(Boolean($stateParams.invID)) new sfInvoiceSrv().getFind({invID : $stateParams.invID},    cb => { item.uID = cb[0].uID; new FavoritesSrv().ins(item,cb => isAdded(true));});
                        if(Boolean($stateParams.payID)) new pchPaymentSrv().getFind({payID : $stateParams.payID},   cb => { item.uID = cb[0].uID; new FavoritesSrv().ins(item,cb => isAdded(true));});
                    }
                });
            };

            function isAdded(value){
                $scope.isAdded = value === true ? true : false;
                $timeout(() => { $scope.$apply(); }, 0);
            }
        },
        template: ` <div>
                        <button type="button" ng-hide="isAdded" style="background: transparent; border: none; outline: none;" ng-click="openFavoritesModal()"
                        uib-tooltip="{{'addFavorites' | translate}}">
                            <i class="far fa-star" style=" font-size: 20px;"></i>
                        </button>
                        <button type="button" ng-show="isAdded" style="background: transparent; color: rgb(239, 118, 63); border: none; outline: none;" ng-click="RemoveFavorite()"
                        uib-tooltip="{{'removeFavorites' | translate}}">
                            <i class="fas fa-star" style="font-size: 20px;"></i>
                        </button>
                    </div>`
    };
});

crmUA.directive('nbrClient', $uibModal => {
    return {
        link    : (scope, element, attrs, ctrl) => {
            element.on('click', () => {
                var uibModalInstance = $uibModal.open({
                    templateUrl : 'build/Client/Actualization/Views/Nbr/ModalForm.html',
                    controller  : 'ActualizationNbrCtrl',
                    windowClass : 'xxx-dialog',
                    resolve     : {
                                    ModalItems: () => {
                                        return {"ccName" : attrs.data, "Type": attrs.type};
                                   }
                    },
                    keyboard    : false,
                    backdrop    : 'static',
                    animation   : false
                });
                uibModalInstance.result.then( () => {
                }, () => {
                            //Refresh status base
                            if(scope)if(scope.$parent)if(scope.$parent.$parent)if(scope.$parent.$parent.$parent)scope.$parent.$parent.$parent.GetStatus();
                            localStorage.removeItem('ActualizationModal');
                            ModalOpen = false;
                });
            });
        }
    };
});

crmUA.directive('editCallingcard', $uibModal => {
    return {
        link: (scope, element, attrs) => {
            element.on('click', () => {
                var uibModalInstance = $uibModal.open({
                    templateUrl : `${Gulp}/Callincard/Views/Edit.html`,
                    controller  : 'ccEditCtrl',
                    //size        : ``,
                    windowClass : 'xx-dialog',
                    resolve     : {
                        ModalItems: () => {
                            if(attrs.data) return JSON.parse(attrs.data);
                        }
                    },
                    keyboard    : false,
                    backdrop    : 'static',
                    animation   : false
                });
                uibModalInstance.result.then( i => {
                    console.log(`done edit cc`);
                });
            });
        },
        template: `<a href><nobr><i class="fa fa-phone"></i> {{"detail2" | translate}}</nobr></a>`,
    };
});


crmUA.directive('editRecords', $uibModal => {
    return {
        link: (scope, element, attrs) => {
            element.on('click', () => {
                var uibModalInstance = $uibModal.open({
                    templateUrl : `${Gulp}/Asterisk/RecordsExport/Views/Edit.html`,
                    controller  : 'RecordsExportEditCtrl',
                    size        : ``,
                    keyboard    : true,
                    //backdrop    : 'static',
                    animation   : false,
                    resolve     : {
                        ModalItems: () => {
                            if(attrs.data) return JSON.parse(attrs.data);
                        }
                      },
                });
            });
        },
        template: `<a href uib-tooltip="{{'detail2' | translate}}" style="cursor:pointer;"><i class="fa fa-info"></i> {{"detail2" | translate}} #{{data[$index].idCR}}</a>`,
    };
});