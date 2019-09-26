crmUA.filter('Action', function($filter) {
    return function(input) {
        switch (input){
            case "U"            : { input = $filter('translate')('renew');    break; }
            case "I"            : { input = $filter('translate')('create');   break; }
            case "D"            : { input = $filter('translate')('deleted');  break; }
            default             : { input = $filter('translate')('unknown');  break; }
        }
        return input;
    };
});

// crmUA.filter('Emp', function() {
//     return function(input) {
//         let a = [];
//             angular.forEach(Employee, value => {
//                 if(value.emID == input) a = value;
//             });
//         return a.emName;
//     };
// });