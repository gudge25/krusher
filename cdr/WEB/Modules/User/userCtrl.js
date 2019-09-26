function Users($scope,$http, $alert,$timeout) {

//LOAD DATA
	$scope.load_data_new = function(){
		$http.get( api_node_get  + 'sipusers' ).success(function(data) { $scope.sippeers = data.json[0]; $scope.tpl = angular.copy(data.json[0]);
			$scope.sippeers_group = _.groupBy($scope.sippeers, 'context');
		});
		
	}; 
	$scope.load_data_new();
	
//SAVE SIP USERS
	$scope.save = function(ID) {
		console.log(ID);	
		$http({
		    method : 'POST',
		    url : api_node_post  + 'sipusers_u',
		    data :   angular.toJson($scope.sippeers[ID]),   
		    headers : {     'Content-Type' : 'application/json'     }
		    }).success(function(data) {     console.log(data);   })  
				 .error(function(request, status, error) {    alert(request.responseText);     });	
		
			$http({
			    method : 'POST',
			    url : 'http://asterisk.biz.ua/cdr/MODULES/sip_db_conf.php',
			    data :   angular.toJson($scope.sippeers.sort(name)),   
			    headers : {     'Content-Type' : 'application/json'     }
			    }).success(function(data) {     console.log(data);   })  
					 .error(function(request, status, error) {    alert(request.responseText);     });
			$timeout( function() {$scope.load_data_new();	}, 500);
		 	 
		
	}	
//ORDE BY
	$scope.orderProd = "-calldate";

//MENU ASIDE
	$scope.aside = {
	  "title": "Title",
	  "content": "Hello Aside <br/> This is a multiline message!"
	};
	
//DELL SIP USERS
	$scope.delete = function( idx,ID2 ){
	console.log(ID2);
	$http({
            method : 'POST',
            url : 'http://asterisk.biz.ua:3001/sipusers_d', 
            data :   angular.toJson($scope.sippeers[idx]),  
            headers : {     'Content-Type' : 'application/json'     }
        }).success(function(data) {     $scope.load_data_new(); })     
			 .error(function(request, status, error) {    alert(request.responseText);     });
			 
		    $scope.sippeers.splice(idx, 1);
			$http({
			    method : 'POST',
			    url : 'http://asterisk.biz.ua/cdr/MODULES/sip_db_conf.php',
			    data :   angular.toJson($scope.sippeers.sort(name)),   
			    headers : {     'Content-Type' : 'application/json'     }
			    }).success(function(data) {     console.log(data);   })  
					 .error(function(request, status, error) {    alert(request.responseText);     });
			$timeout( function() {$scope.load_data_new();	}, 500);
	}

	$scope.add_first =function() { 
		$scope.add_client = {
							name 		: "",		
							allow 		: "ulaw,gsm",		
							insecure 	: "invite",		
							qualify 	: "yes",		
							type 		: "friend",			
							callLimit	: "3", 		
							disallow 	: "all",		
							language 	: "ru",		
							secret 		: "",		
							callerid 	: "",		
							dtmfmode	: "info", 		
							textsupport : "no",	
							context 	: "office",		
							host		: "dynamic", 			
							nat			: "force_rport,comedia", 			
							transport	: "udp" 					
							}; 	
$scope.sippeers.push($scope.add_client);							
	}

	$scope.add = function(){	
			$http({
				method : 'POST',
				url : 'http://asterisk.biz.ua:3001/sipusers', 
				data :   angular.toJson($scope.add_client),  
				headers : {     'Content-Type' : 'application/json'     }
				}).success(function(data) {     $scope.load_data_new(); })   
				 .error(function(request, status, error) {    alert(request.responseText);     });
			 
            
		    $scope.load_data_new();
			$http({
			    method : 'POST',
			    url : 'http://asterisk.biz.ua/cdr/MODULES/sip_db_conf.php',
			    data :   angular.toJson($scope.sippeers.sort(name)),   
			    headers : {     'Content-Type' : 'application/json'     }
			    }).success(function(data) {     console.log(data);   })  
					 .error(function(request, status, error) {    alert(request.responseText);     });
	 
	} 
	
	$scope.Test_jeka = function(){
		$http({
			    method 	: 'POST',
			    url 	: 'http://asterisk.biz.ua/cdr/MODULES/mod/sip_db_conf.php',
			    data 	:   angular.toJson($scope.sippeers.sort(name)),   
			    headers 	: {     'Content-Type' : 'application/json'     }
			    }).success(function(data) {     console.log(data);   })  
					 .error(function(request, status, error) {    alert(request.responseText);     });
	}
	$scope.Test_anton = function(){
		$http({
			    method 	: 'POST',
			    url 	: 'http://asterisk.biz.ua/cdr/MODULES/ssh_conf.php',
			    data 	:   angular.toJson($scope.sippeers.sort(name)),   
			    headers 	: {     'Content-Type' : 'application/json'     }
			    }).success(function(data) {     console.log(data);   })  
					 .error(function(request, status, error) {    alert(request.responseText);     });
	}

	$scope.KET = function(){
		$http({
			    method 	: 'POST',
			    url 	: 'http://176.192.20.30:83/sip.php',
			    data 	:   angular.toJson($scope.sippeers.sort(name)),   
			    headers 	: {     'Content-Type' : 'application/json'     }
			    }).success(function(data) {     console.log(data);   })  
					 .error(function(request, status, error) {    alert(request.responseText);     });
	}
	
	
	$scope.panew = function(){
	console.log("PANEW")
	var a = [
      {
        "name": "101",
        "disallow": "all",
        "allow": "g722,ulaw,gsm",
        "insecure": "invite",
        "qualify": "yes",
        "type": "friend",
        "call-limit": 10,
        "language": "ru",
        "secret": "78945612Qw",
        "callerid": "Zhdanov HTC",
        "dtmfmode": "auto",
        "textsupport": "no",
        "context": "office",
        "host": "dynamic",
        "nat": "force_rport,comedia",
        "transport": "udp",
        "id": 172,
		"SUBNUMBER_ID":"00001",
		"TYPE":"SMS",
		"STATUS":"START",
		"PHONE":"098442044"
      }
]
	
	
		$http({
			    method 	: 'POST',
			    url 	: 'http://176.192.20.30:83/sip.php',
			    data 	:   angular.toJson(a.sort(name)),   
			    headers 	: {     'Content-Type' : 'application/json'     }
			    }).success(function(data) {     console.log(data);   })  
					 .error(function(request, status, error) {    alert(request.responseText);     });
	}
	
	$scope.type = function(ID){ 
		//console.log(ID);
		switch(ID){
			case 'secret'	: { var input = 'password'; break; }
			default		: { var input = 'text'; break;     }	
		}
		return input;
	}
	
	$scope.group =[]
	$scope.addGroup = function(ID){
		if(ID && ID != '')
		{
			var g1 = { 
						name	:	ID
						
						} 
			$scope.group.push(g1)
		}
	}

	$scope.delete_g = function( idx  ){
		$scope.group.splice(idx, 1);
	}
	
	//----drag & drop
 $scope.list1 = [];
  $scope.list2 = [];
  $scope.list3 = [];
  $scope.list4 = [];
  
  $scope.list5 = [
    { 'title': 'Item 1', 'drag': true },
    { 'title': 'Item 2', 'drag': true },
    { 'title': 'Item 3', 'drag': true },
    { 'title': 'Item 4', 'drag': true },
    { 'title': 'Item 5', 'drag': true },
    { 'title': 'Item 6', 'drag': true },
    { 'title': 'Item 7', 'drag': true },
    { 'title': 'Item 8', 'drag': true }
  ];

  // Limit items to be dropped in list1
  $scope.optionsList1 = {
    accept: function(dragEl) {
      if ($scope.list1.length >= 2) {
        return false;
      } else {
        return true;
      }
    }
  };

  $scope.hideMe = function() {
    return $scope.list4.length > 0;
  }
	
}
/*

$(function() {
  $("#catalog").accordion();
});*/
