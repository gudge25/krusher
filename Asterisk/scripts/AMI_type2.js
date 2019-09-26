var sleep 	= require('sleep');
var sql 	= require('mssql');
var config = {
    user				: 'asterisk',
    password			: '78945612Qwe',
    server				: '192.168.10.8',
    database			: 'AsteriskDBSlave',
    stream				: false,
	connectionTimeout	: 300000,
	idleTimeoutMillis	: 300000,
	requestTimeout		: 300000,
	max					: 100
}
var end 		= 0;
var ARR 		= []; //declare json array
var ARR_answer 	= [];
var err_res;
var duration 	= 60000;
var timeout  	= duration
var d 			= new Date();
var weekday 	= new Array(7);
weekday[0]		= "Sunday";
weekday[1] 		= "Monday";
weekday[2] 		= "Tuesday";
weekday[3] 		= "Wednesday";
weekday[4] 		= "Thursday";
weekday[5] 		= "Friday";
weekday[6] 		= "Saturday";
var n			= weekday[d.getDay()];
var count_answer 	= 0;
var count_operator	= 0;
var TypeModule 		= 0;
var count_hangup 	= 0;
var maxcall			= 0;

var SETTINGS = function(){
	console.log("UPDATE SETTINGS");
	sql.connect(config, function(err) {
		var request = new sql.Request();
		request.stream = true;
		request.query("select * from Module_AD where type = 2");
		request.on('row', function(row) {
			//SET Type
			TypeModule = row.type;
			//WEEKDAY
			var date = new Date();
			var dateweek = date.getDay()
			var weekday_c = row.weekday.split(",");
			var week_enable = false;

			for(var i = 0;  i < weekday_c.length ; i++) {
					if(dateweek == weekday_c[i]) var week_enable = true;
				}

			//START - END HOUR
			var hours 	= date.getHours();
			hours_enable = false;
			if( hours >= row.start_hour && hours <= row.end_hour) hours_enable = true;

			//MAXDURATION
			duration = 'L('+row.maxduration+')';
			timeout  = Math.floor(row.maxduration / 1000)

			end_old 	= end;
			end 		= row.maxcall;
			maxcall 	= row.maxcall;

			if(row.enabled == 0) end = 0;
			if(row.enabled == 1 && week_enable && hours_enable ) 	//ENABLED and  hours
			{	//Starp Call Type 2
				if( TypeModule == '2')
				{
				//if(  row.maxcall != 0 && end_old != row.maxcall)								//MAXCALL
				if(  row.maxcall != 0)
					GetMember(row,"type 2");
				}
			}
			else end = 0;

		 })
		request.removeListener('row', 	function(){  })
		setTimeout(function(){ SETTINGS() },10000);
	});
}
SETTINGS();



var START = function(type,member){
	sql.connect(config, function(err) {
		console.log();
		console.log('START SQL' )
		//console.log(end)
		var request2 = new sql.Request();
				request2.stream = false;
				request2.input('type', 2);
				request2.input('q', maxcall );
				console.log("exec [GetPhone0] @type=2, @q="+maxcall)
				request2.execute('GetPhone0', function(err, recordsets, returnValue) {

					if(recordsets && returnValue != -3 && recordsets[0] != [] && recordsets[0].length != 0){
						if(recordsets[0]){
							for(var i = 0;  i < recordsets[0].length ; i++) {

								var item = { "Phone" 	: recordsets[0][i].phone,
											 "Status" 	: "in process",
											 "Member"	: member
											}
								ARR.push(item);

								if( type == 'type 2') CALL2(recordsets[0][i],type,member)
							}
						}
					}
					else  //RESTART SQL IF null
					{ 	if(  count_operator != 0 &&  count_answer < count_operator)
						var timeoutProtect = setTimeout(function() {
						  timeoutProtect = null;
						  START(type,member);
						}, 10000);
					}
				});
	});
}

