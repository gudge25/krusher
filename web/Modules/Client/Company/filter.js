crmUA.filter('coFilter', function() {
    return input => {
        let a;
        var Files = FactCompanyRun.name;
            angular.forEach(Files.data, todo => {
                if(todo.coID == input) {  a = todo.coName;  }
            });
        return a;
    };
});