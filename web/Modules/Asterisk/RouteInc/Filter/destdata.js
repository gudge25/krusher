crmUA.filter('destdata', function() {
    return (dstD,dst) => {
        let a = null;
        if(dstD) 	dstD = parseInt(dstD);
		if(dst) 	dst  = parseInt(dst);
        if(dstD && dst)
        switch(parseInt(dst)){
				case 101401       : { let d = FactQueuesRun.name; 				angular.forEach(d.data,	todo => { if(todo.queID == dstD) 		{  a = todo.name; } }); 			break; }	//Queues
				//exten
				//case 101402       : { let d = FactSIPRun.name; 					angular.forEach(d.data,	todo => { if(todo.sipID == dstD) 		{  a = todo.sipName; } }); 			break; } 	//Extensions
				case 101402       : { let d = FactEmRun.name; 					angular.forEach(d.data,	todo => { if(todo.emID == dstD) 		{  a = todo.emName; } }); 			break; } 	//Extensions
				case 101403       : { let d = FactTrunkRun.name; 				angular.forEach(d.data,	todo => { if(todo.trID == dstD) 		{  a = todo.trName; } }); 			break; }    //Trunks
				case 101404       : {  break; }    //Terminate Call
				case 101405       : { let d = FactIVRRun.name; 					angular.forEach(d.data,	todo => { if(todo.id_ivr_config == dstD){  a = todo.ivr_name; } }); 		break; }    //IVR
				case 101406       : { let d = FactScenarioRun.name; 			angular.forEach(d.data, todo => { if(todo.id_scenario == dstD) 	{  a = todo.name_scenario; } }); 	break; }    //Scenario
				case 101407       : { let d = FactRecordRun.name; 				angular.forEach(d.data,	todo => { if(todo.record_id == dstD) 	{  a = todo.record_name; } }); 	break; }    //Record
				case 101408       : { let d = FactCustomDestenationRun.name; 	angular.forEach(d.data,	todo => { if(todo.cdID == dstD) 		{  a = todo.cdName; } }); 			break; }    //CD
				case 101409       : { let d = FactTrunkPoolRun.name; 			angular.forEach(d.data,	todo => { if(todo.poolID == dstD) 		{  a = todo.poolName; } }); 		break; }    //TrunkPool
				case 101410       : { let d = FactTimeGroupRun.name; 			angular.forEach(d.data,	todo => { if(todo.tgID == dstD) 		{  a = todo.tgName; } }); 			break; }    //TrunkPool
				case 101411       : { let d = FactCallBackRun.name; 			angular.forEach(d.data,	todo => { if(todo.cbID == dstD) 		{  a = todo.cbName; } }); 			break; }    //TrunkPool
				case 101412       : { let d = FactConferenceRun.name; 			angular.forEach(d.data,	todo => { if(todo.cfID == dstD) 		{  a = todo.cfName; } }); 			break; }    //TrunkPool
				default           : break ;
	    }
        return a;
    };
});
