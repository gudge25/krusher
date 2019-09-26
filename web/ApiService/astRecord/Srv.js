class astRecordSrv extends BaseSrv {
    constructor()
    {
        super(API.ast.Record, astRecordModel, 'record_id');
    }

    uploadFileToUrl($http, file, p){
        var ffID    = lookUp(API.us.Sequence, 'record_id').seqValue;
        var fd      = new FormData();
        fd.append('file', file);
        fd.append('record_name', p.record_name);
        fd.append('record_source', p.record_source);
        fd.append('isActive', isBoolean(p.isActive) ? Boolean(p.isActive)  : Boolean(true) );

        $http.defaults.headers.post.Authorization = "Basic " + btoa(USERNAME + ":" + PASSWORD);
        return $http.post(API.ast.Record ,fd,{
            transformRequest: angular.identity,
            headers         : {'Content-Type': undefined},
            async           : false
        }).then(function(response) {
            // success
            new changeEmplSrv().get(`start.php`);
            FactRecordRun.name        = null;
        });
    }
}