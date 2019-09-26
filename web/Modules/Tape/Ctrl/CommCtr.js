crmUA.controller('TapeCommCtr', function($scope , $translate, $translatePartialLoader, $rootScope, $stateParams, $filter, $attrs) {

        //FOR Rating GET===============
        $scope.SaveRatingUID = () => {
                    if(!$scope.RankUID.HIID)
                        new usRankSrv().ins($scope.RankUID, () => { $scope.GetFind(); });
                    else  
                        new usRankSrv().upd($scope.RankUID, () => { $scope.GetFind(); });                        
        };

        $scope.GetFind = () => {
            new usRankSrv().getFind({uID : $scope.uID}, cb => { 
                if(cb.length > 0) {
                    $scope.RankUID = cb[0]; 
                    $scope.rate.hoveringOver($scope.RankUID.uRank);
                }
                else 
                    $scope.RankUID = new usRankModel({ uID: $scope.uID }).put(); 
                $scope.$apply();
            });
        };

        //FOR Rating GET  && CallingCard
        if($attrs)
        if($attrs.data){
            $attrs.$observe('data', data => {
                if(data){                    
                    if(data != `{{data}}` && data != `{{upd}}` && data != `{{new}}` && data != `{{client}}` && data != `{{em}}` && data != `{{form}}`){
                            data = JSON.parse(data);
                            $scope.uID = data.uID; 
                            $scope.GetFind();
                            //FOR CallingCard
                            if(window.location.hash == "#!/callingcard")
                                    new usCommentsSrv().getFind({uID : $scope.uID}, cb => { $scope.CommentsUID = cb; $scope.$apply();});
                    }
                }
            });
        }
        //FOR Rating END

        $scope.SaveCommentUID = a => {
                if(a.length > 0) {
                    var p = new usCommentsModel('').put();
                    p.uComment  = a;
                    p.uID       = $scope.uID;
                    new usCommentsSrv().ins(p, () => {
                        new usCommentsSrv().getFind({ uID: $scope.uID}, cb  => {
                            $scope.CommentsUID = cb;
                            $scope.$apply();
                        });
                    });
                }
        };

        $scope.DelComm = a => {
                    new usCommentsSrv().del(a, () => {
                        new usCommentsSrv().getFind({ uID: $scope.uID}, cb  => {
                            $scope.CommentsUID = cb;
                            $scope.$apply();
                        });
                    });
        };

        $scope.comments = {};
        $scope.new      = new usCommentsModel('').post();

        $scope.SetDate = (data,dt,index) => {
                    if(index !== 0){
                       $scope.Dt=$filter('date')(dt, 'dd.MM.yyyy');
                       $scope.NewDt=$filter('date')(data[index-1].Changed, 'dd.MM.yyyy');
                       if ($scope.Dt == $scope.NewDt)
                           return false;
                       else
                           return true;
                    }
                    else
                      return true;
        };

        if(Boolean($stateParams.emID)) {
                    $scope.emID = $stateParams.emID;
                    new emEmployeeSrv().getFind({ emID : $stateParams.emID}, cb => { if(cb.length > 0){ $scope.uID = cb[0].uID; new usCommentsSrv().getFind({uID : $scope.uID}, res => {$scope.CommentsUID = res; $scope.$apply();}); } });
                    new hEmSrv().getFind( { emID : $stateParams.emID }, cb => { $scope.documents = cb; $scope.$apply();});
        }

        if(Boolean($stateParams.clID)) {
                    $scope.clID = $stateParams.clID;
                    new crmClientFindSrv().getFind({ clID : $stateParams.clID}, cb => { if(cb.length > 0){ $scope.uID = cb[0].uID; new usCommentsSrv().getFind({uID : $scope.uID}, res => {$scope.CommentsUID = res; $scope.$apply();}); } });
                    new hClientSrv().getFind( { clID : $stateParams.clID }, cb => { $scope.documents = cb; $scope.$apply();});
        }
        if(Boolean($stateParams.dcID)) {
                    $scope.dcID = $stateParams.dcID;
                    // new dcDocsHistorySrv().get( $stateParams.dcID, cb => { $scope.documents = cb; $scope.$apply();});
                    new slDealSrv().getFind({ dcID : $stateParams.dcID}, cb => {
                        $scope.currentDoc = cb[0];
                        $scope.uID = cb[0].uID;
                        new usCommentsSrv().getFind({uID : $scope.uID}, res => {$scope.CommentsUID = res; $scope.$apply();});
                    });
        }
        if(Boolean($stateParams.invID)){
                    $scope.invID = $stateParams.invID;
                    // new dcDocsHistorySrv().get( $stateParams.invID, cb => { $scope.documents = cb; $scope.$apply();});
                    new sfInvoiceSrv().getFind({ invId : $stateParams.invID},    cb => {
                        $scope.currentDoc = cb[0];
                        $scope.uID = cb[0].uID;
                        new usCommentsSrv().getFind({uID : $scope.uID}, res => {$scope.CommentsUID = res; $scope.$apply();}); });
        }
        if(Boolean($stateParams.payID)) {
                    $scope.payID = $stateParams.payID;
                    // new dcDocsHistorySrv().get( $stateParams.formID, cb => { $scope.documents = cb; $scope.$apply();});

                    new pchPaymentSrv().getFind({ payID : $stateParams.payID} ,   cb => {
                        $scope.currentDoc = cb[0];
                        $scope.uID = cb[0].uID;
                        new usCommentsSrv().getFind({uID : $scope.uID}, res => {$scope.CommentsUID = res; $scope.$apply();}); });
        }
        if(Boolean($stateParams.formID)) {
                    $scope.formID = $stateParams.formID;
                    // new dcDocsHistorySrv().get( $stateParams.formID, cb => { $scope.documents = cb; $scope.$apply();});
                    new fmFormsSrv().getFind( { formID : $stateParams.formID}, cb => {
                        $scope.currentDoc = cb[0];
                        $scope.uID = cb[0].uID;
                        new usCommentsSrv().getFind({uID : $scope.uID}, res => {$scope.CommentsUID = res; $scope.$apply();});
                    });
        }
});