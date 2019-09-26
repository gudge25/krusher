//CallStatus
crmUA.filter('enums', () => {
    return  input => {
        let x=true;
        let result;
        let Enums = FactEnumRun.name;
        angular.forEach(Enums.data, todo => {
            if(x)
            if(todo)
            if(todo.tvID)
            if(todo.tvID == input) {
                result = todo.Name;
                x=false;
            }
        });
        return result;
    };
});

//CallStatus
crmUA.filter('enumsType', () => {
    return  input => {
        let x=true;
        let result;
        let Enums = FactEnumRun.name;
        angular.forEach(Enums.group[1], todo => {
            if(x)
            if(todo)
            if(todo.tvID)
            if(todo.tvID == input) {
                result = todo.Name;
                x=false;
            }
        });
        return result;
    };
});