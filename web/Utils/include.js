include = url => {
    var response = $.ajax({
        url     : url+'.js',
        async   : false
    });
    return response.responseText;
};