crmUA.filter('groupBy', function() {
    return _.memoize(function(items, field) {
            return _.groupBy(items, field);
        }
    );
});