function AjaxSettings() {
    $.ajaxSetup({
       /* headers: {
            "Authorization": `Basic ${btoa(USERNAME + ":" + PASSWORD)}`
        },*/
        async: true,
        type: `GET`,
        dataType: `json`,
        contentType: `application/json; charset=utf-8`,
        error: function (data) {
            console.log(data.responseText);
        },
        statusCode: {
            200: function(data,status,xml) { },
            204: function(data,status,xml) { },
            404: function() { console.log( `page not found` );  },
            409: function() { console.log( `Conflict` );  }
        }
    });
}
AjaxSettings();

function dataFilterModel(data,Model){
            var result;
            arr =[];

            if(data != '[]' && Model ){
                    data = JSON.parse(data);
                if(0 in data)
                    for(var k in data) { arr.push(new Model(data[k]).get()); }
                else
                    arr = new Model(data).get();
                result = JSON.stringify(arr);
            }
            else result = data;

            if(data.data && Model) result = JSON.stringify(data.data);

    return result;
}