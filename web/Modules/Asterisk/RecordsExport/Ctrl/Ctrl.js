crmUA.controller('RecordsExportCtrl', function($scope, $filter, $translate, $translatePartialLoader,$rootScope) {
    $scope.manyAction =  new RecordsExportViewModel($scope,$filter,$translate,$rootScope);
	$scope.model = new ccRecordsModel('').postFind();
    $scope.manyAction.Find();




    function extractDomain(url) {
        var domain;
        //find & remove protocol (http, ftp, etc.) and get domain
        if (url.indexOf("://") > -1) {
            domain = url.split('/')[2];
        } else {
            domain = url.split('/')[0];
        }
        //find & remove port number
        domain = domain.split(':')[0];
        let dom = domain.split('.');
        if(dom.length == 3)
            domain = `.${dom[1]}.${dom[2]}`;
        return domain;
    }

    $scope.URL = e => {
        e.exDomain = extractDomain(window.location.hostname);
        //return `/download/${e.link}`;
        return `ftp://u208891:wCpo7ocWqEskM9Iz@u208891.your-storagebox.de/${e.link}`;
    };
 });