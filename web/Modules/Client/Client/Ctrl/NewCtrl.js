crmUA.controller('crmClientCtrlNew', function($scope,$stateParams,$timeout,$uibModal,ModalItems,$filter) {

    $scope.manyAction =  new crmClientNewViewModel($scope, $filter);

    var ffID            = null;
    // $scope.Position     = $scope.EnumsGroup[1012];
    $scope.tags         = {};
    // $scope.orgTypes     = $scope.EnumsGroup[3];
    // $scope.contactsName = $scope.EnumsGroup[4];
    $scope.Org          = {};
    $scope.CallDate     = {};

    $scope.Reset = () => {
        console.log(`RESET`);
        $scope.model = { ffID : null ,  IsPerson : true};
         if($scope.newCl) {ffID  = $scope.newCl.ffID;}
        $scope.newCl            = new crmClientModel($scope.model).put();
        if (ffID) $scope.newCl.ffID = ffID;
        if($scope.newCl.ffID >= 0) $scope.ffID = true;
        $scope.contacts         = null;
        $scope.ExtendContact();
        $scope.Parent           = null;

        let clName = null;
        if($scope.newComp)
        clName = $scope.newComp.clName  ? $scope.newComp.clName : null;
        $scope.newComp = new crmClientModel({ clName, ffID, IsPerson : false } ).put();
    };


    // new fsFileSrv().getFind({}, cb => {
    //     $scope.files = cb;
    //     //Autoselect FILE
    //     if(cb) $scope.model = { ffID : null }; //{ ffID : cb[0].ffID };
    //     $scope.Reset();
    //     $scope.newComp = new crmClientModel($scope.model).put();
    //     $scope.newComp.IsPerson = false;
    //     $scope.$apply();
    // });

    $scope.Cancel  = index => $scope.contacts.splice(index, 1);

    $scope.addContact = () => {
        var arr = [];
        arr.clID = $scope.clID;
        if($scope.contacts === null) $scope.contacts = [];
        $scope.contacts.push(new crmContactModel(arr).put());
        $scope.contacts.forEach( item => item.isActive = true);
    };

    //COMPANY TYPE ORG TYPE
    // "isToday": false,
    // "tvID": 100401,
    // "tyID": 3,
    // "Name": "Аналитик",
    // "NameT": "Аналитик"
    //$scope.orgTypes[0]={"tvID" : null,"tyID" : 3, "Name" : '- '+ $filter('translate')('type') + ' -'};


    //SAVE CLIENT
    $scope.Save = (cl,cc) => {
        //console.dir(cl);
        saveClient = () => {
            console.dir(cl);
            console.dir(cc);
            //FOR UPDATE CLIENT if select
            if(cl.clID) {
                new crmClientSrv().upd(cl, cb => {
                        if(cc !== undefined){
                            let x = 0;
                            let loopArray = arr => {
                                    let comp = false;
                                    x++;
                                    arr[x].clID = cl.clID;
                                    if(arr[x].Create)
                                       comp = new crmContactSrv().ins(arr[x]);
                                    else
                                       comp = new crmContactSrv().upd(arr[x]);
                                    // any more items in array? continue loop
                                    if (comp)$.when(comp).done( () => {
                                        if(x < arr.length) loopArray(arr);
                                    });
                             };
                            // start 'loop'
                            loopArray(cc);
                        }
                });
            }
            else
            {
                    let clID = cl.clID = lookUp(API.us.Sequence, 'clID').seqValue;
                    if (!cl.ParentID) cl.ParentID = $scope.newComp.clID;
                    new crmClientSrv().ins(cl, () => {
                        if(cc !== undefined){
                            angular.forEach(cc, value => {
                                value.clID      = clID;
                                value.isActive  = true;
                                new crmContactSrv().ins(value);
                            });
                        //Save tag
                        if ($scope.tags.tagID && $scope.tags.tagID.length >0) {
                            insTagData = {"clID" : clID, "tags" :$scope.tags.tagID};
                            new crmTagListSrv().ins(insTagData);
                        }
                        //Save CallDate
                        if($scope.CallDate.date){
                            new crmClientExSrv().getFind({ clID }, cb => {
                                if(cb.length > 0){
                                    let callDate = {"clID": clID,"CallDate": $scope.CallDate.date,"isNotice": true, "HIID": cb[0].HIID};
                                    new crmClientExSrv().upd(callDate);
                                }
                            });
                        }
                        if($scope.Org.tvID){
                            let org = {"clID": clID,"OrgType": $scope.Org.tvID,'ShortName':cl.clName};
                            new orgSrv().ins(org);
                        }
                        }
                        window.location = `/#!/clientPreView/${clID}`;
                    });
                }
            };

            //FOR SAVE CONTRAGENT
            var comp = false;
            if ($scope.newComp.clID) $scope.newCl.ParentID = $scope.newComp.clID;
            if (!Boolean($scope.newCl.ParentID) && $scope.newComp.clName && $scope.newComp.clName.length >0) {
                $scope.newComp.clID = lookUp(API.us.Sequence, 'clID').seqValue;
                comp                = new crmClientSrv().ins($scope.newComp);
                cl.ParentID         = $scope.newComp.clID;
            }
            else {
                saveClient();
            }
            if (comp) $.when(comp).done( () => { console.log(`done company save`); saveClient(); });
    };
    var arr;
    //nasledyem contact
    if($stateParams.ccName) arr = $stateParams;
    if(ModalItems.ccName)   arr = ModalItems;
    $scope.ExtendContact = () =>  {
        if(arr) {
            if($scope.contacts == null) $scope.contacts = [];
            let cont = new crmContactModel(arr).put();
            [cont.Create,cont.ccType] = [true,36];
            $scope.contacts.push(cont);
            $timeout(() => {  // Bug ngOptions
                $scope.selected = true;
                $scope.$apply();
            },500,false);
        }
    };
    $scope.ExtendContact();
    $scope.Reset();

    $scope.GetClient = () =>  {
        new crmClientFindSrv().getFind({ clID : $scope.searchclient2.clID}, cb => {
                $scope.newCl = cb[0];
                if(Boolean($scope.newCl.ParentID)) {
                    new crmClientFindSrv().getFind({ clID :$scope.newCl.ParentID}, cb => { $scope.Parent = cb[0];  $scope.$apply();});
                } else $scope.Parent = null;
                new crmContactSrv().getFind({ clID :$scope.searchclient2.clID} ,cb => {
                    $scope.contacts = cb;
                    $scope.ExtendContact();
                    $scope.$apply();
                });
        });
    };
});