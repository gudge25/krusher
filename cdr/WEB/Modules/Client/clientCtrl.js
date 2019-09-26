function Clients($scope,$http,$alert,$sce ,$timeout) {

//LOAD DATA

	$scope.load_data_new = function(){
		$http.get( api_node_get  + 'user' ).success(function(data) { console.log(data.json);  $scope.clients = data.json[0];    });
	}	
	$scope.load_data_new();
//SAVE USERS
	$scope.save = function(ID) {
		console.log(ID);	
		$http({
		    method : 'POST',
		    url : api_node_post  + 'user',
		    data :   angular.toJson($scope.clients[ID]),  //angular.toJson($scope.sippeers),
		    headers : {     'Content-Type' : 'application/json'     }
		    }).success(function(data) {     console.log(data);   }) //$alert({title: $sce.trustAsHtml('Holy guacamole!'), content: $sce.trustAsHtml('Best check yo self')}); 
				 .error(function(request, status, error) {    alert(request.responseText);     });	
	}	

	$scope.delete = function( idx ){
		    console.log($scope.clients[idx]);
			$http({
		    method : 'POST',
		    url : api_node_post  + 'user_d',
		    data :   angular.toJson($scope.clients[idx]),   
		    headers : {     'Content-Type' : 'application/json'     }
		    }).success(function(data) {     console.log(data);   })  
				 .error(function(request, status, error) {    alert(request.responseText);     });	
			$scope.clients.splice(idx, 1);
	}

	$scope.add_first =function() { 
		$scope.add_client = { 
					ClientName: "", 
					IsActive: 1, 
					Secret: "", 
					NickName: "" 
				     };
	}

	$scope.add = function(){	
	$http({
            method : 'POST',
            url : 'http://asterisk.biz.ua:3001/user_insert', 
            data :   angular.toJson($scope.add_client),  
            headers : {     'Content-Type' : 'application/json'     }
            }).success(function(data) {     $scope.load_data_new(); })   //$alert({title: $sce.trustAsHtml('Holy guacamole!'), content: $sce.trustAsHtml('Best check yo self')});  
			 .error(function(request, status, error) {    alert(request.responseText);     });
	} 

	
	$scope.type = function(ID){ 
	//	console.log(ID);
		switch(ID){
			case 'Secret'	: { var input = 'password'; break; }
			default: { var input = 'text'; break;     }	
		}
		return input;
	}




        $scope.popover =  {
				//scope: $scope.popover,
                'title':  'Изменить запись',
                'content': ' '
        }
}
