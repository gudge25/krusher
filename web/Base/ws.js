var socket = false;
var ws;
var FACTOR;
var debounceWS;
var debounceWS2;
var dWS;
var ModalOpen = false;
var QtyEmpQueue = 0;
class WSAction{
    constructor() {
        [this.sip,this.LoginName,this.user] = [SIP,USERNAME, { sip: `${SIP}`, loginName: `${USERNAME}` }];
    }

    connect(){
        let url = window.location.protocol == "https:" ? API.wss: API.ws;
        socket = new ReconnectingWebSocket(url, "soap", {debug: false,reconnectInterval:3000,maxReconnectAttempts:20,automaticOpen:true});
    }

    loguot(){
        console.log(`WS logout`);
        socket.close();
    }

    /* Do not touch */
    login(){

        // this.AID        = this.sip.split("_", 2)[1] ;
        // console.log(this.AID);
        this.jsn   = {
            'action': 'join',
            'user': this.user
        };
        this.sendnew();

        socket.onmessage = event => {
            if(event.data) {
                let ev      = JSON.parse(event.data);
                var scope   = angular.element(document.getElementById('autocall')).scope();
                var Client  = angular.element(document.getElementById('wsPopupCtrl')).scope();
                var TrunkAll = angular.element(document.getElementById('TrunkAll')).scope();
                var Dashboard = angular.element(document.getElementById('Dashboard')).scope();
                function startWs(){
                                                    if( dWS == 1 ){
                                                        clearTimeout(debounceWS2);
                                                        debounceWS = setTimeout(() => {
                                                            console.log('START while');
                                                            new WSAction().ProgressStart(FACTOR);
                                                            scope.ACall(true);
                                                        }, 2000);
                                                    }
                                                    else
                                                        clearTimeout(debounceWS);
                                   }

                function UpdProcces(ev) {
                    console.log(`UpdProcces`);
                    //update stop prosse in web
                                                    // let a                   = scope.Progress;
                                                    // a.FFF.process           = 101603;
                                                    // a.FFF.errorDescription  = ev.data;
                                                    // if(scope.Progress.FFF.id_autodial) new astAutoProcessSrv().upd(a.FFF,cb => { scope.AutoStatus(); });
                    scope.AutoStatus();
                }

                //FOR EVENTS
                switch(ev.event){
                    case "coreshowchannels" :  {  if(ev.data) if(Dashboard) if(Dashboard.CoreShowChannels) { Dashboard.CoreShowChannels = ev.data; Dashboard.$apply(); } break; }

                    case `QueueMemberPause` : { if(ev.data) if(scope) if(scope.QueueSummary) { scope.QueueSummary(ev.data); } break; }
                    case `QueueSummary`     : { if(ev.data) if(scope) if(scope.QueueSummary) { scope.QueueSummary(ev.data); } break; }
                    case "progress-end"     : 	{   //END
                                                // scope.ACall(false);
                                                //STOP if ERROR
                                                if(ev.data) {
                                                    //alert(`Ошибка автообзвон!`,`${ev.data} <br/> ${ev.event}`,`warning`);
                                                    clearTimeout(debounceWS);
                                                    dWS         = 0;
                                                    QtyEmpQueue = 0;
                                                    //update stop prosse in web
                                                    UpdProcces(ev);
                                                }
                                                // //START NEW WHILE
                                                // else
                                                // {
                                                //     if(ModalOpen)
                                                //     {   console.log(`NBR while stop if open window`);
                                                //         clearTimeout(debounceWS);
                                                //         dWS = 0;
                                                //     }
                                                //     QtyEmpQueue=0;
                                                //     startWs();
                                                // }
												break;
                                            }

                    // case "Newstate"         :   {   if(ev.phone.length > 4) { ev.dcStatusName=`RINGING`; Client.open(ev); } break; }
                    // case "NewstateEnd"      :   {   Client.Cancel(ev);       break; }
                    // case "NewstateEndAll"   :   {   Client.Cancel(ev);       break; }

                    case "bridge"       : 	{   if(ev.phone.length > 4) { ev.dcStatusName=`UP`; Client.open(ev); scope.CallBridge(); } break;}
                    
                    case "joined"       : 	{ 	break; }
                    case "err"          : 	{   
                                                console.log('Error case fow WS');
                                                dWS = 0;
                                                if(ev.data) {
                                                    let mess = typeof ev.data === 'object' && 'message' in ev.data ? ev.data.message  : ev.data;
 													alert(`Звонок остановлен! ${mess}`,`warning`);
												}
                                                break;
											}
                    case "devicestatechange"       :   { 
                                                        //FOR menu indication
                                                        if(scope) if(scope.devicestatechanges) scope.devicestatechanges(ev.dev_state); 
                                                        
                                                        //FOR CLOCE WS MODAL if ringing end
                                                        //if(ev.dev_state == "NOT_INUSE") Client.Cancel(ev);
                                                        break; }

                    case "Registry"                :   { if(TrunkAll) if(TrunkAll.AmiEvents) TrunkAll.AmiEvents(ev); break; }
                    case "PeerStatus"              :   { if(TrunkAll) if(TrunkAll.AmiEvents) TrunkAll.AmiEvents(ev); break; }
                    // case "QueueMemberStatus"       :   { if(TrunkAll.AmiEvents) TrunkAll.AmiEvents(ev); break; }

                    case "DialBegin"    :   { scope.AmiEvents(ev); break; }
                    case "hangup"       :   {   //console.log(ev.CallType);
                                                if(ev.CallType)
                                                    if(ev.CallType == "101318")  scope.CallEnd();
                                            //{"event":"hangup","CallType":"101318",
                                           // "data":{"event":"Hangup","privilege":"call,all",
                                           //"channel":"SIP/pbx.asterisk.biz.ua_10-000175f8","channelstate":"0","channelstatedesc":"Down","calleridnum":"380978442044",
                                           //"calleridname":"CC","connectedlinenum":"380978442044","connectedlinename":"CC","language":"ru","accountcode":"","context":"incoming_10",
                                           //"exten":"380978442044","priority":"1","uniqueid":"1542719608.216786","linkedid":"1542719608.216784","cause":"17","cause-txt":"User busy"}}

                                            break; }
                    default             : 	{  /* console.log(`=========Default event========`); console.log(ev);*/  break; }
                }
            }
        };
        return this;
    }

