class BaseViewModel {
    constructor($scope, $filter, service, $translate, AclService) {
        if(!USERNAME && !PASSWORD && window.location.hash != "#!/login" && window.location.hash != "#!/Register" && this.constructor.name != MenuViewModel) { console.log(window.location.hash); GoTOAuth();  }

        [ this.scope, this.filter, this.service , this.translate, this.AclService] = [ $scope, $filter, service, $translate, AclService];

            //Infinite scroll
            [ this.scope.limit, this.scope.canLoad ] = [ 25, true ];

            this.scope.WS = socket;
            //Company info
            // if(USERNAME && PASSWORD){
            //     new orgSrv().getFind({ clID :0 },cb => { $scope.BaseOrg      = cb[0];});
            //     new crmAddressSrv().getFind({ clID :0 },cb => { $scope.BaseAddress  = cb[0];});
            //     new crmContactSrv().getFind({ clID :0 },cb => { $scope.BaseContacts = cb[0];});
            // }
            //Version
            this.scope.version      = `4.8.14`;
            //this.scope.versionDate  = `2019.06.05`;
            this.scope.hostname     = window.location.hostname;
            this.scope.sipport      = 5070;

            $scope.LogOut = () => {
                ClearAuth();
                AclService.clearUserIdentity();
                [this.scope.auth.FFF,window.location] = [null,'/#!/login'];
            };

            //FOR PRINT TEMPLATE
            this.scope.invoice_terms_conditions = ' - Рахунок дійсний протягом 7 календарних днів з дати його виставлення, якщо інше не обумовлено в письмовій формі.';
            this.scope.orgDirector          = 'Жданов Д. І.';
            this.scope.orgName              = `ФОП Жданов Дмитро Іванович`;
            this.scope.orgBillingAddress    = `вул. Кургузова, 1-А, Корпус 3, кв. 158`;
            this.scope.orgPhone             = `+380978442044`;
            this.scope.orgInn               = `3201405116`;
            this.scope.orgBankId            = `380775`;
            this.scope.orgBankAccount       = `26003056128147`;
            this.scope.orgBankName          = `Ф-Я "КИЇВСІТІ" ПАТ " КБ "ПРИВАТБАНК", м. Київ`;

            //DATAPIKER
            [this.scope.inlineOptions,this.scope.dateOptions,this.scope.datepicker,this.scope.format] = [{ minDate: new Date() },{ startingDay: 1, showWeeks: false },{ opened: false },"yyyy-MM-dd"];

            //uiSelect
            [this.scope.uiSelectClass,this.scope.uiSelectClassValidation] = ['normal',{class:'normal',dirty:false,valid:true}];
            this.scope.uiSelectSetClass = () => {
                let uS = this.scope.uiSelectClassValidation;
                uS.class = uS.valid !== undefined ? `normal`        :  `invalid-ui-select` ;
            };

            //using in modal version for select row
            this.scope.idSelected = null;
            this.scope.setSelected = s => { $scope.idSelected = s; };

            //CAN
            if(AclService && AclService !== undefined && USERNAME && PASSWORD) this.scope.can = AclService.can;
            
            if(window.location.hash === '#!/login') this.scope.login = true;

            this.scope.gmt = [0,1,2,3,4,5,6,7,8,9,10,11,12,-12,-11,-10,-9,-8,-7,-6,-5,-4,-3,-2,-1];
            this.scope.Pagintion = () => {
                this.scope.oldPage = this.scope.CurrentPage;
                this.scope.model.CurrentPage = this.scope.model.CurrentPage ? this.scope.model.CurrentPage : 1;
                this.scope.CurrentPage  = this.scope.model.CurrentPage ;
                this.scope.model.offset = (this.scope.model.CurrentPage * this.scope.model.limit) - this.scope.model.limit ;
                this.scope.NextPage = (this.scope.model.offset + this.scope.model.limit ) / this.scope.model.limit ; 

                if(this.scope.NextPage != this.scope.oldPage)
                    this.Find();
            };
            this.scope.PagintionItems = () => {
                this.scope.oldPageItems = this.scope.CurrentPageItems;
                this.scope.modelItems.CurrentPage = this.scope.modelItems.CurrentPage ? this.scope.modelItems.CurrentPage : 1;
                this.scope.CurrentPageItems  = this.scope.modelItems.CurrentPage ;    
                this.scope.modelItems.offset = (this.scope.modelItems.CurrentPage * this.scope.modelItems.limit) - this.scope.modelItems.limit;
                this.scope.NextPageItems = (this.scope.modelItems.offset + this.scope.modelItems.limit ) / this.scope.modelItems.limit ; 
                
                if(this.scope.NextPageItems != this.scope.oldPageItems)
                    this.Find(this.scope.ItemsSrv);
            };
            
            this.scope.limitList = [{ Name: 10},{ Name: parseInt(15)},{ Name: 20},{ Name: 25},{ Name: 50},{ Name:75},{ Name: 100}];
            this.scope.dayList =  [{ Name: `Mon`, ID: 1},{ Name: `Tue`, ID: 2},{ Name: `Wed`, ID: 3},{ Name: `Thu`, ID: 4},{ Name: `Fri`, ID: 5},{ Name: `Sat`, ID: 6},{ Name: `Sun`, ID: 7}];
            this.scope.monList =  [{ Name: `Jan`, ID: 1},{ Name: `Feb`, ID: 2},{ Name: `Mar`, ID: 3},{ Name: `Apr`, ID: 4},{ Name: `May`, ID: 5},{ Name: `Jun`, ID: 6},{ Name: `Jul`, ID: 7},{ Name: `Aug`, ID: 8},{ Name: `Sep`, ID: 9},{ Name: `Oct`, ID: 10},{ Name: `Nov`, ID: 11},{ Name: `Dec`, ID: 12}];

            this.scope.SipNatList =  [ { Name: null, ID: null },{ Name: `no`, ID: 1},{ Name: `force_rport`, ID: 2},{ Name: `comedia`, ID: 3},{ Name: `auto_force_rport`, ID: 4},{ Name: `auto_comedia`, ID: 5},{ Name: `force_rport,comedia`, ID: 6}];

            //INIT DATA POOL

            this.scope.employees    = FactEmRun.name;
            this.scope.Enums        = FactEnumRun.name;
            this.scope.EnumsGroup   = _.groupBy(this.scope.Enums.data , 'tyID');

            this.scope.Scenario     = FactScenarioRun.name;
            this.scope.File         = FactFileRun.name;
            this.scope.Regions      = FactRegionsRun.name;
            this.scope.Countries    = FactCountriesRun.name;
            this.scope.Operators    = FactOperatorRun.name;
            this.scope.Trunk        = FactTrunkRun.name;
            this.scope.Sips         = FactSIPRun.name;
            this.scope.Queues       = FactQueuesRun.name;
            this.scope.IVR          = FactIVRRun.name;
            this.scope.Record       = FactRecordRun.name;
            this.scope.Prefix       = FactPrefixRun.name;
            this.scope.Bases        = FactBasesRun.name;
            this.scope.Tags         = FactTagRun.name;
            this.scope.Role         = FactRoleRun.name;
            //this.scope.Proccess     = FactProccess.name;
            this.scope.docsTypes    = FactDocsTypesRun.name;
            this.scope.TTS          = FactTTSRun.name;
            this.scope.TrunkPool    = FactTrunkPoolRun.name;
            this.scope.CustomDestenation    = FactCustomDestenationRun.name;
            this.scope.Proccess     = FactProccessRun.name;
            this.scope.TimeGroup    = FactTimeGroupRun.name;
            this.scope.CallBack     = FactCallBackRun.name;
            this.scope.Company      = FactCompanyRun.name;
            this.scope.RouteOut     = FactRouteOutRun.name;
            this.scope.Conference   = FactConferenceRun.name;
            this.scope.FormType     = FormTypeRun.name;
            this.scope.MarketPlace  = FactMarketPlaceRun.name;

            this.scope.global = {
                checkAll: false,
                Loading: false
            };

            this.scope.rate = {
                val: 0,
                max: 10,
                overStar: 0,
                isReadonly:false,
                percent: 0,
                hoveringOver : value => {
                    this.scope.rate.overStar = value;
                    this.scope.rate.percent = 100 * (value / this.scope.rate.max);
                }
            };

            this.scope.showSMSsingle = false;           
    }

