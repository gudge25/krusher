crmUA.filter('formFilters', () => {
    return input => {
        let a;
        let data = FormTypeRun.name;
            angular.forEach(data.data, todo => {
                if(todo.tpID == input) {  a = todo.tpName;  }
            });
        return a;
    };
});

crmUA.filter('docsTypesFilters', () => {
    return input => {
        let a;
        let data = FactDocsTypesRun.name;
            angular.forEach(data.data, todo => {
                if(todo.dctID == input) {  a = todo.dctName;  }
            });
        return a;
    };
}); 