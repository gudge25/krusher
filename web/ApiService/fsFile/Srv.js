class fsFileSrv extends BaseSrv {
    constructor()
    {
        super( API.fs.Files, fsFileModel, 'ffID');
    }

    uploadFileToUrl($http, file, fsFiles, s, e){
        var ffID    = lookUp(API.us.Sequence, 'ffID').seqValue;
        var fd      = new FormData();
        fd.append('file', file);
        fd.append('ffID', ffID);
        fd.append('ftID', fsFiles.TemplateTId);
 
        fd.append('dbID', fsFiles.dbID);
        $http.defaults.headers.post.Authorization = "Basic " + btoa(USERNAME + ":" + PASSWORD);

        return $http.post(`${API.fs.Files}/import` ,fd,{
            transformRequest: angular.identity,
            headers         : {'Content-Type': undefined},
            async           : false
        })
        // .then(function onSuccess(response) {
        //     // Handle success
        //     var data = response.data;
        //     var status = response.status;
        //     var statusText = response.statusText;
        //     var headers = response.headers;
        //     var config = response.config;
        //     console.log(response)
             
        //   }).catch(function onError(response) {
        //     // Handle error
        //     var data = response.data;
        //     var status = response.status;
        //     var statusText = response.statusText;
        //     var headers = response.headers;
        //     var config = response.config;
        //     console.log(response)
        //    });
        // .success(s)
        // .error(e);
    }
}