    showSMS(){
        new mpMarketplaceInstallSrv().getFind({ mpID : 1, isActive: true }, cb => { 
            if(cb.length > 0) { 
                this.scope.showSMSsingle = true; this.scope.SMSoriginame = cb[0].data1; this.scope.$apply(); 
            }
        });
    }

    smsSingle(a){
        delete a.dcID;
        new smsSingleSrv().ins(a, cb => {  } );
    }
    // $scope.Pause = { AllBtn : false };
    // $scope.PauseAll = a => {
    //     angular.forEach($scope.Queues.myQueues,todo => {
    //         console.log($scope.Pause.AllBtn);
    //         if(isBoolean(a)) $scope.Pause.AllBtn = isBoolean(a) ? Boolean(a) : true; 
            
    //         todo.isPause = $scope.Pause.AllBtn; 
    //         console.log(`PauseAll`);
    //         console.log(todo);
    //         $scope.manyAction.AMI('QueuePause',todo);
    //     });
    // };

    // $scope.PauseSingl = param => {
    //     if(param) $scope.manyAction.AMI('QueuePause',param);
    //     let Qty = 0;
    //     angular.forEach($scope.Queues.myQueues,todo => {
    //         if(todo.isPause) Qty++;
    //     });
    //     if(Qty == $scope.Queues.myQueues.length)  $scope.Pause.AllBtn = true;
    //     if(Qty == 0)   $scope.Pause.AllBtn = false;
    // };
    ACLRoles(){
         if(this.AclService.getRoles().length === 0){
            const [a,b,c,d,e,g] = ['Admin','Supervisor','Operator','Developer','Client','Validator'];
            this.AclService.addRole(c)
            .addRole(b,c) //Supervizor
            .addRole(g,c) //Validator
            .addRole(a,b) //ADMIN role
            .addRole(d,a) //Developer
            .addRole(e); //Client
        }
    }
    

