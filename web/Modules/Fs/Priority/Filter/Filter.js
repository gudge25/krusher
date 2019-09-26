//BAse name
crmUA.filter('dbname', () => {
    return  input => {
        let x=true;
        let result;
		return new fsBasesSrv().getFind({},cb => {
				angular.forEach(cb, todo => {
		            if(x)
			            if(todo.dbID == input) {
			                result = todo.dbName;
			                x=false;
			                console.log(result);
							return result;
			            }
	        	});
		});

    };
});