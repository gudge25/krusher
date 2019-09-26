const questions = {
    url: "/questions/:clID",
    views: {
        "viewA": {
            templateUrl: Gulp + 'Questions/Questions/Views/Questions.html',
            controller: 'fmQuestionsCtrl'
        }
    }
};
const questions2 = {
    url: "/questions2/:clID",
    views: {
        "viewA": {
            templateUrl: Gulp + 'Questions/Questions/Views/Questions2.html',
            controller: 'fmQuestions2Ctrl'
        }
    }
};
const questionsAll = {
    url: "/questionsAll",
    views: {
        "viewA": {
            templateUrl: Gulp + 'Questions/Questions/Views/QuestionsAll.html',
            controller: 'fmQuestionsAllCtrl'
        }
    }
};
const questionsEdit = {

    url: "/questionsEdit/:qID",
    views: {
        "viewA": {
            templateUrl: Gulp + 'Questions/Questions/Views/QuestionsEdit.html',
            controller: 'fmQuestionsEditCtrl'
        }
    }
};
const questionsItemsAll = {
    url: "/questionsItemsAll/:qID",
    views: {
        "viewA": {
            templateUrl: Gulp + 'Questions/Questions/Views/QuestionsItemsAll.html',
            controller: 'fmQuestionsItemsAllCtrl'
        }
    }
};