    isActive(){
        var s  = this.service;
        clearTimeout(this.debounceisActive);
        this.debounceisActive = setTimeout(() => {
            //console.log(`start update`);
            var  data  =  this.scope.data.filter( a => a.isEdit);
            let x = angular.forEach(data,todo => {
                        s.upd(todo);
            });
        }, 2000);
    }

    //todo[s.IdName]
    addItems(){
        this.scope.global.NewProgerss = true;
        if(!this.scope.Items) this.scope.Items = [];
        let p = new this.scope.ItemsModel(this.scope.modelItems).put();
        this.scope.Items.push(p);
    }

    ItemsEdit(url){
        this.scope.global.Loading=true;
        this.scope.isEdit=false;
        console.log(url);
        var brake = false;
        angular.forEach(this.scope.Items, row => {
                if(url == `RouteOut`)   if(!row.pattern)    brake = true;
                if(url == `TrunkPool`)  if(!row.trID)       brake = true;
                if(url == `IVR`)        if(!row.extension)  brake = true;
                if(url == `Queue`)      if(!row.emID)       brake = true;
                if(url == `formEdit`)   if(!row.qName)       brake = true;

                if(!brake)
                //if(row[this.service.IdName])
                if(row[this.scope.ItemsSrv.IdName])
                    this.scope.ItemsSrv.upd(row, () => {   this.scope.global.Loading=false; this.scope.isEditItems=false; this.scope.global.NewProgerss = false; if(url) window.location = `/#!/${url}`; else this.Find(this.scope.ItemsSrv); });
                else
                    this.scope.ItemsSrv.ins(row, () => {   this.scope.global.Loading=false; this.scope.isEditItems=false; this.scope.global.NewProgerss = false; if(url) window.location = `/#!/${url}`; else this.Find(this.scope.ItemsSrv); });
                brake = false;
                this.scope.isEditItems=false; this.scope.global.NewProgerss = false;
        });
    }

    ClearFilter(a){
        a = a ? a : {};
        this.scope.model = new this.service.Model(a).postFind();
        this.Find();
    }

    Find(s){
            const self = this;
            const isItems = s ? true : false;
            var a = {};
            s = s ? s : this.service;
            a = isItems ? this.scope.modelItems : this.scope.model;

            if(isItems){
                this.scope.Items    = [];
            } else {
                this.scope.data     = [];
            }

            this.scope.dataIsChecked        = 0;
            this.scope.global.checkAll      = false;
            this.scope.global.Loading       = true;

            if(this.scope.order)    {
                a.field = this.scope.order;
                a.sorting = this.scope.reverse? `ASC` : `DESC`;
            }
            //DEBOUNCE!
            let time = this.debounceFind ? 500 : 0;
            clearTimeout(this.debounceFind);
            this.debounceFind = setTimeout(() => {
                    // console.log(s);
                    // console.log(this.service);
                    s.getFind(a, (cb,status,request) => {
                        // console.log(isItems)
                        // console.log(cb)
                        if(isItems)
                            self.scope.Items = cb;
                        else
                            self.scope.data = cb;

                        self.scope.total_count = request.getResponseHeader(`total-count`);
                        self.scope.global.Loading = false;
                        self.scope.$apply();
                    });
            }, time);
     }

    isChecked(){
        this.scope.dataIsChecked=0;
        if(this.scope.data)if(this.scope.data.length)   this.scope.data.forEach(  e => { if(e.isChecked) this.scope.dataIsChecked++; });
        if(this.scope.Items)if(this.scope.Items.length) this.scope.Items.forEach( e => { if(e.isChecked) this.scope.dataIsChecked++; });
    }

