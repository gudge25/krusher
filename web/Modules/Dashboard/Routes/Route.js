const Dashboard = {
	data: { Name: `controlPanel`, Small: `information`} ,
	url   : "/Dashboard",
	views: {
    	viewA: {
    		component : "dashboardCtrl"
    	}

  	}
};

crmUA.component('dashboardCtrl', {
  bindings: {value: '<'},
  controller: DashboardCtrl,
  templateUrl: Gulp + 'Dashboard/Views/All.html',
});
