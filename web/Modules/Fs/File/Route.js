var migration = {
    data: { Name: `import`, Small: ``} ,
    url         : "/fsImport",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Fs/File/Views/import.html',
            controller  : 'FsCtrl'
        }
    }
};

var fsTemplate ={
    data: { Name: `templates`, Small: ``} ,
    url         : "/fsTemplate",
    views : {
        "viewA" : {
            templateUrl : Gulp + 'Fs/File/Views/TemplateView.html',
            controller  : 'fsTemplateCtrl'
        }
    }
};