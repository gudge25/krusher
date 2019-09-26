var debouncePHP; var debouncePool;
class BaseSrv {
        constructor(api, Model, idName, options) {
            [ this.Api, this.Model, this.IdName, this.options ] = [ api, Model, idName, options];
        }

        auth(){
            var res = true;
            if(!USERNAME && !PASSWORD) { res = false; GoTOAuth(); } 
            return res;
        }

        /* Get all data*/
        getAll(cb){
            if(this.auth())
            return  $.ajax({
                url: this.Api,
                success: cb,
                dataFilter: d => dataFilterModel(d,this.Model),
            });
        }

        /* Get data from ID */
        get(id,cb){
            if(this.auth())
            return $.ajax({
                url: `${this.Api}/${id}`,
                success: cb,
                dataFilter: d => dataFilterModel(d,this.Model)
            });
        }

        /* Get data from filter */
        getFind(d,cb){
            let route = this.Api;
            let last = route.split("/").pop(-1);
            //console.log(this.Api);
            if( last != `find` && last != `stat` && last != `report` && this.Api != `/api/cc/contacts/export/records`)
                route = `${this.Api}/find`;
            if(  this.Api == `/api/cc/contacts/export/records`)
                route = `${this.Api}/list`;

            if(this.auth())
            return  $.ajax({
                type: 'POST',
                url: route,
                success: cb,
                data: JSON.stringify(new this.Model(d).postFind()),
                dataFilter: d => dataFilterModel(d,this.Model),
                async : this.options ? this.options.async : true
            });
        }

        /* INSERT new data */
        ins(d,cb){
            if(d)if(d.url !== undefined)  this.Api = `${this.Api}/` + d.url;
            if(this.auth() || this.Api == `/api/em/clients`)
            return  $.ajax({
                type: 'POST',
                url: this.Api,
                success: cb,
                data: JSON.stringify(new this.Model(d).post()),
                dataFilter: d => dataFilterModel(d,this.Model)
            }).done( () =>  { this.dataPool();  } );
        }

        /* UPDATE exist data */
        upd(d,cb){
            let a = new this.Model(d).put();
            if(this.auth())
            return  $.ajax({
                type: 'PUT',
                url: `${this.Api}`,
                success: cb,
                data: JSON.stringify(a),
                async : this.options ? this.options.async : true
            }).done( () =>  { this.dataPool(a); } );
        }

        php(){
            //do php script
            //DEBOUNCE!
            clearTimeout(debouncePHP);
            let time = debouncePHP ? 5000 : 0;
            debouncePHP = setTimeout(() => {

                new changeEmplSrv().get(`start.php`);
            }, time);
        }

        /* DELETE exist data */
        del(id,cb){
            if(this.auth())
            return  $.ajax({
                type: 'DELETE',
                url: `${this.Api}/${id}`,
                success: cb
            }).done( () => this.dataPool() );
        }

        /* DELETE exist data */
        postDel(d,cb){
            if(this.auth())
            return  $.ajax({
                type: 'POST',
                url: `${this.Api}/bulkdel`,
                success: cb,
                data: JSON.stringify(new this.Model(d).postDel()),
                dataFilter: d => dataFilterModel(d,this.Model)
            }).done( () => this.dataPool() );
        }


