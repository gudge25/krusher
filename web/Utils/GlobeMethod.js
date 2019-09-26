lookUp = (api, id) => {
     let s = '';
     if(id !== undefined) s = '/'+ id;
     let method = $.ajax({
         url : api + s,
         async : false
     });
    return method.responseJSON;
};

ClearAuth = () => {
    if(eventSource) eventSource.close();
    if(ws) ws.loguot();
    USERNAME = "null";
    PASSWORD = "null";
    localStorage.removeItem('Auth');
    localStorage.removeItem('Pages');
    localStorage.removeItem('wsOptons');
    localStorage.removeItem('ccCallingCardModel');

};

GoTOAuth = () => { if( window.location.hash != `#!/Register`) window.location = "/#!/login"; };

alert = (text,title,type) => {
    if(!type) type = "info";
    //if(!title) title = "Ошибка , заполнения!";
     title = `Уведомление`;
    swal({
        title: `${title}`,
        text: `${text}`,
        //type: `${type}`,
        // showCancelButton: false,
        // confirmButtonText: 'Закрыть',
        // cancelButtonText: 'Закрыть',
        button: 'Закрыть',
        // showLoaderOnConfirm: true,
        allowOutsideClick: false,
        icon: "warning",
        //timer: 10000
    });
};

// ucs-2 string to base64 encoded ascii
function utoa(str) {
    return window.btoa(unescape(encodeURIComponent(str)));
}
// base64 encoded ascii to ucs-2 string
function atou(str) {
    return decodeURIComponent(escape(window.atob(str)));
}

AjaxSettings = () => {
    $.ajaxSetup({
        headers: { "Authorization": `Basic ${utoa(USERNAME + ":" + PASSWORD)}` },
        async: true,
        type: `GET`,
        dataType: `json`,
        contentType: `application/json; charset=utf-8`,
        beforeSend: (jqXHR, settings) => { jqXHR.url = settings.url; },
        xhrFields: { withCredentials: true },
        crossDomain: true,
        error: (data, status, xhr) => {
            switch(data.status){
                case 404:
                    console.log("404 page not found");
                    //alert(`${data.url}`,`Ошибка 404, page not found!`,`warning`);
                    break;
                default:
                    {
                        let url     = data.url;
                        if( url.search("api") !== -1 && url != `/api/ast/update/start.php`) {
                            let a;
                            if(IsJsonString(data.responseText)) a = JSON.parse(data.responseText); else a = data.responseText;
                            if(a) if(a.message) a = a.message;
                            console.log(a);
                            let message = a.substring(a.lastIndexOf(":") + 1, a.length).trim();
                            let error   = a.error ? a.error : null ; //`Авторизация`;
                            alert(`${message}`,`${error}! ${url}`,`info`);
                        }
                    }
            }
        }
    });
};
AjaxSettings();

alerts = a => {
    if(a) {
        let message = JSON.parse(a).message.split(":");
        if(1 in message) alert(message[1]); }
};

dataFilterModel = (data,Model) => {
            let result;
            let arr =[];

            if(data) {
                if (data != '[]' && Model && IsJsonString(data)) {
                    data = JSON.parse(data);
                    if (0 in data)
                        data.forEach( e => {
                            if( new Model(e).get() ) arr.push( new Model(e).get() );
                        });
                    else
                        arr = new Model(data).get();

                    result = JSON.stringify(arr);
                }
                else result = data;

                if (data.data && Model) result = JSON.stringify(data.data);
            }
            else
                result = true;

    return result;
};

function isInteger(num){
    num = num % 3;
    return (num ^ 0)=== num;
}

function isFloat(x) { return !!(x % 1); }


IsJsonString = str => {
    try {
        JSON.parse(str);
    } catch (e) {
        return false;
    }
    return true;
};

function isBoolean(n){
    return !!n===n;
}

const monthNames =  {
    "en" : {
        month_names: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
        month_names_short: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
    }
};

