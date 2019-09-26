class DashboardViewModel extends BaseViewModel {
      constructor($scope,$filter, $translate,$rootScope)
    {
        super($scope,$filter,'', $translate,$rootScope);

		$scope.showStatistic = {};
		$scope.cl_status	 = {};
		$scope.showBtnStat 	 = true;

		$scope.drowGraph = () => {
			new ccContactDashboardSrv().getAll( cb => {
						//cb = [{"ID":1,"Name":"TotalCallsAutocall","QtyCalls":50,"Percent":1},{"ID":1,"Name":"AnsweredAutocall","QtyCalls":6,"Percent":0.12},{"ID":1,"Name":"NoAnsweredAutocall","QtyCalls":44,"Percent":0.88},{"ID":1,"Name":"MissedAutocall","QtyCalls":0,"Percent":0},{"ID":5,"Name":"10","QtyCalls":4,"Percent":null},{"ID":5,"Name":"11","QtyCalls":46,"Percent":null},{"ID":6,"Name":"Vtiger Контрагенты","QtyCalls":247,"Percent":0.57},{"ID":6,"Name":"Autocall.csv","QtyCalls":9,"Percent":0.56},{"ID":2,"Name":"TotalCallsAll","QtyCalls":71,"Percent":1},{"ID":2,"Name":"AnsweredAll","QtyCalls":22,"Percent":0.31},{"ID":2,"Name":"NoAnsweredAll","QtyCalls":49,"Percent":0.69},{"ID":2,"Name":"MissedAll","QtyCalls":0,"Percent":0},{"ID":3,"Name":"8","QtyCalls":5,"Percent":null},{"ID":3,"Name":"9","QtyCalls":13,"Percent":null},{"ID":3,"Name":"10","QtyCalls":4,"Percent":null},{"ID":3,"Name":"11","QtyCalls":49,"Percent":null}]
						$scope.Dashboard 	= cb;
						$scope.Lable 		= ["0:00", "1:00", "2:00", "3:00", "4:00", "5:00", "6:00", "7:00", "8:00", "9:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00", "21:00", "22:00", "23:00"];
						$scope.Data 		= [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
						$scope.Data2 		= [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
						$scope.BasePersent 	= [];
						$scope.AutoQty 		= [];
						$scope.AllQty 		= [];
					    angular.forEach(cb, todo => {
					    	if(todo.ID == 1)  $scope.AutoQty.push(todo);
					        if(todo.ID == 2)  { $scope.AllQty.push(todo); }
					        if(todo.ID == 3)  $scope.Data2[todo.Name]=todo.QtyCalls;
					        if(todo.ID == 5)  $scope.Data[todo.Name]=todo.QtyCalls;
					        if(todo.ID == 6)  {$scope.BasePersent.push(todo);}
					    });
					    $scope.AllQty  = _.groupBy($scope.AllQty, 'Name');
					    $scope.AutoQty = _.groupBy($scope.AutoQty, 'Name');
					 //    new fsBasesSaBDSrv().getAll( cb =>{
					 //    	//cb = [{"dbName":"Ukraine","ffID":30,"ffName":"Vtiger Контрагенты"},{"dbName":"Ukraine","ffID":81,"ffName":"Test_base.csv"},{"dbName":"Ukraine","ffID":84,"ffName":"Untitled 1.csv"},{"dbName":"Ukraine","ffID":90,"ffName":"Autocall.csv"}];
					 //    	///cb.unshift( {ffID: 0, ffName: "[Default]", isActive:true, dbName : "Ukraine"});
					 //    	cb.forEach(item => {
					 //    		item.Percent = 0;
					 //    		$scope.BasePersent.some(e => {
					 //    			if (e.Name === item.ffName) {
					 //    				item.Percent 	= e.Percent  	? e.Percent : 0;
					 //    				item.QtyCalls 	= e.QtyCalls 	? e.QtyCalls : 0;
					 //    				return;
					 //    			}
					 //    		});
					 //    	});

						// 	$scope.BasesSaBDGroup = _.groupBy(cb, 'dbName');
						// 	//console.log($scope.BasesSaBDGroup)
						// 	for (var key in $scope.BasesSaBDGroup){
						// 		$scope.showStatistic[key] = [];
						// 		$scope.cl_status[key] 	  = [];
						// 		$scope.BasesSaBDGroup[key].forEach( (item,index) => {
						// 			//item.Percent = item.Percen ? item.Percen : 0;
						// 			$scope.showStatistic[key][index]				= {};
						// 			$scope.showStatistic[key][index].show			= false;
						// 			$scope.showStatistic[key][index].showInfo    	= false;
						// 			$scope.showStatistic[key][index].showStatus    	= false;
						// 			$scope.showStatistic[key][index].showDocs    	= false;
						// 			$scope.cl_status[key][index] 	 				= [];
						// 		});
						// 	}
						// 	$scope.$apply();
						// });

						$scope.BasePersent.forEach( (item,index) => {
 							$scope.showStatistic[index]				= {};
							$scope.showStatistic[index].show			= false;
							$scope.showStatistic[index].showInfo    	= false;
							$scope.showStatistic[index].showStatus    	= false;
							$scope.showStatistic[index].showDocs    	= false;
 						});


			            $scope.mapData 	= Object.entries($scope.Data).map( value => parseInt(value[1]) );
						$scope.mapData2	= Object.entries($scope.Data2).map( value => parseInt(value[1]) );
						$scope.chartConfig5.series[1].data 		= $scope.mapData;
						$scope.chartConfig5.series[0].data 		= $scope.mapData2;
						$scope.chartConfig5.xAxis.categories	= $scope.Lable;
						$scope.$apply();
			});
		};
		$scope.drowGraph();


		//Show all statistic
		$scope.getAllStat = () => {
			if ($scope.btnWasPushed !== undefined && $scope.btnWasPushed == true) {
				for (var key in $scope.showStatistic) {
					$scope.showStatistic[key].forEach( item => item.show = false);
				}
				$scope.btnWasPushed = false;
				return;
			} else {
				$scope.btnWasPushed = true;
				for (var key in $scope.BasesSaBDGroup){
					$scope.BasesSaBDGroup[key].forEach( (item,index) => {
						$scope.GetStatus(item,key,index);
	            	});
				}
			}
		};

		//show statistic by base
		$scope.GetStatus = (base,key,index,showStatus) => {
			//console.log(base)
			if(base)
			if(base.data1)
			new fsFileSrv().get(base.data1, cb => {
				$scope.BasePersent[index].cl_status = cb;
				//$scope.cl_status[key][index] = cb;
				if(showStatus === undefined) $scope.showStatistic[index].show = true;
                //show Status items (status,info,docs)
                cb.forEach( value => {
                	if ((value.FilterID==1001 && value.Qty>0) || (value.FilterID==1002 && value.Qty>0))   $scope.showStatistic[index].showInfo   = true;
                	if ((value.FilterID==1003 && value.Qty>0) || (value.FilterID==1004 && value.Qty>0))   $scope.showStatistic[index].showStatus = true;
                	if (value.FilterID < 100  && value.FilterID > 0 && value.Qty>0)                       $scope.showStatistic[index].showDocs   = true;
                });
                $scope.$apply();
            });
		};

	 	$scope.trans = () =>{
			$translate(['numberOfCalls', 'hours', 'AllCall', 'AutoCall']).then(a => {
				$scope.chartConfig5.series[1].name = `${a.AutoCall}`; //: ${a.hours}
				$scope.chartConfig5.series[0].name = `${a.AllCall}`; //: ${a.hours}
				$scope.chartConfig5.yAxis.title.text =	a.numberOfCalls;
			});
		};

		$rootScope.$on('$translateChangeSuccess', () => {
	        $scope.trans();
	    });
		$scope.trans();


		$scope.chartConfig5 = {
			options: {
				chart: {
					renderTo: 'chart',
					type: 'areaspline',
				},
			},
			series:  [	{"name": null, "data": $scope.mapData }	, {"name": null, "data": $scope.mapData2 }],
			title: {
					text: ''
			},
			credits: {
					enabled: true
			},
			loading: false,
			xAxis: {
						categories: $scope.Lable ,
						tickInterval: 1
					},
			yAxis: {
						title: { text: 'Количество звонков' },
						min: 0,
						minorGridLineWidth: 0,
						gridLineWidth: 0,
						alternateGridColor: null
					},

			plotOptions: {
		        series: {
		            fillOpacity: 0.1
		        }
		    }

		};
    }
}