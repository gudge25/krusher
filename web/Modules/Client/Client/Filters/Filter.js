/*
1 -  есть ANSWER + Callincard + comments = успешный(синих)
2- все другое что имеет CAllincard с любым статусом и без коментария (оранжевое)
3- на прозвон(прозрачный)
4- отличие в длине номера +- 1 (желтый)
5 - хлам - отличие больше чем +-1 и не соответствует региону
NULL - не попал не по одни условия

*/
var rgba =1;  //OPACITY
//Status
/*crmUA.filter('ClientStatus', function() {
    return function(input) {
        switch (input){
            case 1        : { input = { "status" : "Дозвон Успешный",       "color" : "rgba(0,128,0,"+rgba+");" };         break; } //green
            case 2        : { input = { "status" : "Дозвон Неуспешный",     "color" : "rgba(0,0,255,"+rgba+");" };         break; } //blue //"rgba(255,165,0,"+rgba+")" };        break; } //orange
            case 3        : { input = { "status" : "Прозвон",               "color" : "rgba(0,0,0,"+rgba+")" };            break; } //black
            case 4        : { input = { "status" : "Номер на проверку",     "color" : "rgba(255,255,0,"+rgba+")" };        break; } //yellow
            case 5        : { input = { "status" : "Хлам",                  "color" : "rgba(255,0,0,"+rgba+")" };          break; } //red
            default       : { input = { "status" : "Нет условия", "color" : "rgba(128,128,128,"+rgba+")" };      break; } //grey
        }
        return input;
    };
});*/