goToDoc = (id,type,scope) => {

    //.dcID,e.dctType
    // scope.MenuSearchLoad =true;
    // if (type === "Client")  { scope.MenuSearchLoad =false; scope.$apply(); window.location.hash = `!#/clientPreView/${id}`; return;}
    // if (type === "Product") { scope.MenuSearchLoad =false; scope.$apply(); window.location.hash = `!#/ProductEdit/${id}`;   return;}

    // getDocInfo = id => {
    //         new crmClientSrv().getFind({ clID : id },cb => {
    //             if( !_.isEmpty(cb) ) { scope.MenuSearchLoad =false; scope.$apply(); window.location.hash = `!#/clientPreView/${id}`; }
    //             else new dcDocsClientSrv().getFind({ dcID : id },cb => callBack(cb,id));
    //         });
    // };
    // getDocInfo(id);

    // callBack = (cb,id) => {
    //         cb = cb[0];
    //         if( _.isEmpty(cb) )  { scope.MenuSearchLoad =false; scope.$apply(); alert(`ничего не найдено`,`Ошибка, поиска!`); }
    //         else
    //         {   let data = FactDocsTypesRun.name;
    //             data.data.forEach( e => {
    //                 console.log(`${e.dctID} === ${cb.dctID}`);
    //                 if(e.dctID === cb.dctID)
    //                     for (var j in dcTypesUrls) if(dcTypesUrls[j].dctID === e.dctID) window.location = `!#${dcTypesUrls[j].url}${id}`;
    //             });
    //             scope.MenuSearchLoad =false; scope.$apply();
    //         }
    // };

    let dcTypesUrls = [
        {"dctID":1,"dctName":"Контакт","url":"/Contract/"},
        {"dctID":2,"dctName":"Сделка","url":"/DealEdit/"},
        {"dctID":3,"dctName":"ПЛ","url":"/Payment/"},
        {"dctID":4,"dctName":"Анкета","url":"/form/"},
        {"dctID":5,"dctName":"Счет","url":"/Invoice/"},
        {"dctID":6,"dctName":"Платеж","url":"/Payment/"},
        {"dctID":7,"dctName":"Договор","url":"/Contract/"},
        {"dctID":8,"dctName":"Акт В/Р","url":"/Completion/"}
    ];

    dcTypesUrls.forEach( e => {
        if(e.dctID == id.dctType) window.location = `#!${e.url}${id.dcID}`;
    });
};

unflatten = ( array, parent, tree ) => {
    tree = typeof tree !== 'undefined' ? tree : [];
    parent = typeof parent !== 'undefined' ? parent : { pctID: null };
    var children = _.filter( array, child => { return child.ParentID == parent.pctID; });
    if( !_.isEmpty( children )  ){
        if( parent.pctID === null ){
            tree = children;
        }else{
            parent.children = children;
        }
        _.each( children, child => { unflatten( array, child ); } );
    }
    return tree;
};

function notify(a,body,clID){
    //console.log(Notification.permission);
    if(a && body)
    if (Notification.permission !== "granted") {
        Notification.requestPermission();
    }
    else {
        let notification = new Notification(a, {
            body: body, //`${b.body}, Source : ${b.source},Client: ${b.clName}`,
            icon: '/images/fa.png',
            //title: `Source : ${b.source}`,
            tag : "dial",
            renotify: true,
            silent: false,

            //actions: [{action: "get", title: "Get now."}]
        });
        notification.onclick  = () => {
                //console.log('Notification clicked.');
                if(clID) window.location.hash = '#/clientPreView/' + clID;
        };
    }
}

function clearnum(a){
    //Bug when num with +
    let cn = a.toString();
    cn = cn.replace(/\D/g, "");
    if (cn.length == 7 && cn.substring(0,1) != 0) cn = `044${cn}`;
    if (cn.length == 9 && cn.substring(0,1) != 0) cn = `380${cn}`;
    if (cn.length == 10 && cn.substring(0,1) == 0) cn = `38${cn}`;
    //ru
    if (cn.length == 10 && cn.substring(0,1) != 0) cn = `7${cn}`;
    if (cn.length == 11 && cn.substring(0,1) == 8) cn = `7${cn.substr(cn.length - 10)}`;
    return cn;
}