    // orderByMe(x, r){
    //     this.scope.reverse = r === 'reverse' ? true : false; this.scope.order = x;
    // }

    order(a){
        if(!this.scope.global.NewProgerss){
            this.scope.order = a;
            this.scope.reverse = this.scope.reverse ? false : true;
            this.Find(this.scope.ItemsSrv);
        }
    }

    //Refresh Products for modal
    refreshProducts(){
      this.scope.ProductNames = [];
      new stProductFindSrv().ins('', cb => {
        this.scope.Products = cb;
        angular.forEach(this.scope.Products,item => this.scope.ProductNames.push(item.psName)  );
      });
      this.scope.$apply();
    }

    //FOR PRINT TEMPLATE
    BaseSum(a){
                var [sum,AllQty] = [0,0];
                angular.forEach(a, todo => {
                    if(todo.iPrice > 0 && todo.iQty > 0) sum = sum+(todo.iPrice*todo.iQty);
                    if(todo.iQty > 0) AllQty = AllQty+todo.iQty;
                });
                return {'Sum':sum,'Discount':0,'Tax':0,'Total':sum,'AllQty':AllQty};
    }

    changeLanguage(a){
                if(a === null) a = `ru`;
                this.translate.use(a);
                this.translate.proposedLanguage();
                this.scope.lang = a;
                localStorage.setItem("Language", a);
    }

    //Для + - сварачивания елементов в меню слева
    xCheck(a){
        return a.length > 5  ? false : true ;
    }

    loadMore(max){
        if( max >= this.scope.limit || max === undefined) {
            this.scope.limit = this.scope.limit + 10;
            if(this.scope.limit > max) this.scope.limit = max;
        }
    }

    Save(data,url){
        var s   = this.service;
        s.ins(data,() => {
            let scope   = angular.element(document.getElementById('autocall')).scope();
            if(url == `Scenario`) scope.Start();
            if(window.location.hash == "#!/Register")  window.location = `//${data.Domain}.krusher.biz/#!/login`;
            else
            if (url) window.location = `/#!/${url}`;
        });
    }

    Update(a,url,b){
        var s   = this.service;
        if(b) s = b;
        s.upd(a,() => { window.location = `/#!/${url}`; });
    }

    manyClear(items,s){
        s = s ? s : new fsFileClaerSrv();
        let x = angular.forEach(items,(todo,index) => {
            if(todo.isChecked){
                if(todo[s.IdName]){
                    s.del(todo[s.IdName]);
                }
                d = true;
            }
        });
        if(!d) alert('Вы ничего не выбрали!');
    }

    manyDelete(items,s){
        console.log(items);
        
        const isItems = s ? true : false;
        s = s ? s : this.service;
        console.log(s);
        let d  = false;
        let f  = false;
        let x = angular.forEach(items,(todo,index) => {
            if(todo.isChecked){
                //console.log(todo)
                if(todo[s.IdName] || todo[s.IdName] == 0){
                    s.del(todo[s.IdName]);
                }
                else { items.splice(index, 1); f = true; }
                d = true;
                this.scope.isEditItems=false; this.scope.global.NewProgerss = false; this.isChecked();
            }
        });
        $.when(x).done( () => { setTimeout(() => {
            let a = isItems ? this.scope.modelItems : this.scope.model;
            if(a === undefined) a = {};
            this.scope.dataIsChecked        = 0;
            this.scope.global.checkAll      = false;
            this.scope.global.Loading       = true;
            if(!f)
            if(isItems)
                this.Find(s);
                //s.getFind(a, cb => { this.scope.Items = cb; this.scope.$apply(); }).error( () => { s.getAll( cb => { this.scope.Items = cb; this.scope.$apply(); }); } );
            else
                this.Find();
                //s.getFind(a, cb => { this.scope.data = cb; this.scope.$apply(); }).error( () => { s.getAll( cb => { this.scope.data = cb; this.scope.$apply(); }); } );
        }, 700); });
        if(!d) alert('Вы ничего не выбрали!');
    }

    delete(){
        let [ s, d ] = [ this.service, false ];
        let x = angular.forEach(this.scope.data, todo => {
            if(todo.isChecked){
                s.del(todo[s.IdName]);
                d=true;
            }
        });
        s.getFind({}, cb => { this.scope.data = cb; this.scope.$apply(); }).error( () => { s.getAll( cb => { this.scope.data = cb; this.scope.$apply(); }); } );
        if(!d) alert('Вы ничего не выбрали!');
    }