crmUA.filter('ClientStatus', $filter => {
    return input => {
        input = String(input);
        let res;
        switch (input){
            case "101"        : { res = { "status" : $filter('translate')('ringing')            , "color" : "rgba(0,117,176,"+rgba+")" };   break; } //dark blue
            case "102"        : { res = { "status" : $filter('translate')('numberCheck')        , "color" : "rgba(243,156,1,"+rgba+")" };   break; } //yellow
            case "103"        : { res = { "status" : $filter('translate')('trash')              , "color" : "rgba(255,0,0,"+rgba+")" };     break; } //red
            case "201"        : { res = { "status" : $filter('translate')('answeredComment')    , "color" : "rgba(0,166,90,"+rgba+")" };    break; } //grey
            case "202"        : { res = { "status" : $filter('translate')('answer')             , "color" : "rgba(0,166,90,"+rgba+")" };    break; } //grey
            case "203"        : { res = { "status" : $filter('translate')('didNotAnswer')       , "color" : "rgba(255,0,0,"+rgba+")" };     break; } //grey
            case "204"        : { res = { "status" : $filter('translate')('busy')               , "color" : "rgba(0,192,239,"+rgba+")" };   break; } //grey
            case "205"        : { res = { "status" : $filter('translate')('notSuccessful')      , "color" : "rgba(243,156,1,"+rgba+")" };   break; } //grey
            case "206"        : { res = { "status" : $filter('translate')('notRinging')         , "color" : "rgba(243,156,1,"+rgba+")" };   break; } //grey
            case "401"        : { res = { "status" : $filter('translate')('analyst')            , "color" : "rgba(128,128,128,"+rgba+")" }; break; } //grey
            case "402"        : { res = { "status" : $filter('translate')('mediator')           , "color" : "rgba(128,128,128,"+rgba+")" }; break; } //grey
            case "403"        : { res = { "status" : $filter('translate')('perspective')        , "color" : "rgba(128,128,128,"+rgba+")" }; break; } //grey
            case "404"        : { res = { "status" : $filter('translate')('press')              , "color" : "rgba(128,128,128,"+rgba+")" }; break; } //grey
            case "405"        : { res = { "status" : $filter('translate')('partner')            , "color" : "rgba(128,128,128,"+rgba+")" }; break; } //grey
            case "406"        : { res = { "status" : $filter('translate')('investor')           , "color" : "rgba(128,128,128,"+rgba+")" }; break; } //grey
            case "407"        : { res = { "status" : $filter('translate')('integrator')         , "color" : "rgba(128,128,128,"+rgba+")" }; break; } //grey
            case "408"        : { res = { "status" : $filter('translate')('client')             , "color" : "rgba(128,128,128,"+rgba+")" }; break; } //grey
            case "409"        : { res = { "status" : $filter('translate')('competitor')         , "color" : "rgba(128,128,128,"+rgba+")" }; break; } //grey
            case "410"        : { res = { "status" : $filter('translate')('other')              , "color" : "rgba(128,128,128,"+rgba+")" }; break; } //grey
            case "Клиентов"   : { res = { "status" : $filter('translate')('clients')            , "color" : "rgba(128,128,128,"+rgba+")" }; break; } //grey
            case "Тел.Доп"    : { res = { "status" : $filter('translate')('addedPhone')         , "color" : "rgba(128,128,128,"+rgba+")" }; break; } //grey
            case "Телефон"    : { res = { "status" : $filter('translate')('phone')              , "color" : "rgba(128,128,128,"+rgba+")" }; break; } //grey
            case "Анкета"     : { res = { "status" : $filter('translate')('form')               , "color" : "rgba(128,128,128,"+rgba+")" }; break; } //grey
            case "Контакт"    : { res = { "status" : $filter('translate')('contact')            , "color" : "rgba(128,128,128,"+rgba+")" }; break; } //grey
            case "Сделка"     : { res = { "status" : $filter('translate')('deal')               , "color" : "rgba(128,128,128,"+rgba+")" }; break; } //grey
            case "Счет"       : { res = { "status" : $filter('translate')('account')            , "color" : "rgba(128,128,128,"+rgba+")" }; break; } //grey
            case "Платеж"     : { res = { "status" : $filter('translate')('payment')            , "color" : "rgba(128,128,128,"+rgba+")" }; break; } //grey
            case "QtyClients" : { res = { "status" : $filter('translate')('totalContacts')      , "color" : "rgba(128,128,128,"+rgba+")" }; break; } //grey
            case null         : { res = { "status" : "-"                                        , "color" : "rgba(128,128,128,"+rgba+")" }; break; } //grey
            case "нет"        : { res = { "status" : $filter('translate')('no')                 , "color" : "rgba(128,128,128,"+rgba+")" }; break; } //grey
            case "топ 10"     : { res = { "status" : $filter('translate')('top10')              , "color" : "rgba(128,128,128,"+rgba+")" }; break; } //grey
            default           : { res = { "status" : input                                      , "color" : "rgba(128,128,128,"+rgba+")" }; break; } //grey
            //default         : { res = { "status" : "Нет условия", "color" : "rgba(128,128,128,"+rgba+")" };      break; } //grey
        }
        return res;
    };
});


// crmUA.filter('StatusName', $filter => {
//     return input => {
//         let res;
//         switch (input){
//             case "Summary"        : { res = $filter('translate')('synopsis');   break; }
//             case "ccStatus"       : { res = $filter('translate')('callingcar'); break; }
//             case "clStatus"       : { res = $filter('translate')('clients');    break; }
//             case "emName"         : { res = $filter('translate')('employee');   break; }
//             case "regName"        : { res = $filter('translate')('regions');    break; }
//             case "tagName"        : { res = $filter('translate')('tag');        break; }
//             case "1"              : { res = $filter('translate')('synopsis');   break; }
//             case "3"              : { res = $filter('translate')('employee');   break; }
//             case "2"              : { res = $filter('translate')('regions');    break; }
//             case "4"              : { res = $filter('translate')('clients');    break; }
//             default               : { res = input;          break; }
//         }
//         return res;
//     };
// });

//CallType
crmUA.filter('Person', () => {
    return input => {
        return input ? 'Физ.лицо' : 'Юр.лицо';
    };
});