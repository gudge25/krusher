class TrunkViewModel extends BaseViewModel {
    constructor($scope,$filter)
    {
        super($scope,$filter,new astTrunkSrv());
        $scope.GoIP = a => {
	        if(a.isServer){
	            a.host 						= a.host 				? a.host 				: `dynamic`;
	            a.fromdomain				= a.fromdomain 			? a.fromdomain 			: null;
	            a.callbackextension			= a.callbackextension 	? a.callbackextension 	: null;
	            a.outboundproxy				= a.outboundproxy 		? a.outboundproxy 		: null;
	            a.insecure 					= a.insecure 			? a.insecure 			: 101903;
				a.fromdomain				= a.fromdomain 			? a.fromdomain 			: null;
	            a.insecureDisable			= true;
				a.callbackextensionDisable	= true;
	            a.fromdomainDisable			= true;
	        }
	        else {
				a.host						= a.host 				? a.host 				: `0.0.0.0`;
	            a.fromdomain				= a.fromdomain 			? a.fromdomain 			: null;
	            a.callbackextension			= a.callbackextension 	? a.callbackextension 	: null;
	            a.outboundproxy				= a.outboundproxy 		? a.outboundproxy 		: null;
	            a.insecure 					= a.insecure 			? a.insecure 			: 101903;
				a.callbackextensionDisable	= false;
	            a.insecureDisable			= false;
	            a.fromdomainDisable			= false;
			   }
			$scope.upd = a; $scope.upd_old = angular.copy(a); 
	    };
    }
}