crmUA.filter('mpFilters', function() {
    return input => {
        let a;
        var Files = FactMarketPlaceRun.name;
            angular.forEach(Files.data, todo => {
                if(todo.mpID == input) {  a = todo.mpName;  }
            });
        return a;
    };
});