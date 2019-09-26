crmUA.controller('RecordNewCtrl', function($scope,$filter, $translate, $translatePartialLoader, $http, $timeout) {
    $scope.manyAction =  new astRecordViewModel($scope, $filter);
    $scope.new = new astRecordModel('').put();


    $scope.submit = fsFiles => {
        var file        = $scope.fileToUpload;
        $scope.upload   = new astRecordSrv().uploadFileToUrl($http, file, fsFiles ,$scope)
            .success( () => {
                delete $scope.load;
                //new astRecordSrv().getAll(cb => { $scope.files = cb; $scope.$apply(); });
                $scope.Clear();
                $timeout( () => {
                    $scope.$apply('files');
                }, 0, false);
            })
            .error( a => {
            	if(a.message) a = a.message;
                let message = a.substring(a.lastIndexOf(":") + 1, a.length).trim();
				$scope.Clear(); alert(message);
            });
    };

    $scope.Clear = () => {
        $('#fileMobile').val('');
        delete $scope.fileToUpload;
        delete $scope.upload;
        delete $scope.load;
    };

    getFileData = that => {
        let file = that.value.toString();
        $scope.fileName = file.split("\\").pop();
    };

    $scope.$watch('fileToUpload', () => {
        if($scope.fileToUpload)
        {
            var a =  $scope.fileToUpload.name.split('.').pop(-1);
            if(a == "wav" || a == "mp3"|| a == "gsm" ) $scope.match = true;
            else delete $scope.match;
        }
        else delete $scope.match;
    });

});