var GetMember = function(row,type ){
	var member =[ { "name": null } ];
	console.log();
	console.log('START Queues')
	count_operator = 0
	var ami2 = new require('asterisk-manager')('5040','192.168.10.12','wc','wc78945612Qwe', true);
	ami2.action({
	  'action'		: 'QueueStatus',
	  'queue'		: '10000',
	}, function(err, res) {
		var actionid = res.actionid;
		ami2.on('queuemember', 		function(evt) {  if(actionid == evt.actionid && evt.status == 1 && evt.paused == 0) {   //console.log(evt);

			member[count_operator].name = evt.name;
			count_operator++;

		}});
		ami2.on('queuestatuscomplete', 		function(evt) {
				if(actionid == evt.actionid)
				{	end_old2 = end;
					end = count_operator * row.maxcall;
					console.log("Свободный пилотов :" + count_operator);
					console.log("Call limit:" + end)
					console.log("end_old:" + end_old)
					console.log("row.maxcall:" + row.maxcall)
					console.log("count_answer:" + count_answer)
					console.log("arr:" + ARR.length)
					if( (end_old != row.maxcall || (row.maxcall == 1 && end_old == 1 && end_old == 1)) &&  (count_answer < count_operator && end != ARR.length))							//MAXCALL
					for(var i = 0 ;  i < count_operator ; i++) {
						START(type,member[i].name);
					}
				}
		});
		ami2.removeListener('queuemember', 	function(){})
	});
}
/* ------------------------------- ASTERISK  ----------------------------------*/
//TYPE2
var CALL2 = function(ID,type,member) {
	console.log('START CALL 2')
	var user = ID.phone;
	var ami = new require('asterisk-manager')('5040','192.168.10.219','wc','wc78945612Qwe', true);
	ami.action({
	  'action'		: 'originate',
	  'channel'		: 'Local/' + user + '@office145',
	  'context'		: 'office145',
	  'exten'		: 'queues10000',
	  'priority'	: 1,
	  'CallerID'	: 'Auto Dialler Module <'+user+'>',
	  'Account' 	: 'Module_AD_Type2',
	  'Async' 		: 'true',
	  'variable':{
					'duration': duration,
					'timeout': timeout
				  }
	}, function(err, res) {
		if(err) { console.log(err); err_res=true; } else err_res=false;	if(res) console.log(res.response + ' ' +user )
		var exit = true;
		ami.on('bridge', function(evt) {

			if(evt.bridgestate == 'Link' && evt.callerid2 == user && exit)
			{		exit = false;
					// Add to status Answer
					count_answer = 0;
					for(var i=0; i < ARR.length; i++) {
						if(ARR[i].Phone == user) 		ARR[i].Status = 'Answered';
						if(ARR[i].Status == 'Answered') count_answer++;
					}


					//HANGUP all not bridge chan
					if( count_answer >= count_operator || count_operator == 0)
						for(var i=0; i < ARR.length; i++) {
							if(ARR[i].Status != 'Answered')
							{
								ami.action({
											  'action'		: 'Hangup',
											  'channel'		: '/^Local/' + ARR[i].Phone + '@office145-.*$/'
								}, function(err, res) {})
							}
						}
			}
		})

		ami.on('hangup', 			function(evt) { if((evt.calleridnum == user || evt.connectedlinenum == user) && evt.channel.indexOf("SIP/DATAGROUP3") >= 0 ) //&&   evt.cause == 16
													{  	// console.log(evt.event + ' ' +evt.calleridnum )
													console.log(evt);
														for(var i=0; i < ARR.length; i++) {
															if(ARR[i].Phone !== undefined)
															if (ARR[i].Phone == evt.calleridnum)
															{
																console.log("Call limit:" + end + " Call in progres:" + ARR.length)
																if(ARR[i].Phone == user && ARR[i].Status == 'Answered' ) count_answer--;
																var del_phone = ARR[i].Phone;
																ARR.splice(i, 1);
																console.log("Clear:" + del_phone ); //+ " Массив:" + ARR



																var member_count = 0;
																for(var i=0; i < ARR.length; i++) {
																	if(ARR[i].Member == member) member_count++;
																}

																if(member_count == 0  && end != 0 && count_answer <= count_operator && ARR.length < end && count_operator != 0) START(type,member);
															}
														}
													}
			ami.removeListener('hangup', 	function(){ })
		});
	});

}

