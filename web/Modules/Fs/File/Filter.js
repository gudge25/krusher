crmUA.filter('ffFilters', function() {
    return input => {
        let a;
        var Files = FactFileRun.name;
            angular.forEach(Files.data, todo => {
                if(todo.ffID == input) {  a = todo.ffName;  }
            });
            //if(!a) { a = `Файл отключен`; }
        return a;
    };
});