    call(a){
        a.phone = a.Phone   ? a.Phone : a.ccName;
        //dcID for new cc
        a.dcID  = lookUp(API.us.Sequence, 'dcID').seqValue;
        this.jsn = {
            action: `call`,
            source: a, //{ clID: `${a.clID}`, phone: `${phone}` },
            exten: `${this.sip}`
        };
        this.sendnew();
        return this;
    }

    //Autocall start for user
    ProgressStart(a){
        FACTOR = a;
        let factor  = a.FFF.factor               ? a.FFF.factor   : 1;
        let exten   = a.FFF.exten                ? a.FFF.exten    : this.sip;
        let Action  = this.sip == a.FFF.exten    ? `progress`     : `autocall`; //choise type autocall - isSip or isQueue
        dWS         = 1;
        this.jsn = {
            action: Action,
            //ffID        : a.FFF.ffID,
            exten       : exten,
            factor      : factor,
            context     : a.FFF.context,
            id_autodial : a.FFF.id_autodial,
            id_scenario : a.FFF.id_scenario,
            url: `http://${USERNAME}:${PASSWORD}@${window.location.hostname}:${window.location.port}/api/ast/autodial/process/autocall`
        };
        this.sendnew();
        return this;
    }

    ProgressStop(){
        dWS         = 0;
        QtyEmpQueue = 0;
        clearTimeout(debounceWS);
        this.jsn = {
            action: `progress-stop`
        };
        this.sendnew();
        return this;
    }

    Support(a){
         this.jsn = {
            action: `Support`,
            param : a
        };
        this.sendnew();
        return this;
    }

    Action(a,param){
        this.jsn = {
            action: `${a}`,
            param
        };
        this.sendnew();
        return this;
    }

    //Disconect call
    Hangup(data){
        this.jsn = {
            action: `hangup`,
            phone:   data
        };
        this.sendnew();
        return this;
    }

    sendnew(){
        if(socket) if(socket.readyState == 1) socket.send(JSON.stringify(this.jsn));
    }
}

wsStart = () => {
    ws = new WSAction();
    ws.connect();
    socket.onopen = () => {  ws.login(); };
};