        download(d){
            console.log(this.Api);
            let data = JSON.stringify(new this.Model(d).postFind());
            var xhr = new XMLHttpRequest();
            xhr.open('POST', this.Api, true);
            xhr.responseType = 'arraybuffer';
            xhr.onload = function() {
                 if (this.status === 200) {
                     var filename = "";
                    var disposition = xhr.getResponseHeader('Content-Disposition');
                    if (disposition && disposition.indexOf('attachment') !== -1) {
                        var filenameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
                        var matches = filenameRegex.exec(disposition);
                        if (matches !== null && matches[1]) filename = matches[1].replace(/['"]/g, '');
                    }
                    var type = xhr.getResponseHeader('Content-Type');
                    var blob = typeof File === 'function' ? new File([this.response], filename, { type: type }) : new Blob([this.response], { type: type });
                    if (typeof window.navigator.msSaveBlob !== 'undefined') {
                        // IE workaround for "HTML7007: One or more blob URLs were revoked by closing the blob for which they were created. These URLs will no longer resolve as the data backing the URL has been freed."
                        window.navigator.msSaveBlob(blob, filename);
                    } else {
                        var URL = window.URL || window.webkitURL;
                        var downloadUrl = URL.createObjectURL(blob);

                        if (filename) {
                            // use HTML5 a[download] attribute to specify filename
                            var a = document.createElement("a");
                            // safari doesn't support this yet
                            if (typeof a.download === 'undefined') {
                                window.location = downloadUrl;
                            } else {
                                a.href = downloadUrl;
                                a.download = filename;
                                document.body.appendChild(a);
                                a.click();
                            }
                        } else {
                            window.location = downloadUrl;
                        }
                        setTimeout( () => { URL.revokeObjectURL(downloadUrl); }, 100); // cleanup
                    }
                }
            };
            xhr.setRequestHeader('Content-type', 'application/json; charset=utf-8');
            xhr.setRequestHeader('Authorization', `Basic ${btoa(USERNAME + ":" + PASSWORD)}`);
            if(this.auth())
            xhr.send(data);
        }

         /* UPDATE DATAPOOL*/
        dataPool(d){
            //clearTimeout(debouncePool);
            //let time = debouncePool ? 1000 : 0;
            //debouncePool = setTimeout(() => {
                let last = this.Api.split("/").pop(-1);
                if(last != `items` ){
                    //  console.log(`===============url last =============`);
                    //  console.log(last);
                    switch(last){
                        case `employees`        : FactEmRun.name                    = null;
                                                    if(d)if(d.emID)if(d.emID == EMID){ const NavCtrl = angular.element(document.getElementById('autocall')).scope(); NavCtrl.GetEm(); } /* this.php(); */ break;
                        case `scenario`         : FactScenarioRun.name              = null; this.php(); break;
                        case `enums`            : FactEnumRun.name                  = null; this.php(); break;
                        case `files`            : FactFileRun.name                  = null; this.php(); break;
                        case `ivr`              : FactIVRRun.name                   = null; this.php(); break;
                        case `validation`       : FactPrefixRun.name                = null; this.php(); break;
                        case `members` :
                        case `queues`           : FactQueuesRun.name                = null; this.php(); break;
                        case `records`          : FactRecordRun.name                = null; this.php(); break;
                        case `trunks`           : FactTrunkRun.name                 = null; this.php(); break;
                        case `bases`            : FactBasesRun.name                 = null; this.php(); break;
                        case `taglist`          : FactTagRun.name                   = null; this.php(); break;
                        case `roles`            : FactRoleRun.name                  = null; this.php(); break;
                        case `type`             : FactDocsTypes.name                = null; this.php(); break;
                        case `process`          : FactProccessRun.name              = null; this.php(); break;
                        case `sippeers`         : FactSIPRun.name                   = null; this.php(); break;
                        case `tts`              : FactTTSRun.name                   = null; this.php(); break;
                        case `destination`      : FactCustomDestenationRun.name     = null; this.php(); break;
                        case `group`            : FactTimeGroupRun.name             = null; this.php(); break;
                        case `pools`            : FactTrunkPoolRun.name             = null; this.php(); break;
                        case `callback`         : FactCallBackRun.name              = null; this.php(); break;
                        case `company`          : FactCompanyRun.name               = null; this.php(); break;
                        case `conference`       : FactConferenceRun.name            = null; this.php(); break;
                        case `outgoing`         : FactRouteOutRun.name              = null; this.php(); break;
                        case `incoming`         : this.php(); break;
                    }
                }
            //}, time);
        }
}