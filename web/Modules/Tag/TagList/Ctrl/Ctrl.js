crmUA.controller('crmTagListCtrl', function($scope, $filter) {
    $scope.manyAction =  new crmTagViewModel($scope, $filter);
    $scope.model = new crmTagModel('').postFind();

    $scope.manyAction.Find();
    // var wm = new Ventus.WindowManager();
    // var window = wm.createWindow({
    // 	title: 'A new window',
    // 	x: 50,
    // 	y: 50,
    // 	width: 400,
    // 	height: 250
    // });
    // window.open();
    // var element = document.getElementById('wm1');
    // wm.createWindow.fromElement(element, {
    // 	title: 'My App',
    // 	width: 330,
    // 	height: 400,
    // 	x: 670,
    // 	y: 60
    // });
    // window = wm.createWindow({
    // 	title: 'A new window',
    // 	events: {
    // 		open: function() {
    // 			console.log('The window was open');
    // 		},

    // 		closed: function() {
    // 			this.destroy();
    // 		}
    // 	}
    // });
    // window = wm.createWindow({
    // 	title: 'A new window'
    // });

    // window.signals.on('open', function() {
    // 	console.log('The window was open');
    // });
});