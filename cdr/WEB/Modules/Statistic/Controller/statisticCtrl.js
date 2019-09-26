function CDR($scope,$timeout,$filter,localStorageService,orderByFilter) {
	//Get local Storage
		$scope.GetPhone = function()
			{
				$scope.a = angular.fromJson(localStorageService.get('phone_out'));
				delete $scope.a_parse;
				angular.forEach($scope.a , (todo,key) => {
					$scope.a_parse = $scope.a_parse + '&sip_out['+key+']=' + todo.Phone
				});
			};	$scope.GetPhone();

	//DEll local Storage
		$scope.DellPhone = function(ID)
			{
			 $scope.a.splice(ID, 1);
			 localStorageService.add('phone_out',angular.toJson($scope.a,true));
			 $scope.GetPhone();
			 $scope.load_d();
			};
	
		$scope.cdr_filter2='';
	//CDR Limit

        $scope.limit = function(){
			$scope.cdr_limit = 30;
			//total and avarege summ
			$scope.total_sum_duration  		= 0;
			$scope.total_sum_billsec		= 0;
			$scope.total_sum_servicelevel 	= 0;
			angular.forEach($scope.cdr, todo => {
				if(todo.duration) $scope.total_sum_duration 			+= Number(todo.duration);
				if(todo.billsec) $scope.total_sum_billsec 				+= Number(todo.billsec);
				if(todo.servicelevel) $scope.total_sum_servicelevel 	+= Number(todo.servicelevel);
			}); 
			$scope.total_sum_duration 		= $scope.total_sum_duration.toFixed(2);
			$scope.total_sum_billsec 		= $scope.total_sum_billsec.toFixed(2);
			$scope.total_sum_servicelevel 	= $scope.total_sum_servicelevel.toFixed(2);
			
			if($scope.total_sum_duration != 0 ) 	$scope.total_avr_duration 		=   ($scope.total_sum_duration / $scope.cdr.length).toFixed(2);			else $scope.total_avr_duration 	= (0).toFixed(2);
			if($scope.total_sum_billsec != 0) 		$scope.total_avr_billsec 		=   ($scope.total_sum_billsec / $scope.cdr.length).toFixed(2);			else $scope.total_avr_billsec 	= (0).toFixed(2);
			if($scope.total_sum_servicelevel != 0 ) $scope.total_avr_servicelevel 	=   ($scope.total_sum_servicelevel / $scope.cdr.length).toFixed(2);	else $scope.total_avr_servicelevel 	= (0).toFixed(2);
			$scope.$apply();
		};

		$scope.canLoad 	 = true;

		$scope.loadMore  = function(){
                        $scope.cdr_limit = $scope.cdr_limit + 6;
        };

	//Ger RecordsFile url
		new recordSrv().getAll( cb => { $scope.RecordsFile = cb; $scope.$apply();});

	//Set Graf var
 		$scope.Data_Graphs1 	=  $scope.Data_Graphs2 = $scope.Data_Graphs3 = $scope.categories3 = $scope.categories = $scope.categories2 = [];

	//DATAPIKER
        $scope.untilDate 	= new Date().toISOString();  //.addDays(1)
        $scope.fromDate 	= new Date().addDays(0).toISOString(); //.last().months().toISOString();

	//Обновления графика при клике на фильтры
	$scope.Group_for_graph = function(ID){
		//Group by Year
		$scope.all_test = _.groupBy(ID, item => {  return item.calldate.substring(0,4); 	});
		$scope.graph_year_key 	= [];	
		$scope.graph_year_value = [];
		angular.forEach( $scope.all_test, (value,key) => {
		 		$scope.graph_year_key.push(key); 
		 		$scope.graph_year_value.push(value.length); 
		}); 
		$scope.chartConfig.series[0].data 	= $scope.graph_year_value;
		$scope.chartConfig.xAxis.categories	= $scope.graph_year_key;
		
		//Group by Month
		$scope.all_test = _.groupBy(ID, item => {  return item.calldate.substring(0,7); 	});
		$scope.graph_month_key 		= [];
		$scope.graph_month_value 	= [];
		angular.forEach( $scope.all_test, function(value,key)   {
		 		$scope.graph_month_key.push($filter('date')(key, 'yyyy MMM')); 
		 		$scope.graph_month_value.push(value.length); 
		}); 
 		$scope.chartConfig2.series[0].data 		= $scope.graph_month_value;
		$scope.chartConfig2.xAxis.categories	= $scope.graph_month_key;

		//Group by Day
		$scope.all_test = _.groupBy(ID, function(item) {  return item.calldate.substring(0,10); });	 
		$scope.graph_day_key 	= [];
		$scope.graph_day_value 	= [];
		angular.forEach( $scope.all_test, function(value,key)   {
		 		$scope.graph_day_key.push($filter('date')(key, 'MMM dd')); 
		 		$scope.graph_day_value.push(value.length); 
		}); 
 		$scope.chartConfig3.series[0].data 		= $scope.graph_day_value;
		$scope.chartConfig3.xAxis.categories	= $scope.graph_day_key;
 		
		//Group by Hours
		$scope.all_test = _.groupBy(ID, function(item) {  return item.calldate.substring(0,13); });
		$scope.graph_hour_key 	= [];
		$scope.graph_hour_value = [];
		angular.forEach( $scope.all_test, function(value,key)   {
		 		$scope.graph_hour_key.push(Date.parse(key).toString('yyyy MM d HH:mm') ); 
		 		$scope.graph_hour_value.push(value.length); 
		}); 
 		$scope.chartConfig5.series[0].data 		= $scope.graph_hour_value;
		$scope.chartConfig5.xAxis.categories	= $scope.graph_hour_key;
		
	};
 	 
//GRAPHICS
		$scope.width= $("#wrapper").width();
		$scope.chartConfig = {
			options: {
				chart: {
					renderTo: 'chart',
					type: 'areaspline'
				}
			},
			series:  [	{"name": "года", color: 'blue', "data": $scope.Data_Graphs1 }	],
			title: {
					text: ''
			},
			credits: {
					enabled: true
			},
			loading: false,
			xAxis: {
						categories: $scope.categories
					},
					 yAxis: {
						title: { text: 'Количество' },
						min: 0,
						minorGridLineWidth: 0,
						gridLineWidth: 0,
						alternateGridColor: null
					}
		};

		$scope.chartConfig2 = {
			options: {
				chart: {
					type: 'areaspline'
				}
			},
			series:  [	{"name": "месяцы", color: 'orange', "data": 	$scope.Data_Graphs2 }	],
			title: {
				text: ''
			},
			credits: {
				enabled: true
			},
			loading: false,
			xAxis: {
					categories: $scope.categories2
					},
					 yAxis: {
						title: { text: 'Количество' },
						min: 0,
						minorGridLineWidth: 0,
						gridLineWidth: 0,
						alternateGridColor: null
					}
		};
	 
		$scope.chartConfig3 = {
			options: {
				chart: {
					type: 'areaspline'
				},
			plotOptions: {
							pie: {
								allowPointSelect: true,
								cursor: 'pointer',
								dataLabels: {
									enabled: true,
									format: '{point.percentage:.1f} %',
									style: {
										color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
									}
								}
							},
							series: {
								point: {
											events: {
													  click: function() {
																if($scope.cdr_old !== undefined)$scope.cdr = $scope.cdr_old;
																$scope.cdr_old = angular.copy($scope.cdr);
																$scope.cdr_filter2 = Date.parse(this.category).toString('MM-dd');
																$scope.cdr = $filter('point')($scope.cdr, $scope.cdr_filter2);
																$scope.cdr_q2 = Date.parse(this.category).toString('MM-dd');
																$scope.limit();
																		}
													 }
								 }
							}
					}
			},
			series:  [	{"name": "дни", color: 'green', "data": 	$scope.Data_Graphs3 }	],
			title: {
				text: ''
			},
			credits: {
				enabled: true
			},
			loading: false,
			xAxis: {
					categories: $scope.categories3 ,
					tickInterval: 2
					},
			yAxis: {
						title: { text: 'Количество' },
						min: 0,
						minorGridLineWidth: 0,
						gridLineWidth: 0,
						alternateGridColor: null
					}
		};
	    
		$scope.chartConfig4 = {
			chart: {
				type: 'pie',
				options3d: {
					enabled: true,
					alpha: 45,
					beta: 0
				}
			},
			title: {
				text: ''
			},
			tooltip: {
				pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
			},
			plotOptions: {
				pie: {
					allowPointSelect: true,
					cursor: 'pointer',
					depth: 35,
					dataLabels: {
						enabled: true,
						format: '{point.name}'
					}
				}
			},
			series: [{
				type: 'pie',
				name: 'Всего звонков',
				data: [
					['Исходящие',  10],
					['Входящие',   10],
					['Внутренние',  10]
				],
				 point:{
					  events:{
						  click: function () {
							console.log(this.name);
							switch (this.name){
								case 'Внутренние': { $scope.cdr = $scope.local; 	$scope.$apply('cdr'); break; }
								case 'Исходящие' : { $scope.cdr = $scope.outgoing; 	$scope.$apply('cdr'); break; }
								case 'Входящие'	 : { $scope.cdr = $scope.incoming; 	$scope.$apply('cdr'); break; }
							}
							$timeout( function() { $scope.Group_for_graph($scope.cdr);	}, 10);
						  }
					  }
				  }
			}]
		};
		
		$scope.chartConfig5 = {
			options: {
				chart: {
					renderTo: 'chart',
					type: 'areaspline',

				},
				plotOptions: {
							series: {
								point: {
											events: {
													  click: function() {
																if($scope.cdr_old !== undefined)$scope.cdr = $scope.cdr_old;
																$scope.cdr_old = angular.copy($scope.cdr);
																$scope.cdr_filter2 = Date.parse(this.category).toString('yyyy-MM-dd HH:');
																$scope.cdr = $filter('point')($scope.cdr, $scope.cdr_filter2);
																$scope.$apply('cdr');
																$scope.cdr_q2 = Date.parse(this.category).toString('yyyy-MM-dd HH:');
																$scope.limit();
																		}
													 }
								 }
							}
				}
			},
			series:  [	{"name": "часы", color: 'brown', "data": $scope.Data_Graphs1 }	],
			title: {
					text: ''
			},
			credits: {
					enabled: true
			},
			loading: false,
			xAxis: {
						tickInterval: 20
					},
			yAxis: {
						title: { text: 'Количество' },
						min: 0,
						minorGridLineWidth: 0,
						gridLineWidth: 0,
						alternateGridColor: null
					}
		};
		
		$scope.src = function(ID){
			return $scope.RecordsFile +ID+ '.wav';
		};

	    //Media Player
	    $scope.Wav = function(ID ){    		 
			//Stop and play records
	    		if($scope.audio) $scope.audio.pause();
	    		if(ID == 'stop') delete $scope.play;
	    		else
	    		{ 	
                    $scope.audio = new Audio($scope.RecordsFile+ID+".wav");
                    $scope.audio.play();
                    $scope.play = ID;console.log($scope.audio);

                    $scope.audio.addEventListener('error',function(a){$timeout( function() { delete $scope.play;   console.log($scope.play)}, 200);});

                    $scope.audio.addEventListener('ended',function(){
                        console.log($scope.play);
                        $timeout( function() { delete $scope.play;   console.log($scope.play)}, 200);
                    });
				}
		};
		
		//Media Player Play All
		$scope.Wav_all = function(){
			var arr_wav_return = [];
			$scope.cdr = orderByFilter($scope.cdr , $scope.sort.column, $scope.sort.descending);
			angular.forEach($scope.cdr, function(todo)       {
								if(todo.recordingfile && todo.disposition == 'ANSWERED')
								{
									if(todo.dst == '~~s~~') { dst = $filter('fix_chan')(todo.lastdata, '/',2)  } else var dst = todo.dst;
									var dstchannel = $filter('fix_chan')(todo.dstchannel, '-',0); dstchannel = $filter('fix_chan')(dstchannel, 'SIP/',1);
									var disposition = $filter('status')(todo.disposition);
									var cdr_ret = { "Rec"			: todo.recordingfile,
													"ID"			: todo.uniqueid
												   };
									arr_wav_return.push(cdr_ret);
								}
							});
			 
			$scope.index = 0;
			if($scope.audio) { $scope.audio.pause();  delete $scope.play; }  

			$scope.event_audio = function(){
						if($scope.index < arr_wav_return.length) {
							$scope.audio = new Audio($scope.RecordsFile+arr_wav_return[$scope.index].ID+".wav");
							$scope.audio.play();		 
							$scope.play = arr_wav_return[$scope.index].ID;
							$scope.index += 1;
						} else {
							
							$scope.audio.removeEventListener('ended', $scope.event_audio(), false);
							$scope.audio.removeEventListener('error', $scope.event_audio(), false);
						}
					};
					$scope.audio = new Audio($scope.RecordsFile+arr_wav_return[$scope.index].ID+".wav");
					$scope.audio.play();		 
					$scope.play = arr_wav_return[$scope.index].ID;
					$scope.audio.addEventListener('ended',$scope.event_audio());
					$scope.audio.addEventListener('error',$scope.event_audio());
		};

	//LOAD DATA	 
	$scope.load = function(){
		//Loading start
		$scope.loading = true;
		$scope.fromDate = $filter('date')($scope.fromDate, 'yyyy-MM-ddT00:00:00');
		$scope.untilDate = $filter('date')($scope.untilDate, 'yyyy-MM-ddT23:59:59');

		new cdrSrv().get(`&sip=${$scope.sip}&from=${$scope.fromDate}&to=${$scope.untilDate}&limit=${$scope.cdr_limit}&sip_out=${$scope.a_parse}`, cb => {
			$scope.cdr = cb;
			//Summary
			$scope.incoming 	= [];
			$scope.outgoing 	= [];
			$scope.local 		= [];
			$scope.local202 	= [];
			
			//active calls
			$scope.cdr_active	= [];
			new activeSrv().getAll( cb => { $scope.cdr_active = cb; $scope.$apply();});

			$scope.all 	= angular.copy($scope.cdr);

			//Разделение между вх и исх и локалиными
			angular.forEach(cb, todo => {
				if((todo.src.length < 4 && todo.dst.length < 4 ) && todo.dcontext == 'office')
					$scope.local.push(todo);
				else
				{	if(todo.dcontext == 'incoming' || todo.src.length >= 7)	
						$scope.incoming.push(todo);
					else
						$scope.outgoing.push(todo);
				}
			});
		 
		 	//Incoming
		 	$scope.incoming_ans 	= [];
		 	$scope.incoming_noans 	= [];
		 	$scope.incoming_busy 	= [];
		 	$scope.incoming_fail 	= [];
		 	angular.forEach($scope.incoming, todo => {
		 		switch (todo.disposition){		
					case 'ANSWERED'	: { $scope.incoming_ans.push(todo); 	break; }
					case 'NO ANSWER': { $scope.incoming_noans.push(todo); 	break; }
					case 'BUSY'		: { $scope.incoming_busy.push(todo); 	break; }
					case 'FAILED'	: { $scope.incoming_fail.push(todo); 	break; }	 
				}
		 	});

		 	//Outgoing
		 	$scope.outgoing_ans 	= [];
		 	$scope.outgoing_noans 	= [];
		 	$scope.outgoing_busy 	= [];
		 	$scope.outgoing_fail 	= [];
		 	angular.forEach($scope.outgoing, todo => {
		 		switch (todo.disposition){		
					case 'ANSWERED'	: { $scope.outgoing_ans.push(todo); 	break; }
					case 'NO ANSWER': { $scope.outgoing_noans.push(todo); 	break; }
					case 'BUSY'		: { $scope.outgoing_busy.push(todo); 	break; }
					case 'FAILED'	: { $scope.outgoing_fail.push(todo); 	break; }	 
				}
		 	});
		 	
		 	//Local
		 	$scope.local_ans 	= [];
		 	$scope.local_noans 	= [];
		 	$scope.local_busy 	= [];
		 	$scope.local_fail 	= [];
		 	angular.forEach($scope.local, todo => {
		 		switch (todo.disposition){		
					case 'ANSWERED'	: { $scope.local_ans.push(todo); 	break; }
					case 'NO ANSWER': { $scope.local_noans.push(todo); 	break; }
					case 'BUSY'		: { $scope.local_busy.push(todo); 	break; }
					case 'FAILED'	: { $scope.local_fail.push(todo); 	break; }	 
				}
		 	});
		 	
		 	//All
		 	$scope.all_ans 		= [];
		 	$scope.all_noans 	= [];
		 	$scope.all_busy 	= [];
		 	$scope.all_fail 	= [];
		 	angular.forEach($scope.all, todo => {
		 		switch (todo.disposition){		
					case 'ANSWERED'	: { $scope.all_ans.push(todo); 		break; }
					case 'NO ANSWER': { $scope.all_noans.push(todo); 	break; }
					case 'BUSY'		: { $scope.all_busy.push(todo); 	break; }
					case 'FAILED'	: { $scope.all_fail.push(todo); 	break; }	 
				}
		 	});
			
			$scope.Group_for_graph($scope.cdr);
			$scope.chartConfig4.series[0].data[0] 		= $scope.outgoing.length;
			$scope.chartConfig4.series[0].data[1] 		= $scope.incoming.length;
			$scope.chartConfig4.series[0].data[2] 		= $scope.local.length;

			//Loading end
			$scope.loading = false;	
			$scope.limit();
		});

		//Количество статусов звонков
		$scope.cdr_count1 = [];
		angular.forEach( $scope.cdr, todo => {
			if(todo.disposition == 'ANSWERED') $scope.cdr_count1.push(todo)
        });			
	};	$scope.load();

	$scope.load_d = function(){
		if(typeof debounce === 'object' ) { $timeout.cancel(debounce);}
		debounce = $timeout( function() {$scope.load();}, 1000);
	};
	
	//GET COLUMNS NAME
	new cdrColumnSrv().getAll( cb => { $scope.cdr_column = cb; $scope.$apply();});
		 
	//ADD LOCAL STORAGE FOR OUT NUMBER
	$scope.AddtoLocalStorage = function(ID)
	{	$scope.total = [];
		var arrs = {
                        'Phone'     : ID,
						'Date'   	: new Date()
                    };
        if(localStorageService.get('phone_out') !== null){
               	var a = angular.fromJson(localStorageService.get('phone_out'));
               	angular.forEach(a, function(todo)       {
                       	$scope.total.push(todo);
                });
                $scope.total.push(arrs);
        } 
		else  $scope.total.push(arrs);                
        localStorageService.add('phone_out',angular.toJson($scope.total,true));
	};

	//Group number by day
	$scope.GroupNumBYDay = function(){
		$scope.GroupBySrc = _.groupBy($scope.cdr, function(item) {  return item.src ; });
		console.log($scope.GroupBySrc)
	};

	//Add Comment
	$scope.AddComment = function(ID){
		if(typeof debounce2 === 'object' ) { $timeout.cancel(debounce2);}
		debounce2 = $timeout( function() {
			new commentSrv().ins('',`&uniqueid=${ID.uniqueid}&comment=${ID.comment}`, cb => { console.log(cb); });
		}, 1000);
	};
	
	//EXPORT CDR TO CSV
	$scope.cdr_export = function(){
		var arr_cdr_return = [];
		$scope.cdr = orderByFilter($scope.cdr , $scope.sort.column, $scope.sort.descending);
		angular.forEach($scope.cdr, todo => {
							if(todo.dst == '~~s~~') { dst = $filter('fix_chan')(todo.lastdata, '/',2)  } else var dst = todo.dst;
							var dstchannel = $filter('fix_chan')(todo.dstchannel, '-',0); dstchannel = $filter('fix_chan')(dstchannel, 'SIP/',1);
							var disposition = $filter('status')(todo.disposition);
							var cdr_ret = { "Дата"			: todo.nicedate,
											"Кто"			: todo.src,
											"Куда"			: dst,
											"Направление"	: dstchannel,
											"Статус(секунд)": disposition + "(" + todo.billsec + ")",
											"Ожидание"		: todo.servicelevel 
										   };
			arr_cdr_return.push(cdr_ret);
                        });
		return arr_cdr_return;   
	};
	
	//Update Chart Type
	$scope.TypeGraph = function(ID)
	{	 
		$scope.chartConfig.options.chart.type = ID;
		$scope.chartConfig2.options.chart.type = ID;
		$scope.chartConfig3.options.chart.type = ID;
		$scope.chartConfig5.options.chart.type = ID;
	};
	$scope.chart_type = 'spline';
	$scope.TypeGraph($scope.chart_type);
	$scope.typegraph = ['areaspline','spline','line','area','column','bar','scatter'] ;
	
	//SORTING TABLE
	 $scope.sort = {
            column: 'calldate',
            descending: true
    };

	$scope.changeSorting = function(column) {
        var sort = $scope.sort;
        if (sort.column == column) {
            sort.descending = !sort.descending;
        } else {
            sort.column = column;
            sort.descending = false;
        }
    };
}
 
 