    selectAll(){
       let c = this.scope.global.checkAll;
       if(this.scope.data)if(this.scope.data.length)    this.scope.data.forEach(  e => { e.isChecked = c; });
       if(this.scope.Items)if(this.scope.Items.length)  this.scope.Items.forEach( e => { e.isChecked = c; });
    }

    SearchClient(a){
        return new crmClientSearchSrv().get(a);
    }

    SearchProduct(a){
        return new stProductFindSrv().getFind({ psName: a });
    }

    // SearchSip(){
    //      new astSippeersSrv().getFind({}, cb => { this.scope.sipAll = cb; });
    // }

    Call(a,clID){
        if(a && socket){
            // console.dir(a);
            // console.log(`Call to ${a.ccName}`);
            // console.dir(this.scope.HotDial);
            //{"action":"call","source":{"ccName":"380978442044","coID":null,"isDial":true,"isBridge":false,"phone":"380978442044"},"exten":"500_10"}
            this.scope.HotDial.FFF.ccName = a.ccName;
            this.scope.HotDial.FFF.isDial = true;
            new WSAction().call(a,clID);
            this.scope.call = a;
            setTimeout(() => { delete this.scope.call; this.scope.$apply(); }, 1000);
        }
    }

    ProgressStart(a){
        //if(this.scope.autocall ) if(`FFF` in this.scope.autocall) this.scope.autocall.FFF = true;
        if(this.scope.Progress.FFF.id_scenario){
            this.scope.Progress.FFF.process       = 101602;
            this.scope.Progress.FFF.emID          = EMID;
            this.scope.Progress.FFF.id_autodial   = lookUp(API.us.Sequence, 'id_autodial').seqValue;
            new astScenarioSrv().getFind({ id_scenario :this.scope.Progress.FFF.id_scenario },cb => {
                new astAutoProcessSrv().ins(this.scope.Progress.FFF, cb => {
                    this.scope.AutoStatus();
                    //new WSAction().ProgressStart(a);
                });
            });
        }
        else
            alert(`Ошибка автообзвон!`,`Not select id_scenario`,`warning`);
    }

    ProgressStop(){
        this.scope.Progress.FFF.process       = 101603;
        this.scope.Progress.FFF.errorDescription = this.scope.Progress.FFF.errorDescription ? `${this.scope.Progress.FFF.errorDescription} + User stop` : `User stop`;
        new astAutoProcessSrv().upd(this.scope.Progress.FFF, cb => {
            this.scope.AutoStatus();
            new WSAction().ProgressStop();
        });
    }

    Support(a){
        new WSAction().Support(a);
    }

    AMI(a,param){
         if(a && socket) new WSAction().Action(a,param);
    }

    Hangup(a){
        //console.log(a);
        if(a && socket) {
            new WSAction().Hangup(a);
            new WSAction().Hangup(SIP);
        }
    }

    TypeProgress(a){
        if(a){
            let type;
            if (a < 25)         type = 'primary';
            else if (a < 50)    type = 'info';
            else if (a < 75)    type = 'warning';
            else if (a <= 100)  type = 'success';
            else type = 'primary';
            return type;
        }
    }
    TypeProgress2(val,max){
        if(val && max){
            let a = parseInt(max)/parseInt(val)*100;
            //console.log(a);
            let type;
            if (a < 25)         type = 'success';
            else if (a < 50)    type = 'info';
            else if (a < 75)    type = 'warning';
            else if (a <= 100)  type = 'danger';
            else type = 'primary';
            return type;
        }
    }

    MonitorUrl(a,dir){
        if(a){
            if(!dir) dir =  `monitor`;
            let match;
            let url         = `https://${window.location.hostname}:${window.location.port}/${dir}/`;
            var format =  a.split('.').pop(-1);
            if(format == "wav" || format == "mp3" || format == "gsm" || format == "gsm") { match = true; } else { match = false; format =  "ogg"; }
            if (a !== undefined && a !== null){
                return match ? `${url}${a}` : `${url}${a}.${format}`;
            }
        }
    }

    GoogleMap(a){
        if(a) window.open(`//google.com.ua/maps/place/${a}`,"_blank");
    }

    goToDoc(id,type){
        if(id){
            //this.scope.MenuSearchLoad = true;
            goToDoc(id,type,this.scope);
        }
    }

    goTo(url){
         if(url) window.location = `/#!/${url}`;
    }

    Check_upd_old(){
        return angular.equals(this.scope.upd_old, this.scope.upd) && angular.equals(this.scope.upd_old2, this.scope.upd2) ? true : false;
    }
}