const TTS = {
    data: { Name: `TTS`, Small: ``} ,
    url   : "/TTS",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Asterisk/TTS/Views/All.html',
            controller: 'TTSCtrl'
        }
    }
};
const TTSNew = {
    data: { Name: `TTS`, Small: ``} ,
    url   : "/TTSNew",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Asterisk/TTS/Views/New.html',
            controller: 'TTSNewCtrl'
        }
    }
};
const TTSEdit = {
    data: { Name: `TTS`, Small: ``} ,
    url   : "/TTSEdit/{ttsID:[0-9]{1,10}}",
    views : {
        "viewA": {
            templateUrl: Gulp + 'Asterisk/TTS/Views/Edit.html',
            controller: 'TTSEditCtrl'
        }
    }
};