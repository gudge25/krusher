crmUA.controller('usEnumsNewCtrl', function($scope,$filter, $stateParams) {
    $scope.manyAction =  new usEnumsViewModel($scope, $filter);
    $scope.new = new usEnumsModel('').put();

    $scope.tvID = () => {
        new usEnumsSrv().getFind({ tyID : $scope.new.tyID },cb => { console.log(cb); 
            if(cb)
            if(cb.length){
                $scope.new.tvID = getMax(cb, "tvID").tvID;
                $scope.new.tvID = $scope.new.tvID ? $scope.new.tvID + 1 : null;
                $scope.$apply();
            }
        });
    };
    
    if($stateParams)
        if($stateParams.tyID)
            { $scope.new.tyID = parseInt($stateParams.tyID); $scope.tvID(); }

    function getMax(arr, prop) {
        var max;
        if(arr)
        if(arr.length > 0){
            for (var i=0 ; i<arr.length ; i++) {
                if (!max || parseInt(arr[i][prop]) > parseInt(max[prop]))
                    max = arr[i];
            }
        }
       
        return max ? max : { tvID : null };  
    }

});