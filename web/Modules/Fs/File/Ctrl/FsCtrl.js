crmUA.controller('FsCtrl', function($scope, $http, $timeout, $filter) {

    new astTTSSrv().getFind({}, cb          => { $scope.TTS     = cb; $scope.$apply(); });
    new fsTemplatesSrv().getFind({}, cb    	=> { $scope.templates = cb; $scope.$apply(); });
 	new fmFormTypesSrv().getFind({},cb			=> { $scope.formTypes = cb; $scope.$apply(); });
    $scope.fsFile = new fsFileModel('').post();
    $scope.fsFile.TemplateTId = $scope.fsFile.TemplateTId ? $scope.fsFile.TemplateTId : null;

    $scope.Del = id => {
        new fsFileSrv().del(id,() => { FactFileRun.name = null; });
    };

    $scope.submit = fsFiles => {
        var file        = $scope.fileToUpload;
        $scope.upload   = new fsFileSrv().uploadFileToUrl($http, file, fsFiles ,$scope)
        .then(function onSuccess(response) {
            // Handle success
            // var data = response.data;
            // var status = response.status;
            // var statusText = response.statusText;
            // var headers = response.headers;
            // var config = response.config;
            // console.log(response)
            delete $scope.load;
            FactFileRun.name = null;
            $scope.Clear();
            $timeout( () => {
                    $scope.$apply('File');
            }, 1000, false); 
          }).catch(function onError(response) {
            // Handle error
            // var data = response.data;
            // var status = response.status;
            // var statusText = response.statusText;
            // var headers = response.headers;
            // var config = response.config;
            // console.log(response)
            if(a.message) a = a.message;
            let message = a.substring(a.lastIndexOf(":") + 1, a.length).trim();
            $scope.Clear(); alert(message);
        });
    };

    $scope.Get = a => {
        if(a) return  new fsTemplatesSrv().get(a,cb => cb);
    };

    $scope.Clear = () => {
        $('#fileMobile').val(null).clone(true);
        delete $scope.fileToUpload;
        delete $scope.upload;
        delete $scope.load;
        delete $scope.file;
    };

    $scope.$watch('fileToUpload', () => {
        if($scope.fileToUpload)
        {
            var a =  $scope.fileToUpload.name.split('.').pop(-1);
            if(a == "csv" || a == "xlsx" || a == "xls") $scope.match = true;
            else delete $scope.match;
        }
        else delete $scope.match;
    });



    getFileData = that => {
        let file = that.value.toString();
        $scope.fileName = file.split("\\").pop();
    };



});


 //testing XLSX
    // var X = XLSX;
    // var XW = {
    //     /* worker message */
    //     msg: 'xlsx',
    //     /* worker scripts */
    //     rABS: './bower_components/js-xlsx/xlsxworker2.js',
    //     norABS: './bower_components/js-xlsx/xlsxworker1.js',
    //     noxfer: './bower_components/js-xlsx/xlsxworker.js'
    // };
    // var rABS = typeof FileReader !== "undefined" && typeof FileReader.prototype !== "undefined" && typeof FileReader.prototype.readAsBinaryString !== "undefined";
    // if(!rABS) {
    //     document.getElementsByName("userabs")[0].disabled = true;
    //     document.getElementsByName("userabs")[0].checked = false;
    // }
    // var use_worker = typeof Worker !== 'undefined';
    // if(!use_worker) {
    //     document.getElementsByName("useworker")[0].disabled = true;
    //     document.getElementsByName("useworker")[0].checked = false;
    // }
    // var transferable = use_worker;
    // if(!transferable) {
    //     document.getElementsByName("xferable")[0].disabled = true;
    //     document.getElementsByName("xferable")[0].checked = false;
    // }
    // var wtf_mode = false;
    // function fixdata(data) {
    //     var o = "", l = 0, w = 10240;
    //     for(; l<data.byteLength/w; ++l) o+=String.fromCharCode.apply(null,new Uint8Array(data.slice(l*w,l*w+w)));
    //     o+=String.fromCharCode.apply(null, new Uint8Array(data.slice(l*w)));
    //     return o;
    // }
    // function ab2str(data) {
    //     var o = "", l = 0, w = 10240;
    //     for(; l<data.byteLength/w; ++l) o+=String.fromCharCode.apply(null,new Uint16Array(data.slice(l*w,l*w+w)));
    //     o+=String.fromCharCode.apply(null, new Uint16Array(data.slice(l*w)));
    //     return o;
    // }
    // function s2ab(s) {
    //     var b = new ArrayBuffer(s.length*2), v = new Uint16Array(b);
    //     for (var i=0; i != s.length; ++i) v[i] = s.charCodeAt(i);
    //     return [v, b];
    // }
    // function xw_noxfer(data, cb) {
    //     var worker = new Worker(XW.noxfer);
    //     worker.onmessage = function(e) {
    //         switch(e.data.t) {
    //             case 'ready': break;
    //             case 'e': console.error(e.data.d); break;
    //             case XW.msg: cb(JSON.parse(e.data.d)); break;
    //         }
    //     };
    //     var arr = rABS ? data : btoa(fixdata(data));
    //     worker.postMessage({d:arr,b:rABS});
    // }
    // function xw_xfer(data, cb) {
    //     var worker = new Worker(rABS ? XW.rABS : XW.norABS);
    //     worker.onmessage = function(e) {
    //         switch(e.data.t) {
    //             case 'ready': break;
    //             case 'e': console.error(e.data.d); break;
    //             default: xx=ab2str(e.data).replace(/\n/g,"\\n").replace(/\r/g,"\\r"); console.log("done"); cb(JSON.parse(xx)); break;
    //         }
    //     };
    //     if(rABS) {
    //         var val = s2ab(data);
    //         worker.postMessage(val[1], [val[1]]);
    //     } else {
    //         worker.postMessage(data, [data]);
    //     }
    // }
    // function xw(data, cb) {
    //     transferable = document.getElementsByName("xferable")[0].checked;
    //     if(transferable) xw_xfer(data, cb);
    //     else xw_noxfer(data, cb);
    // }
    // function get_radio_value( radioName ) {
    //     var radios = document.getElementsByName( radioName );
    //     for( var i = 0; i < radios.length; i++ ) {
    //         if( radios[i].checked || radios.length === 1 ) {
    //             return radios[i].value;
    //         }
    //     }
    // }
    // function to_json(workbook) {
    //     var result = {};
    //     workbook.SheetNames.forEach(function(sheetName) {
    //         var roa = X.utils.sheet_to_row_object_array(workbook.Sheets[sheetName]);
    //         if(roa.length > 0){
    //             result[sheetName] = roa;
    //         }
    //     });
    //     return result;
    // }
    // function to_csv(workbook) {
    //     var result = [];
    //     workbook.SheetNames.forEach(function(sheetName) {
    //         var csv = X.utils.sheet_to_csv(workbook.Sheets[sheetName]);
    //         if(csv.length > 0){
    //             result.push("SHEET: " + sheetName);
    //             result.push("");
    //             result.push(csv);
    //         }
    //     });
    //     return result.join("\n");
    // }
    // function to_formulae(workbook) {
    //     var result = [];
    //     workbook.SheetNames.forEach(function(sheetName) {
    //         var formulae = X.utils.get_formulae(workbook.Sheets[sheetName]);
    //         if(formulae.length > 0){
    //             result.push("SHEET: " + sheetName);
    //             result.push("");
    //             result.push(formulae.join("\n"));
    //         }
    //     });
    //     return result.join("\n");
    // }
    // var tarea = document.getElementById('b64data');
    // function b64it() {
    //     if(typeof console !== 'undefined') console.log("onload", new Date());
    //     var wb = X.read(tarea.value, {type: 'base64',WTF:wtf_mode});
    //     process_wb(wb);
    // }
    // function process_wb(wb) {
    //     var output = "";
    //     switch(get_radio_value("format")) {
    //         case "json":
    //             output = JSON.stringify(to_json(wb), 2, 2);
    //             break;
    //         case "form":
    //             output = to_formulae(wb);
    //             break;
    //         default:
    //             output = JSON.stringify(to_json(wb), 2, 2); //output = to_csv(wb);
    //     }
    //     console.log(output)
    //     if(out.innerText === undefined) out.textContent = output;
    //     else out.innerText = output;
    //     if(typeof console !== 'undefined') console.log("output", new Date());
    // }
    // var drop = document.getElementById('drop');
    // function handleDrop(e) {
    //     e.stopPropagation();
    //     e.preventDefault();
    //     rABS = document.getElementsByName("userabs")[0].checked;
    //     use_worker = document.getElementsByName("useworker")[0].checked;
    //     var files = e.dataTransfer.files;
    //     var f = files[0];
    //     {
    //         var reader = new FileReader();
    //         var name = f.name;
    //         reader.onload = function(e) {
    //             if(typeof console !== 'undefined') console.log("onload", new Date(), rABS, use_worker);
    //             var data = e.target.result;
    //             if(use_worker) {
    //                 xw(data, process_wb);
    //             } else {
    //                 var wb;
    //                 if(rABS) {
    //                     wb = X.read(data, {type: 'binary'});
    //                 } else {
    //                     var arr = fixdata(data);
    //                     wb = X.read(btoa(arr), {type: 'base64'});
    //                 }
    //                 process_wb(wb);
    //             }
    //         };
    //         if(rABS) reader.readAsBinaryString(f);
    //         else reader.readAsArrayBuffer(f);
    //     }
    // }
    // function handleDragover(e) {
    //     e.stopPropagation();
    //     e.preventDefault();
    //     e.dataTransfer.dropEffect = 'copy';
    // }
    /*if(drop.addEventListener) {
     drop.addEventListener('dragenter', handleDragover, false);
     drop.addEventListener('dragover', handleDragover, false);
     drop.addEventListener('drop', handleDrop, false);
     }*/
    // var fileMobile = document.getElementById('xlf');
    // function handleFile(e) {
    //     rABS = document.getElementsByName("userabs")[0].checked;
    //     use_worker = document.getElementsByName("useworker")[0].checked;
    //     var files = e.target.files;
    //     console.log(files)

    //     var f = files[0];
    //     {
    //         var reader = new FileReader();
    //         var name = f.name;
    //         reader.onload = function(e) {
    //             if(typeof console !== 'undefined') console.log("onload", new Date(), rABS, use_worker);
    //             var data = e.target.result;
    //             if(use_worker) {
    //                 xw(data, process_wb);
    //             } else {
    //                 var wb;
    //                 if(rABS) {
    //                     wb = X.read(data, {type: 'binary'});
    //                 } else {
    //                     var arr = fixdata(data);
    //                     wb = X.read(btoa(arr), {type: 'base64'});
    //                 }
    //                 process_wb(wb);
    //             }
    //         };
    //         if(rABS) reader.readAsBinaryString(f);
    //         else reader.readAsArrayBuffer(f);
    //     }
    // }
    // if(fileMobile.addEventListener) fileMobile.addEventListener('change', handleFile, false);