crmUA.filter('emFilters', function() {
    return input => {
        let a;
        let Employee = FactEmRun.name;
            angular.forEach(Employee.data, todo => {
                if(todo.emID == input) {  a = todo.emName;  }
            });
        return a;
    };
});