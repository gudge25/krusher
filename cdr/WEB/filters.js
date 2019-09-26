app.filter('fix_chan', function() {
     	return function (arr,delim,num){
			if(arr) {
				var split = arr.split(delim);
				//Обрезаем номер если используеться префикс для гоипа
				if (split[num] !== undefined){
					if (split[num].length == 11 && split[num].substr(1, 1) == 0 && split[num].substr(0, 1) != 0 && split[num].substr(2, 1) != 0) {
						split[num] = split[num].substr(1, 11)
					}

				test = split[num].split('*');
				if (test[1] !== undefined)
					split[num] = test[1];

				test2 = split[num].split(',');
				if (test2[0] !== undefined)
					split[num] = test2[0];
				return split[num];
				}
			}
          }
});
app.filter('status', function() {
	return function(input) {		
			switch (input){		
				case 'NO ANSWER'	: { var input = 'не ответил'; 	break; }
				case 'ANSWERED'		: { var input = 'ответил'; 	break; }
				case 'BUSY'			: { var input = 'занят'; 	break; }					 
                case 'FAILED'       : { var input = ''; 	break; }
			}		
		 return input;
	};
});

app.filter('point', function() {
	return function(input,name) {
		var arraytoreturn = [];
	 	angular.forEach(input, function(todo)   {	
			if (todo.calldate.indexOf(name) !== -1) {
				  arraytoreturn.push(todo)
			    } 
		});
		return arraytoreturn;
	};
});

app.filter('sort', function() {
	return function(input) {
			switch (input){		
				case '-calldate'	: { var input = 'Data'; 	break; }
				case 'ANSWERED'		: { var input = 'ответил'; 	break; }
				case 'BUSY'		: { var input = 'занят'; 	break; }					 
                                case 'FAILED'           : { var input = ''; 	break; }
			}		
		 return input;
	};
});

app.filter('filter_operator', function() {
	return function(input,arg1) { 
			var arraytoreturn = [];		
			if(arg1 && input)
			{
				angular.forEach(input, function(todo)   {	
					var String=todo.dstchannel.substring(todo.dstchannel.lastIndexOf("/")+1,todo.dstchannel.lastIndexOf("-"));
					if(todo.src == arg1 || todo.dst == arg1 || String == arg1 ) arraytoreturn.push(todo);
				});
				return arraytoreturn;
			}
			else return input;
	};
}); 
 
