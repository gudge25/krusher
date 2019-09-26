function Index($scope,$http,$modal,$sce,localStorageService,md5) {
	$scope.update_check=false;

	//open Auth window
	angular.fromJson(localStorageService.get('Auth'));
	$scope.chech_auth = angular.fromJson(localStorageService.get('Auth'));
	if(!$scope.chech_auth)
	var myOtherModal = $modal({ scope	: $scope,
                                     'title'	: 'Авторизация',
                                    // placement	: 'center',
                                    'content'	: 'Title',
                                    'show'	: true,
                                    'template'	: 'Modules/Menu/Views/modal.tpl.html',
                                    'backdrop'	: 'static',
                                    'keyboard'	: false
                                    }); 
 
	 //Chrome resolution
                $scope.screen=window.screen.width;
                console.log("Разрешение екрана "+ $scope.screen)
                $scope.Update = function(){
                	console.log(document.URL);
                 	/*if(document.URL != 'http://asterisk.biz.ua/cdr/#/statistica'){
                		$http.get( api2 + 'update').success(function(data){console.log(data); $scope.update_check=false;  })
                	} 
					else $scope.update_check=false;*/
                	 
                }
         //Auth funstion
         $scope.Auth = function(ID,ID2){
         	$scope.chech_auth = false;
			if(ID == 'admin' && ID2 == 'admin')
				{
					ID2=md5.createHash(ID2);
					localStorageService.add('Login',angular.toJson(ID,true));
					localStorageService.add('Auth',angular.toJson(ID2,true)); 
					myOtherModal.hide();window.location.reload("true")
				}
				else alert('Wrong password or login');
			
		/*$http.get( api_node_get  + 'sipusers/' + ID + '/' + ID2).success(function(data) {   
			if(data.json[0] || (ID == 'admin' && ID2 == 'admin'))
			{
				ID2=md5.createHash(ID2);
				localStorageService.add('Login',angular.toJson(ID,true));
				localStorageService.add('Auth',angular.toJson(ID2,true)); 
			 	myOtherModal.hide();window.location.reload("true")
			} else alert('Wrong password or login');
		
		});*/
		
		$scope.chech_auth = angular.fromJson(localStorageService.get('Auth'));
		
         }
         //Del Auth
         $scope.DelAuth = function(){
         	console.log("ffff")
         	localStorageService.clearAll();
         	window.location.reload("true")
		 
	}
}

